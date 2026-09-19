#include "mod_ws2812b.h"

#include "keyled.h"

#include "mod_log.h"

#include "mod_ble.h"

#include "mod_wifi.h"

#include "mod_udp.h"

#include <USB.h>          // core 的 TinyUSB（USB/USBCDC）
#include "mod_usb.h"     // 我们的 USB HID 模块
USBCDC USBSerial;
extern USBHIDKeyboard usbkbd;


// 行/列脚数组：/gpio 页面也要读（所以不是 static，定义在本文件、声明在 mod_web.cpp）
#if mode_chosen==mode_arrow
byte rowPins[ROWS] = {PIN_KEY_Y0, PIN_KEY_Y1, PIN_KEY_Y2, PIN_KEY_Y3};
byte colPins[COLS] = {PIN_XN2, PIN_XN1, PIN_X0, PIN_X1};
#else
byte rowPins[ROWS] = {
PIN_KEY_Y0, PIN_KEY_Y1, PIN_KEY_Y2, PIN_KEY_Y3,
PIN_KEY_Y4, PIN_KEY_Y5, PIN_KEY_Y6, PIN_KEY_Y7
};
byte colPins[COLS] = {
PIN_XN2, PIN_XN1,
PIN_X0, PIN_X1, PIN_X2, PIN_X3,
PIN_X4, PIN_X5, PIN_X6, PIN_X7,
PIN_X8, PIN_X9, PIN_X10,PIN_X11,
PIN_X12,PIN_X13, PIN_X14, PIN_X15
};
#endif


struct _state{
  byte val;
  byte old;
  byte cnt;
  byte changed;
};
struct _state state[ROWS][COLS];
int cycle = 0;




#define PWM_FREQ 1000
#define PWM_RESOLUTION 10
#define TIMER_FREQ 1000000
#define TIMER_SETVAL 5000
hw_timer_t* timer = 0;
volatile int global_changed = 0;
void IRAM_ATTR ontimer(void* ptr)
{
  //read
  for(int j=0;j<COLS;j++){
    state[cycle][j].old = state[cycle][j].val;
    state[cycle][j].val = (digitalRead(colPins[j]) == HIGH);

    if(state[cycle][j].old == state[cycle][j].val){
      if(state[cycle][j].cnt < 100)state[cycle][j].cnt++;
    }
    else{
      state[cycle][j].cnt = 1;
      state[cycle][j].changed = 1;
      global_changed = 1;
      /*
       * 注意：这里是定时器 ISR，绝对不要用 kbdlog/Serial 打印
       * （环形缓冲要进临界区 + USB 写可能阻塞，会拖垮中断）。
       * 确实要看矩阵状态就把数据攒起来，搬到 loop()/casualloop 里打印。
      if(state[cycle][j].val == HIGH){
        USBSerial.printf("%d,%d: %d->%d\n", cycle, j, state[cycle][j].old, state[cycle][j].val);
      }
      else{
        USBSerial.printf("%d,%d: %d->%d\n", cycle, j, state[cycle][j].old, state[cycle][j].val);
      }
      */
    }
  }

  //clear
  digitalWrite(rowPins[cycle], LOW);

  //next
  cycle = (cycle+1) % ROWS;
  digitalWrite(rowPins[cycle], HIGH);
}

int currmode = 0;
void onpress(int x, int y)
{
  if(kbdlog_keylog())kbdlog.printf("press: %d %d\n", x, y);

  //右下角 4 个键是模式键：只切模式，不发键值
  if(kbd_is_modekey(x, y)){
    currmode = x - KBD_MODEKEY_COL0;
    ws2812b_press(x, y);
    kbdlog.printf("mode: %d (%s)\n", currmode, usbkbd_table_name(currmode));
    return;
  }

  ws2812b_press(x, y);

  //周期表模式在 usbkbd_press()/blekbd_press() 的 switch 里自己处理
  usbkbd_press(x, y);

  blekbd_press(x, y);

  wifi_udp_send(x, y);
}
void onrelease(int x, int y)
{
  if(kbdlog_keylog())kbdlog.printf("release: %d %d\n", x, y);

  ws2812b_release(x, y);

  if(kbd_is_modekey(x, y))return;   //模式键没发过键值

  usbkbd_release(x, y);

  blekbd_release(x, y);

  //wifi_udp_send(x, y);
}
void check_keyboard()
{
  if(0 == global_changed)return;
  global_changed = 0;

  for(int y=0;y<ROWS;y++){
    for(int x=0;x<COLS;x++){
      if(0 == state[y][x].changed)continue;
      state[y][x].changed = 0;

      if(state[y][x].val == 1){
        onpress(x, y);
      }
      else{
        onrelease(x, y);
      }
    }
  }

}

