#include <Arduino.h>
#include <string.h>
#include <stdarg.h>
#include <USB.h>
#include <esp_system.h>
#include <esp_attr.h>
#include <esp_log.h>
#include "mod_log.h"

// 串口镜像要写在 sketch 真正使用的那个 console 上。
// 本工程的编译选项是 USBMode=hwcdc + CDCOnBoot=cdc，于是 core 里
// `#define Serial HWCDCSerial`（USB-Serial/JTAG），而 keyled.ino 从来没有
// 调过 Serial.begin()（core 的自动 begin 在 ARDUINO_USB_MODE=1 时也不成立），
// HWCDC 的 tx_ring_buf 一直是 NULL，写 Serial 会被直接丢弃。
// 能看到的只有 keyled.ino 里定义的 USBSerial（TinyUSB CDC）。
extern USBCDC USBSerial;

KbdLogClass kbdlog;

// ---- 环形缓冲 ----
static char ring[KBDLOG_BUFSIZE];
static size_t ring_head = 0;   // 下一个写入位置
static size_t ring_used = 0;   // 已用字节数
static portMUX_TYPE ring_mux = portMUX_INITIALIZER_UNLOCKED;

static void ring_push(const char* p, size_t len)
{
  if(!p || !len)return;

  portENTER_CRITICAL(&ring_mux);
  for(size_t i=0;i<len;i++){
    ring[ring_head] = p[i];
    ring_head++;
    if(ring_head >= KBDLOG_BUFSIZE)ring_head = 0;
    if(ring_used < KBDLOG_BUFSIZE)ring_used++;
  }
  portEXIT_CRITICAL(&ring_mux);
}

void kbdlog_clear()
{
  portENTER_CRITICAL(&ring_mux);
  ring_head = 0;
  ring_used = 0;
  portEXIT_CRITICAL(&ring_mux);
}

size_t kbdlog_copy(char* out, size_t maxlen)
{
  if(!out || !maxlen)return 0;

  size_t n;
  portENTER_CRITICAL(&ring_mux);
  n = ring_used;
  if(n > maxlen-1)n = maxlen-1;

  // 丢掉最旧的 (ring_used - n) 字节
  size_t start = (ring_head + KBDLOG_BUFSIZE - ring_used + (ring_used - n)) % KBDLOG_BUFSIZE;
  for(size_t i=0;i<n;i++)out[i] = ring[(start + i) % KBDLOG_BUFSIZE];
  portEXIT_CRITICAL(&ring_mux);

  out[n] = 0;
  return n;
}

// ---- Print 接口：一份给网页缓冲，一份照旧给串口 ----
size_t KbdLogClass::write(uint8_t c)
{
  return write(&c, 1);
}

size_t KbdLogClass::write(const uint8_t* buf, size_t len)
{
  if(!buf || !len)return 0;

  ring_push((const char*)buf, len);
  USBSerial.write(buf, len);   // 串口输出（TinyUSB CDC）

  return len;
}

// ---- 复位原因 / 启动计数 ----
#define KBDLOG_RTC_MAGIC 0x4b424c31UL   // "KBL1"

RTC_NOINIT_ATTR static uint32_t rtc_magic;
RTC_NOINIT_ATTR static uint32_t rtc_boot_count;

static uint32_t boot_count = 1;
static const char* reset_reason_str = "?";
static bool bt_verbose = false;

static const char* reset_reason_name(esp_reset_reason_t r)
{
  switch(r){
  case ESP_RST_POWERON:   return "POWERON";
  case ESP_RST_EXT:       return "EXT";
  case ESP_RST_SW:        return "SW";
  case ESP_RST_PANIC:     return "PANIC";
  case ESP_RST_INT_WDT:   return "INT_WDT";
  case ESP_RST_TASK_WDT:  return "TASK_WDT";
  case ESP_RST_WDT:       return "WDT";
  case ESP_RST_DEEPSLEEP: return "DEEPSLEEP";
  case ESP_RST_BROWNOUT:  return "BROWNOUT";
  case ESP_RST_SDIO:      return "SDIO";
  default:                return "UNKNOWN";
  }
}

