#include "mod_log.h"
#include "mod_eeprom.h"   // 布局宏（KBD_EE_*）都在这里
#include <Arduino.h>
#include <string.h>
#include <EEPROM.h>

// EEPROM 的 slot 偏移、总大小、布局版本号全在 mod_eeprom.h 里定义（改布局看那里的规矩）。
//
// 这里只记两条实现上的坑：
// 1. 只保存 C 字符串本身。不能对 String 调用 EEPROM.put/get，因为 ESP32 core 的
//    EEPROM.put/get 是 memcpy 模板，会把 String 对象的内存布局（堆指针 + 长度/容量，
//    短串时是 SSO 内联缓冲）原样写进 flash，重启后堆指针失效，读回来就是一个野指针 String。
// 2. 布局版本不匹配时只清"含义变了"的 slot（见 eeprom_migrate()），
//    不然老数据会被当成新字段读——比如老的 udp ip "192.168.5.217" 会被当成 AP ssid，
//    而且旧 port 的字节恰好以 0x00 开头时还会被解读成"空密码 = 开放热点"。

// 布局变了就把"含义变了"的 slot 清成 0xFF（= 未写入，slot_load() 会拒绝），
// 然后写下新版本号。sta 的 0/128 含义没变，不动，用户的 STA 配置能保住。
static void eeprom_migrate() {
  uint32_t v = 0;
  EEPROM.get(KBD_EE_LAYOUT_OFF, v);
  if (v == KBD_EE_LAYOUT_VERSION) return;

  kbdlog.printf("eeprom: layout %u -> %u, clearing ap/udp slots\n", (unsigned)v, (unsigned)KBD_EE_LAYOUT_VERSION);

  uint8_t blank[KBD_EE_SLOT];
  memset(blank, 0xFF, sizeof(blank));
  bool ok = EEPROM.writeBytes(KBD_EE_AP_SSID, blank, sizeof(blank));
  ok = EEPROM.writeBytes(KBD_EE_AP_PASS, blank, sizeof(blank)) && ok;
  ok = EEPROM.writeBytes(KBD_EE_UDP_IPV4, blank, sizeof(blank)) && ok;
  ok = EEPROM.writeBytes(KBD_EE_UDP_PORT, blank, sizeof(blank)) && ok;   // 只用前 4 字节，整块清干净

  EEPROM.put(KBD_EE_LAYOUT_OFF, (uint32_t)KBD_EE_LAYOUT_VERSION);
  if (!EEPROM.commit()) {
    kbdlog.println("eeprom: commit failed");
    ok = false;
  }
  if (!ok) kbdlog.println("eeprom: migrate had write errors");
}

// EEPROM.begin() 失败时 _data 为 NULL，后续 read/write 会直接空指针崩溃，
// 所以每次访问前都要检查。
static bool eeprom_open() {
  if (!EEPROM.begin(KBD_EE_SIZE)) {
    kbdlog.printf("eeprom: begin(%d) failed\n", KBD_EE_SIZE);
    return false;
  }
  eeprom_migrate();
  return true;
}

// 把 value 写进 [address, address+KBD_EE_SLOT)：
// 不足的部分补 0（顺手清掉该 slot 里的旧数据），超长截断。
static bool slot_save(int address, const String& value) {
  char buf[KBD_EE_SLOT];
  memset(buf, 0, sizeof(buf));

  size_t len = value.length();
  if (len > KBD_EE_SLOT - 1) {
    len = KBD_EE_SLOT - 1;
    kbdlog.printf("eeprom: value too long, truncated to %u bytes\n", (unsigned)len);
  }
  memcpy(buf, value.c_str(), len);

  bool ok = (EEPROM.writeBytes(address, buf, sizeof(buf)) == sizeof(buf));
  if (!ok) kbdlog.printf("eeprom: write slot @%d failed\n", address);
  return ok;
}

// 从 [address, address+KBD_EE_SLOT) 读回一个 C 字符串。
// 只有同时满足下面两点才接受：
//   1. slot 内能找到 '\0'（未写入过的 flash 全是 0xFF，没有 '\0'）；
//   2. '\0' 之前没有 0xFF（0xFF 不会出现在合法的 ASCII/UTF-8 文本里）。
// 校验不通过时返回 false（ssidpass_load/udppeer_load 会先把结果复位成 ""/0，
// 表示“未配置”，不会被 flash 里的垃圾数据污染）。
static bool slot_load(int address, String& value) {
  uint8_t raw[KBD_EE_SLOT];
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

  bool ok = slot_save(KBD_EE_STA_SSID, sta_ssid);
  ok = slot_save(KBD_EE_STA_PASS, sta_pass) && ok;

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

  if (!slot_load(KBD_EE_STA_SSID, sta_ssid)) kbdlog.println("ssidpass_load: no valid ssid");
  if (!slot_load(KBD_EE_STA_PASS, sta_pass)) kbdlog.println("ssidpass_load: no valid pass");

  EEPROM.end();
}

