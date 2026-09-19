#include "mod_log.h"
#include <Arduino.h>
#include <string.h>
#include <EEPROM.h>

// EEPROM 布局（总大小 512 字节，每个字符串 slot 128 字节）：
//   0   .. 127   STA SSID       以 '\0' 结尾，最长 127 字符
//   128 .. 255   STA PASS       以 '\0' 结尾，最长 127 字符
//   256 .. 383   UDP peer IPv4  以 '\0' 结尾，最长 127 字符
//   384 .. 387   UDP peer port  (int)
//
// 注意：这里只保存 C 字符串本身。不能对 String 调用 EEPROM.put/get，
// 因为 ESP32 core 的 EEPROM.put/get 是 memcpy 模板，会把 String 对象的
// 内存布局（堆指针 + 长度/容量，短串时是 SSO 内联缓冲）原样写进 flash，
// 重启后堆指针失效，读回来就是一个野指针 String。

#define EEPROM_SIZE 512
#define SLOT_SIZE 128

#define where_ssid 0
#define where_pass (SLOT_SIZE)
#define where_udppeer_ipv4 (SLOT_SIZE * 2)
#define where_udppeer_port (SLOT_SIZE * 3)

// EEPROM.begin() 失败时 _data 为 NULL，后续 read/write 会直接空指针崩溃，
// 所以每次访问前都要检查。
static bool eeprom_open() {
  if (!EEPROM.begin(EEPROM_SIZE)) {
    kbdlog.printf("eeprom: begin(%d) failed\n", EEPROM_SIZE);
    return false;
  }
  return true;
}

// 把 value 写进 [address, address+SLOT_SIZE)：
// 不足的部分补 0（顺手清掉该 slot 里的旧数据），超长截断。
static bool slot_save(int address, const String& value) {
  char buf[SLOT_SIZE];
  memset(buf, 0, sizeof(buf));

  size_t len = value.length();
  if (len > SLOT_SIZE - 1) {
    len = SLOT_SIZE - 1;
    kbdlog.printf("eeprom: value too long, truncated to %u bytes\n", (unsigned)len);
  }
  memcpy(buf, value.c_str(), len);

  bool ok = (EEPROM.writeBytes(address, buf, sizeof(buf)) == sizeof(buf));
  if (!ok) kbdlog.printf("eeprom: write slot @%d failed\n", address);
  return ok;
}

// 从 [address, address+SLOT_SIZE) 读回一个 C 字符串。
// 只有同时满足下面两点才接受：
//   1. slot 内能找到 '\0'（未写入过的 flash 全是 0xFF，没有 '\0'）；
//   2. '\0' 之前没有 0xFF（0xFF 不会出现在合法的 ASCII/UTF-8 文本里）。
// 校验不通过时返回 false（ssidpass_load/udppeer_load 会先把结果复位成 ""/0，
// 表示“未配置”，不会被 flash 里的垃圾数据污染）。
static bool slot_load(int address, String& value) {
  uint8_t raw[SLOT_SIZE];
  memset(raw, 0, sizeof(raw));
  if (EEPROM.readBytes(address, raw, sizeof(raw)) != sizeof(raw)) {
    kbdlog.printf("eeprom: read slot @%d failed\n", address);
    return false;
  }

  size_t len = 0;
  bool terminated = false;
  for (; len < sizeof(raw); len++) {
    if (raw[len] == 0) {
      terminated = true;
      break;
    }
    if (raw[len] == 0xFF) {
      return false;
    }
  }
  if (!terminated) {
    return false;
  }

  value = (const char*)raw;
  return true;
}

void ssidpass_save(String& sta_ssid, String& sta_pass) {
  if (!eeprom_open()) return;

  bool ok = slot_save(where_ssid, sta_ssid);
  ok = slot_save(where_pass, sta_pass) && ok;

  if (!EEPROM.commit()) {
    kbdlog.println("eeprom: commit failed");
    ok = false;
  }
  EEPROM.end();

  kbdlog.printf("ssidpass_save: %s\n", ok ? "ok" : "failed");
}

void ssidpass_load(String& sta_ssid, String& sta_pass) {
  sta_ssid = "";
  sta_pass = "";

  if (!eeprom_open()) return;

  if (!slot_load(where_ssid, sta_ssid)) kbdlog.println("ssidpass_load: no valid ssid");
  if (!slot_load(where_pass, sta_pass)) kbdlog.println("ssidpass_load: no valid pass");

  EEPROM.end();
}

void udppeer_save(String& ipv4, int& port) {
  if (!eeprom_open()) return;

  bool ok = slot_save(where_udppeer_ipv4, ipv4);
  // port 是 POD，put/get 直接 memcpy 是安全的
  EEPROM.put(where_udppeer_port, port);

  if (!EEPROM.commit()) {
    kbdlog.println("eeprom: commit failed");
    ok = false;
  }
  EEPROM.end();

  kbdlog.printf("udppeer_save: %s (port=%d)\n", ok ? "ok" : "failed", port);
}

void udppeer_load(String& ipv4, int& port) {
  ipv4 = "";
  port = 0;

  if (!eeprom_open()) return;

  if (!slot_load(where_udppeer_ipv4, ipv4)) kbdlog.println("udppeer_load: no valid ipv4");

  int saved = 0;
  EEPROM.get(where_udppeer_port, saved);
  if (saved > 0 && saved <= 65535) {
    port = saved;
  } else {
    kbdlog.printf("udppeer_load: discard out-of-range port %d\n", saved);
  }

  EEPROM.end();
}