//this is realtime/urgent loop
void loop()
{
  //kbdlog.println(999);
  //setled();

  check_keyboard();
}

//this is nonrealtime/casual loop
void casualloop(void* param)
{
  int ble_conn_last = -1;
  int ble_adv_last = -1;
  uint32_t stat_tick = 0;

  for(;;){
    while(USBSerial.available() > 0) {
      String incomingMessage = USBSerial.readStringUntil('\n');
      USBSerial.println(incomingMessage.c_str());
    }

    //蓝牙状态变化：连不上时这里最有信息量
    int ble_conn = blekbd_is_connected() ? 1 : 0;
    if(ble_conn != ble_conn_last){
      kbdlog.printf("ble: %s (peers=%d advertising=%d heap=%u)\n",
                    ble_conn ? "CONNECTED" : "DISCONNECTED",
                    blekbd_connected_count(), blekbd_is_advertising()?1:0, (unsigned)ESP.getFreeHeap());
      ble_conn_last = ble_conn;
    }

    int ble_adv = blekbd_is_advertising() ? 1 : 0;
    if(ble_adv != ble_adv_last){
      kbdlog.printf("ble: advertising=%d\n", ble_adv);
      ble_adv_last = ble_adv;
    }

    //每 30 秒一条状态。wifi 的当前状态在 /wifistat、蓝牙在 /bt 上，这里不再重复；
    //连/断这种"事件"仍然照打（见上面两段），因为日志要能当历史看。
    uint32_t now = millis();
    if((now - stat_tick) >= 30000){
      stat_tick = now;
      kbdlog.printf("stat: up=%us heap=%u/%u/%u\n",
                    (unsigned)(now/1000),
                    (unsigned)ESP.getFreeHeap(), (unsigned)ESP.getMinFreeHeap(), (unsigned)ESP.getMaxAllocHeap());
    }

    wifi_poll();

#if kbd_periodic_enabled
    //周期表模式的字符串在这里慢慢打出去（每个字符按住/松开 + 间隔）
    usbkbd_type_poll();

    blekbd_type_poll();
#endif
  }
}

void setup()
{
  //ws2812b
  initled();
  //ws2812b_clear();

  //cdc+hid
  USBSerial.begin(115200);
  USBSerial.setTxTimeoutMs(0);   // 日志绝不能阻塞实时循环：串口没人读时直接丢字节
  kbdlog_init();   //日志缓冲 + 复位原因/启动计数
  kbdlog.println("init: led done");

  usbkbd.begin();
  USB.begin();
  kbdlog.println("init: usb hid done");

  //bt
  blekbd_init();
  kbdlog.printf("init: ble done, connected=%d advertising=%d heap=%u\n",
                blekbd_is_connected()?1:0, blekbd_is_advertising()?1:0, (unsigned)ESP.getFreeHeap());

  //wifi
  wifi_init();
  kbdlog.printf("init: wifi done, sta=%s ap=%s sta_ip=%s heap=%u\n",
                wifi_sta_status_str(), wifi_ap_ip().c_str(), wifi_sta_ip().c_str(), (unsigned)ESP.getFreeHeap());

  //col input
  for(int j=0;j<COLS;j++){
    pinMode(colPins[j], INPUT_PULLDOWN);
  }

  //row output
  for(int j=0;j<ROWS;j++){
    pinMode(rowPins[j], OUTPUT);
    digitalWrite(rowPins[j], 0);
  }

  //cycle 0
  cycle = 0;
  digitalWrite(rowPins[cycle], HIGH);

  //timer
  timer = timerBegin(TIMER_FREQ);   //freq=1000000
  timerAlarm(timer, TIMER_SETVAL, true, 0);   //timer, 5ms, isreload, reloadvalue
  timerAttachInterruptArg(timer, ontimer, 0);  //timer, func, arg

  //core0 loop: wifi
  xTaskCreatePinnedToCore(casualloop, "core0 loop", 8192, NULL, 1, NULL, 0);

  //core1 loop: key
  //xTaskCreatePinnedToCore(casualloop, "core1 loop", 8192, NULL, 10, NULL, 1);
  //vTaskDelete(NULL);
}