static bool reset_reason_is_bad(esp_reset_reason_t r)
{
  return (ESP_RST_PANIC == r) || (ESP_RST_INT_WDT == r) || (ESP_RST_TASK_WDT == r)
      || (ESP_RST_WDT == r) || (ESP_RST_BROWNOUT == r);
}

uint32_t kbdlog_boot_count() { return boot_count; }
const char* kbdlog_reset_reason_str() { return reset_reason_str; }

// ---- IDF 日志钩子：把 ESP_LOGx（包括蓝牙底层）的输出也收进环形缓冲 ----
static vprintf_like_t prev_log_vprintf = NULL;

static int kbdlog_log_vprintf(const char* fmt, va_list ap)
{
  char buf[192];
  va_list ap2;

  va_copy(ap2, ap);
  int n = vsnprintf(buf, sizeof(buf), fmt, ap);   // ap 在这里被消费
  if(n > 0)ring_push(buf, strnlen(buf, sizeof(buf)));

  int ret = prev_log_vprintf ? prev_log_vprintf(fmt, ap2) : n;
  va_end(ap2);

  return ret;
}

void kbdlog_set_bt_verbose(bool on)
{
  // 值没变就直接返回：/log、/bt 都是 3 秒自动刷新，而点开关后 URL 上带着 ?bt=1，
  // 每次刷新都会重新调到这里，不去重的话日志会被 "log: bt verbose on" 刷屏。
  if(bt_verbose == on)return;
  bt_verbose = on;

  // 蓝牙底层(Bluedroid)的日志 tag
  static const char* tags[] = {
    "BT_GATTS", "BT_GATTC", "BT_GAP", "BT_BTM", "BT_L2CAP", "BT_SMP", "BT_APPL", "BT_HCI", "BLEDevice"
  };
  esp_log_level_t level = on ? ESP_LOG_INFO : ESP_LOG_WARN;
  for(size_t i=0;i<sizeof(tags)/sizeof(tags[0]);i++){
    esp_log_level_set(tags[i], level);
  }

  kbdlog.printf("log: bt verbose %s\n", on ? "on" : "off");
}

bool kbdlog_bt_verbose() { return bt_verbose; }

// ---- 按键事件日志开关 ----
// press/release 是高频事件（8KB 的环形缓冲大概能装几十秒连打），
// 排查蓝牙/WiFi 时可以临时关掉，免得把有用的行冲掉。
static volatile bool keylog_on = true;

void kbdlog_set_keylog(bool on)
{
  if(keylog_on == on)return;
  keylog_on = on;
  kbdlog.printf("log: key events %s\n", on ? "on" : "off");
}

bool kbdlog_keylog() { return keylog_on; }

void kbdlog_init()
{
  // RTC 里的内容在掉电后是随机的，用 magic 判断是不是同一次上电
  if(KBDLOG_RTC_MAGIC != rtc_magic){
    rtc_magic = KBDLOG_RTC_MAGIC;
    rtc_boot_count = 0;
  }
  rtc_boot_count++;
  boot_count = rtc_boot_count;

  esp_reset_reason_t reason = esp_reset_reason();
  reset_reason_str = reset_reason_name(reason);

  prev_log_vprintf = esp_log_set_vprintf(kbdlog_log_vprintf);

  kbdlog.printf("\n=== boot #%u, reset=%s, heap=%u ===\n",
                (unsigned)boot_count, reset_reason_str, (unsigned)ESP.getFreeHeap());
  if(boot_count > 1){
    kbdlog.printf("warn: boot #%u (>1 means it rebooted since power-on)\n", (unsigned)boot_count);
  }
  if(reset_reason_is_bad(reason)){
    kbdlog.printf("warn: abnormal reset (%s), check the lines above for a crash\n", reset_reason_str);
  }
}
