#pragma once

#include <Arduino.h>

void wifi_init();
void wifi_poll();

// WiFi 状态（/wifistat 页面用）
const char* wifi_sta_status_str();
int wifi_sta_rssi();
int wifi_ap_station_count();
String wifi_sta_ip();
String wifi_ap_ip();
const char* wifi_ap_ssid();
const char* wifi_ap_pass();

// AP 已连接的客户端（/wifistat 页面用）：MAC + DHCP 分配到的 IP + RSSI。
// AP 最多能挂 15 个，页面只列前 KBD_WIFI_AP_STA_MAX 个。
#define KBD_WIFI_AP_STA_MAX 8
struct kbd_wifi_sta_t {
  char mac[18];    // "aa:bb:cc:dd:ee:ff"
  char ip[16];     // "192.168.4.2"，取不到 DHCP 租约时是 "?"
  int rssi;
};
int wifi_ap_station_list(kbd_wifi_sta_t* out, int max);   // 返回实际写入的个数
