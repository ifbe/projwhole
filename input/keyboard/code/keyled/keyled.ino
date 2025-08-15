#include "ledkbd.h"

#include "config.h"

#include "blekbd.h"

#include "wifikbd.h"

#include "udpkbd.h"

#include "USB.h"
#include "usbkbd.h"
USBCDC USBSerial;
extern USBHIDKeyboard usbkbd;


#if mode_chosen==mode_arrow
static byte rowPins[ROWS] = {PIN_KEY_Y0, PIN_KEY_Y1, PIN_KEY_Y2, PIN_KEY_Y3};
static byte colPins[COLS] = {PIN_XN2, PIN_XN1, PIN_X0, PIN_X1};
#else
static byte rowPins[ROWS] = {
PIN_KEY_Y0, PIN_KEY_Y1, PIN_KEY_Y2, PIN_KEY_Y3,
PIN_KEY_Y4, PIN_KEY_Y5, PIN_KEY_Y6, PIN_KEY_Y7
};
static byte colPins[COLS] = {
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
int global_changed = 0;
void IRAM_ATTR ontimer(void* ptr)
{
  //read
  for(int j=0;j<COLS;j++){
    state[cycle][j].old = state[cycle][j].val;
    state[cycle][j].val = (digitalRead(colPins[j]) == HIGH);

    if(state[cycle][j].old == state[cycle][j].val){
      if(state[cycle][j].cnt < 10)state[cycle][j].cnt++;
    }
    else{
      state[cycle][j].cnt = 1;
      state[cycle][j].changed = 1;
      global_changed = 1;
      /*
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


void check_keyboard()
{
  if(0 == global_changed)return;

  for(int y=0;y<ROWS;y++){
    for(int x=0;x<COLS;x++){
      if(0 == state[y][x].changed)continue;
      state[y][x].changed = 0;

      if(state[y][x].val == 1){
        USBSerial.printf("press: %d %d\n", x, y);

        ws2812b_press(x, y);

        usbkbd_press(x, y);

        blekbd_press(x, y);

        wifi_udp_send(x, y);
      }
      else{
        USBSerial.printf("release: %d %d\n", x, y);

        ws2812b_release(x, y);

        usbkbd_release(x, y);

        blekbd_release(x, y);
      }
    }
  }

  global_changed = 0;
}


void loop()
{
  //USBSerial.println(999);
  //setled();

  while(USBSerial.available() > 0) {
    String incomingMessage = USBSerial.readStringUntil('\n');
    USBSerial.println(incomingMessage.c_str());
  }

  wifi_poll();

  //ws2812b_clear();

  check_keyboard();

  //ws2812b_show();
}


void setup()
{
  //ws2812b
  initled();
  //ws2812b_clear();

  //cdc+hid
  USBSerial.begin(115200);
  usbkbd.begin();
  USB.begin();

  //bt
  blekbd_init();

  //wifi
  wifi_init();

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
}
