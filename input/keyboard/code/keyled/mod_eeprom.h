#ifndef KBD_EEPROM_H
#define KBD_EEPROM_H

#include <Arduino.h>

// ---- EEPROM 布局 ----
// 每个字段的起始偏移都在这里定义，mod_eeprom.cpp 只用名字、不自己算偏移。
// 字符串字段占满一个 KBD_EE_SLOT（以 '\0' 结尾，最长 SLOT-1 字节）；其它小字段用固定字节数。
//
// 规矩：
//   1. **改动已有字段的顺序/含义时必须把 KBD_EE_LAYOUT_VERSION +1**（迁移见 mod_eeprom.cpp 的 eeprom_migrate()）；
//      往 0xFF 的空白处加新字段不用 +1（新区域读出来就是"未写入"）。
//   2. 四个凭据（STA/AP 的 ssid/pass）故意紧挨着放，方便对着看。
//   3. 只存 C 字符串本身，不能对 String 用 EEPROM.put/get（原因见 mod_eeprom.cpp 开头）。
//
//   v1（老布局）：0 sta_ssid, 128 sta_pass, 256 udp_ipv4, 384 udp_port
//   v2（现在）  ：0 sta_ssid, 128 sta_pass, 256 ap_ssid, 384 ap_pass, 512 udp_ipv4, 640 udp_port

#define KBD_EE_SIZE            2048   // EEPROM 总大小（字节）
#define KBD_EE_SLOT             128   // 字符串 slot 大小

#define KBD_EE_STA_SSID        (KBD_EE_SLOT * 0)      //   0 .. 127   STA SSID（'\0' 结尾，≤127 字符）
#define KBD_EE_STA_PASS        (KBD_EE_SLOT * 1)      // 128 .. 255   STA PASS
#define KBD_EE_AP_SSID         (KBD_EE_SLOT * 2)      // 256 .. 383   AP SSID（实际 ≤31 字符，见 wifi_ap_cred_valid）
#define KBD_EE_AP_PASS         (KBD_EE_SLOT * 3)      // 384 .. 511   AP PASS（实际 ≤63；空串 = 开放热点）
#define KBD_EE_UDP_IPV4        (KBD_EE_SLOT * 4)      // 512 .. 639   UDP 目标 IPv4（空 = 不启用）
#define KBD_EE_UDP_PORT        (KBD_EE_SLOT * 5)      // 640 .. 643   UDP 目标 port（int；0 = 不启用）
#define KBD_EE_LAYOUT_OFF      (KBD_EE_SLOT * 6)      // 768 .. 771   布局版本（uint32）
#define KBD_EE_BLE_PASSKEY     (KBD_EE_LAYOUT_OFF + 4)// 772 .. 775   BLE 配对码（uint32；0 = 不用，Just Works）
#define KBD_EE_BLE_NAME        (KBD_EE_SLOT * 7)      // 896 .. 1023  BLE 广播名（空 = 用库默认名）
#define KBD_EE_TCP_IPV4        (KBD_EE_SLOT * 8)      // 1024 .. 1151 TCP 目标 IPv4（空 = 不启用）
#define KBD_EE_TCP_PORT        (KBD_EE_SLOT * 9)      // 1152 .. 1155 TCP 目标 port（int；0 = 不启用）
#define KBD_EE_WS_URL          (KBD_EE_TCP_PORT + 4)  // 1156 .. 1283 ws(websocket) url（空 = 不启用）

#define KBD_EE_LAYOUT_VERSION  2      // 当前布局版本；改布局时 +1 并同步 eeprom_migrate()


void ssidpass_save(String& sta_ssid, String& sta_pass);
void ssidpass_load(String& sta_ssid, String& sta_pass);

// AP（本机热点）的 ssid/pass：默认值在 mod_wifi.cpp 里，这里存用户改过的。
// 读不到有效值时把两个出参都置 ""，由调用方决定回退到默认值。
void apssidpass_save(String& ap_ssid, String& ap_pass);
void apssidpass_load(String& ap_ssid, String& ap_pass);

// BLE 广播名 + 配对码：name 空 = 用库默认名；passkey 0 = 不用配对码（Just Works）。
bool blecfg_save(String& name, uint32_t passkey);
void blecfg_load(String& name, uint32_t& passkey);

void udppeer_save(String& ipv4, int& port);
void udppeer_load(String& ipv4, int& port);

// tcp 目标 / ws(websocket) url：和 udp 一样，空 = 不启用
void tcppeer_save(String& ipv4, int& port);
void tcppeer_load(String& ipv4, int& port);
void wsurl_save(String& url);
void wsurl_load(String& url);

#endif
