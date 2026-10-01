#pragma once

#include <Arduino.h>

void wifi_init();
void wifi_poll();

// WiFi 状态（/wifistat 页面用）
const char* wifi_sta_status_str();
const char* wifi_mode_str();      // "ap+sta" / "ap" / "sta" / "off"（wifi 共有的那一行）
String wifi_channel();            // 当前信道（射频级：AP+STA 下 IDF 会把 AP 拉到 STA 的信道）
String wifi_txpower();            // 发射功率，形如 "19.5 dBm"
String wifi_hostname();           // 设备级名字（NetworkManager 的，默认 esp32s3-XXXXXX）
int wifi_sta_rssi();
int wifi_ap_station_count();
String wifi_sta_ip();
String wifi_ap_ip();
String wifi_sta_mac();          // STA 接口 MAC（接口没起来也能读）
String wifi_ap_mac();           // AP 接口 MAC（通常是 STA MAC + 1）
const char* wifi_ap_ssid();
const char* wifi_ap_pass();

// AP 默认凭据（网页上给提示用；EEPROM 里没存有效值时就用这两条）
const char* wifi_ap_ssid_default();
const char* wifi_ap_pass_default();

// AP 凭据校验：ssid 1..31 字节；pass 留空（开放热点）或 8..63 字节。
// 不校验就存盘的话，重启后 softAP 起不来，网页也进不去，只能接串口救——所以保存前必须过这一关。
// 不合法时返回 false 并把原因写进 err（给网页显示）。
bool wifi_ap_cred_valid(const String& ssid, const String& pass, String& err);

// AP 已连接的客户端（/wifistat 页面用）：MAC + DHCP 分配到的 IP + RSSI。
// AP 最多能挂 15 个，页面只列前 KBD_WIFI_AP_STA_MAX 个。
#define KBD_WIFI_AP_STA_MAX 8
struct kbd_wifi_sta_t {
  char mac[18];    // "aa:bb:cc:dd:ee:ff"
  char ip[16];     // "192.168.4.2"，取不到 DHCP 租约时是 "?"
  int rssi;
};
int wifi_ap_station_list(kbd_wifi_sta_t* out, int max);   // 返回实际写入的个数