// AP 凭据：和 STA 那对完全对称，只是换 slot。
// 注意这里不校验合法性（长度/空值由 mod_wifi.cpp 的 wifi_ap_cred_valid 管），
// 免得"存进去了但读不懂"的两套规则。
void apssidpass_save(String& ap_ssid, String& ap_pass) {
  if (!eeprom_open()) return;

  bool ok = slot_save(KBD_EE_AP_SSID, ap_ssid);
  ok = slot_save(KBD_EE_AP_PASS, ap_pass) && ok;

  if (!EEPROM.commit()) {
    kbdlog.println("eeprom: commit failed");
    ok = false;
  }
  EEPROM.end();

  kbdlog.printf("apssidpass_save: %s\n", ok ? "ok" : "failed");
}

void apssidpass_load(String& ap_ssid, String& ap_pass) {
  ap_ssid = "";
  ap_pass = "";

  if (!eeprom_open()) return;

  if (!slot_load(KBD_EE_AP_SSID, ap_ssid)) kbdlog.println("apssidpass_load: no valid ssid");
  if (!slot_load(KBD_EE_AP_PASS, ap_pass)) kbdlog.println("apssidpass_load: no valid pass");

  EEPROM.end();
}

// BLE 广播名 + 配对码。配对码是 POD，直接 put/get；名字走 slot（读不到就是 "" = 用默认名）。
bool blecfg_save(String& name, uint32_t passkey) {
  if (!eeprom_open()) return false;

  bool ok = slot_save(KBD_EE_BLE_NAME, name);
  EEPROM.put(KBD_EE_BLE_PASSKEY, passkey);

  if (!EEPROM.commit()) {
    kbdlog.println("eeprom: commit failed");
    ok = false;
  }
  EEPROM.end();

  kbdlog.printf("blecfg_save: %s (passkey=%u)\n", ok ? "ok" : "failed", (unsigned)passkey);
  return ok;
}

void blecfg_load(String& name, uint32_t& passkey) {
  name = "";
  passkey = 0;

  if (!eeprom_open()) return;

  if (!slot_load(KBD_EE_BLE_NAME, name)) kbdlog.println("blecfg_load: no valid name (use library default)");

  uint32_t saved = 0;
  EEPROM.get(KBD_EE_BLE_PASSKEY, saved);
  if (saved <= 999999) {
    passkey = saved;   // 0 = 不用配对码
  } else {
    kbdlog.printf("blecfg_load: discard out-of-range passkey %u\n", (unsigned)saved);
  }

  EEPROM.end();
}

void udppeer_save(String& ipv4, int& port) {
  if (!eeprom_open()) return;

  bool ok = slot_save(KBD_EE_UDP_IPV4, ipv4);
  // port 是 POD，put/get 直接 memcpy 是安全的
  EEPROM.put(KBD_EE_UDP_PORT, port);

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

  if (!slot_load(KBD_EE_UDP_IPV4, ipv4)) kbdlog.println("udppeer_load: no valid ipv4");

  int saved = 0;
  EEPROM.get(KBD_EE_UDP_PORT, saved);
  if (saved > 0 && saved <= 65535) {
    port = saved;
  } else {
    kbdlog.printf("udppeer_load: discard out-of-range port %d\n", saved);
  }

  EEPROM.end();
}

// tcp 目标：和 udp 完全对称（ipv4 slot + port），空 = 不启用
void tcppeer_save(String& ipv4, int& port) {
  if (!eeprom_open()) return;

  bool ok = slot_save(KBD_EE_TCP_IPV4, ipv4);
  EEPROM.put(KBD_EE_TCP_PORT, port);

  if (!EEPROM.commit()) {
    kbdlog.println("eeprom: commit failed");
    ok = false;
  }
  EEPROM.end();

  kbdlog.printf("tcppeer_save: %s (port=%d)\n", ok ? "ok" : "failed", port);
}

void tcppeer_load(String& ipv4, int& port) {
  ipv4 = "";
  port = 0;

  if (!eeprom_open()) return;

  if (!slot_load(KBD_EE_TCP_IPV4, ipv4)) kbdlog.println("tcppeer_load: no valid ipv4");

  int saved = 0;
  EEPROM.get(KBD_EE_TCP_PORT, saved);
  if (saved > 0 && saved <= 65535) {
    port = saved;
  } else {
    kbdlog.printf("tcppeer_load: discard out-of-range port %d\n", saved);
  }

  EEPROM.end();
}

// ws(websocket) 目标 url：只有一个字符串 slot，空 = 不启用
void wsurl_save(String& url) {
  if (!eeprom_open()) return;

  bool ok = slot_save(KBD_EE_WS_URL, url);

  if (!EEPROM.commit()) {
    kbdlog.println("eeprom: commit failed");
    ok = false;
  }
  EEPROM.end();

  kbdlog.printf("wsurl_save: %s (%s)\n", ok ? "ok" : "failed", url.c_str());
}

void wsurl_load(String& url) {
  url = "";

  if (!eeprom_open()) return;

  if (!slot_load(KBD_EE_WS_URL, url)) kbdlog.println("wsurl_load: no valid url");

  EEPROM.end();
}
