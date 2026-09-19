
//wifi
#include "mod_log.h"
#include <WiFi.h>
#include <string.h>
//AP 关联列表 + DHCP 租约（/wifistat 页面上的"已连接的 ip"）
#include <esp_wifi.h>
#include <esp_wifi_ap_get_sta_list.h>
//
#include "mod_eeprom.h"
//
#include "mod_web.h"
#include "mod_wifi.h"
#include "mod_udp.h"
//ap
const char* ap_ssid = "esp32s3_keyboard";
const char* ap_pass = "12345678";
//std::vector<clients> xxx;
//sta
String sta_ssid = "";
String sta_pass = "";
bool sta_connected = 0;







void WiFiEvent(WiFiEvent_t event, arduino_event_info_t info) {
  switch (event) {
  case ARDUINO_EVENT_WIFI_OFF:   //100
    kbdlog.println("ARDUINO_EVENT_WIFI_OFF");
    break;
  case ARDUINO_EVENT_WIFI_READY:
    kbdlog.println("ARDUINO_EVENT_WIFI_READY");
    break;
  case ARDUINO_EVENT_WIFI_SCAN_DONE:
    kbdlog.println("ARDUINO_EVENT_WIFI_SCAN_DONE");
    break;
  case ARDUINO_EVENT_WIFI_FTM_REPORT:
    kbdlog.println("ARDUINO_EVENT_WIFI_FTM_REPORT");
    break;
  case ARDUINO_EVENT_WIFI_STA_START:   //110
    kbdlog.println("ARDUINO_EVENT_WIFI_STA_START");
    break;
  case ARDUINO_EVENT_WIFI_STA_STOP:
    kbdlog.println("ARDUINO_EVENT_WIFI_STA_STOP");
    break;
  case ARDUINO_EVENT_WIFI_STA_CONNECTED:
    kbdlog.println("ARDUINO_EVENT_WIFI_STA_CONNECTED");
    break;
  case ARDUINO_EVENT_WIFI_STA_DISCONNECTED:
    switch(info.wifi_sta_disconnected.reason){
    case WIFI_REASON_NO_AP_FOUND:
      kbdlog.printf("ARDUINO_EVENT_WIFI_STA_DISCONNECTED: reason=WIFI_REASON_NO_AP_FOUND\n");
      if(false==sta_connected)WiFi.setAutoReconnect(false);   //never connected
      break;
    default:
      kbdlog.printf("ARDUINO_EVENT_WIFI_STA_DISCONNECTED: reason=%d\n", info.wifi_sta_disconnected.reason);
      break;
    }
    sta_connected = false;
    break;
  case ARDUINO_EVENT_WIFI_STA_AUTHMODE_CHANGE:
    kbdlog.println("ARDUINO_EVENT_WIFI_STA_AUTHMODE_CHANGE");
    break;
  case ARDUINO_EVENT_WIFI_STA_GOT_IP:
    kbdlog.printf("ARDUINO_EVENT_WIFI_STA_GOT_IP: %s\n", WiFi.localIP().toString().c_str());
    sta_connected = true;
    break;
  case ARDUINO_EVENT_WIFI_STA_GOT_IP6:
    kbdlog.println("ARDUINO_EVENT_WIFI_STA_GOT_IP6");
    break;
  case ARDUINO_EVENT_WIFI_STA_LOST_IP:
    kbdlog.println("ARDUINO_EVENT_WIFI_STA_LOST_IP");
    break;
  case ARDUINO_EVENT_WIFI_AP_START:    //130
    kbdlog.println("ARDUINO_EVENT_WIFI_AP_START");
    break;
  case ARDUINO_EVENT_WIFI_AP_STOP:
    kbdlog.println("ARDUINO_EVENT_WIFI_AP_STOP");
    break;
  case ARDUINO_EVENT_WIFI_AP_STACONNECTED:
    kbdlog.println("ARDUINO_EVENT_WIFI_AP_STACONNECTED");
    break;
  case ARDUINO_EVENT_WIFI_AP_STADISCONNECTED:
    kbdlog.println("ARDUINO_EVENT_WIFI_AP_STADISCONNECTED");
    break;
  case ARDUINO_EVENT_WIFI_AP_STAIPASSIGNED:
    kbdlog.println("ARDUINO_EVENT_WIFI_AP_STAIPASSIGNED");
    break;
  case ARDUINO_EVENT_WIFI_AP_PROBEREQRECVED:
    kbdlog.println("ARDUINO_EVENT_WIFI_AP_PROBEREQRECVED");
    break;
  case ARDUINO_EVENT_WIFI_AP_GOT_IP6:
    kbdlog.println("ARDUINO_EVENT_WIFI_AP_GOT_IP6");
    break;
  default:
    kbdlog.printf("Unknown WiFi event: %d\n", event);
    break;
  }
}

void wifi_init()
{
  //load
  if(sta_ssid.equals(""))ssidpass_load(sta_ssid, sta_pass);
  kbdlog.printf("ap: ssid=%s, pass=%s\n", ap_ssid, ap_pass);
  kbdlog.printf("sta: ssid=%s, pass=%s\n", sta_ssid.c_str(), sta_pass.c_str());

  //event
  WiFi.onEvent(WiFiEvent);

  //ap
  WiFi.softAP(ap_ssid, ap_pass);
  kbdlog.println("AP IP address: " + WiFi.softAPIP().toString());

  //sta
  if( (sta_ssid[0]>=' ')&&(sta_ssid[0]<0x80) ){
    kbdlog.println("wifi.begin");
    WiFi.begin(sta_ssid.c_str(), sta_pass.c_str());
  }

  //web
  wifi_web_init();

  //udp
  wifi_udp_init();
}

void wifi_poll()
{
  wifi_web_poll();
  wifi_udp_poll();
}


// ---- WiFi 状态（/wifistat 页面用） ----
const char* wifi_sta_status_str()
{
  switch(WiFi.status()){
  case WL_IDLE_STATUS:      return "IDLE";
  case WL_NO_SSID_AVAIL:    return "NO_SSID_AVAIL";
  case WL_SCAN_COMPLETED:   return "SCAN_COMPLETED";
  case WL_CONNECTED:        return "CONNECTED";
  case WL_CONNECT_FAILED:   return "CONNECT_FAILED";
  case WL_CONNECTION_LOST:  return "CONNECTION_LOST";
  case WL_DISCONNECTED:     return "DISCONNECTED";
  default:                  return "UNKNOWN";
  }
}

int wifi_sta_rssi()
{
  return (WL_CONNECTED == WiFi.status()) ? (int)WiFi.RSSI() : 0;
}

int wifi_ap_station_count()
{
  return (int)WiFi.softAPgetStationNum();
}

String wifi_sta_ip()
{
  return WiFi.localIP().toString();
}

String wifi_ap_ip()
{
  return WiFi.softAPIP().toString();
}

const char* wifi_ap_ssid()
{
  return ap_ssid;
}

const char* wifi_ap_pass()
{
  return ap_pass;
}

// AP 已连接客户端：先拿协议栈的关联列表（MAC/RSSI），再用 DHCP 服务器的租约表把 IP 补上。
// 两者按 MAC 一一对应；没开 DHCP 服务器（或客户端还没租到地址）时 ip 留 "?"。
// AP 没起来 / 没有客户端时返回 0，页面就只显示 stations=0。
int wifi_ap_station_list(kbd_wifi_sta_t* out, int max)
{
  if( (0 == max) || (0 == out) )return 0;

  wifi_sta_list_t list;
  memset(&list, 0, sizeof(list));
  if(ESP_OK != esp_wifi_ap_get_sta_list(&list))return 0;

  int n = list.num;
  if(n > max)n = max;
  if(n <= 0)return 0;

  wifi_sta_mac_ip_list_t iplist;
  memset(&iplist, 0, sizeof(iplist));
  iplist.num = n;
  bool have_ip = (ESP_OK == esp_wifi_ap_get_sta_list_with_ip(&list, &iplist));

  for(int i=0;i<n;i++){
    const uint8_t* mac = list.sta[i].mac;
    snprintf(out[i].mac, sizeof(out[i].mac), "%02x:%02x:%02x:%02x:%02x:%02x",
             mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
    out[i].rssi = list.sta[i].rssi;

    if( have_ip && (i < iplist.num) )snprintf(out[i].ip, sizeof(out[i].ip), IPSTR, IP2STR(&iplist.sta[i].ip));
    else snprintf(out[i].ip, sizeof(out[i].ip), "?");
  }

  return n;
}
