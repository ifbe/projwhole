
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
#include "mod_socket.h"
//ap
//默认凭据写在这里；EEPROM 里有有效值（网页上改过）就用 EEPROM 的，见 wifi_init()。
const char* ap_ssid_default = "esp32s3_keyboard";
const char* ap_pass_default = "12345678";
String ap_ssid = ap_ssid_default;
String ap_pass = ap_pass_default;
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

  //ap：EEPROM 里存过有效值（网页上改过）就覆盖默认值；没有/不合法就保持默认值。
  {
    String s = "", p = "";
    apssidpass_load(s, p);
    if(s.length() > 0){
      String err;
      if(wifi_ap_cred_valid(s, p, err)){
        ap_ssid = s;
        ap_pass = p;
        kbdlog.println("ap: cred from eeprom");
      }
      else{
        kbdlog.printf("ap: eeprom cred ignored (%s), use default\n", err.c_str());
      }
    }
    else{
      kbdlog.println("ap: cred from default");
    }
  }

  kbdlog.printf("ap: ssid=%s, pass=%s\n", ap_ssid.c_str(), ap_pass.c_str());
  kbdlog.printf("sta: ssid=%s, pass=%s\n", sta_ssid.c_str(), sta_pass.c_str());

  //event
  WiFi.onEvent(WiFiEvent);

  //ap
  bool ap_ok = WiFi.softAP(ap_ssid.c_str(), ap_pass.c_str());
  kbdlog.printf("ap: start=%d, ip=%s\n", (int)ap_ok, WiFi.softAPIP().toString().c_str());

  //sta
  if( (sta_ssid[0]>=' ')&&(sta_ssid[0]<0x80) ){
    kbdlog.println("wifi.begin");
    WiFi.begin(sta_ssid.c_str(), sta_pass.c_str());
  }

  //web
  wifi_web_init();

  //udp
  socket_init();
}

void wifi_poll()
{
  wifi_web_poll();
  socket_poll();
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

//wifi 共有的状态：AP 和 STA 是同一颗射频的两个角色，这里只说整颗射频/整栈的属性
const char* wifi_mode_str()
{
  switch(WiFi.getMode()){
  case WIFI_MODE_NULL:   return "off";
  case WIFI_MODE_STA:    return "sta";
  case WIFI_MODE_AP:     return "ap";
  case WIFI_MODE_APSTA:  return "ap+sta";
  default:               return "?";
  }
}

// 当前信道。AP+STA 下 IDF 会把 AP 拉到 STA 连上的那个信道，所以整颗射频只有一个
// "当前信道"，这行是射频级的（不是某个接口自己的）。
String wifi_channel()
{
  uint8_t primary = 0;
  wifi_second_chan_t second = WIFI_SECOND_CHAN_NONE;
  if(ESP_OK != esp_wifi_get_channel(&primary, &second))return String("?");
  return String((unsigned)primary);
}

// 发射功率。注意 WiFi.getTxPower() 返回的是 0.25dBm 为单位的值
// （WIFI_POWER_19_5dBm = 78 → 19.5dBm），别直接当 dBm 用。
String wifi_txpower()
{
  int q = (int)WiFi.getTxPower();   // 0.25dBm 单位
  char buf[20];

  if(0 == (q % 4))     snprintf(buf, sizeof(buf), "%d dBm", q / 4);
  else if(0 == (q % 2))snprintf(buf, sizeof(buf), "%.1f dBm", q / 4.0);
  else                 snprintf(buf, sizeof(buf), "%.2f dBm", q / 4.0);

  return String(buf);
}

// 设备级名字：arduino 3.x 放在 NetworkManager 里，哪个 netif 起来就套哪个，
// 默认是 "esp32s3-XXXXXX"（XXXXXX 取 MAC 后 3 字节）。
String wifi_hostname()
{
  const char* h = WiFi.getHostname();
  return h ? String(h) : String("");
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

// MAC 用 esp_wifi_get_mac 直接问驱动：即使某个接口没起来（比如 sta ssid 留空、没 begin()），
// 也能读到该接口的 MAC。
static String wifi_mac_str(wifi_interface_t ifx)
{
  uint8_t mac[6] = {0};
  if(ESP_OK != esp_wifi_get_mac(ifx, mac))return String("?");

  char buf[18];
  snprintf(buf, sizeof(buf), "%02x:%02x:%02x:%02x:%02x:%02x",
           mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
  return String(buf);
}

String wifi_sta_mac()
{
  return wifi_mac_str(WIFI_IF_STA);
}

String wifi_ap_mac()
{
  return wifi_mac_str(WIFI_IF_AP);
}

const char* wifi_ap_ssid()
{
  return ap_ssid.c_str();
}

const char* wifi_ap_pass()
{
  return ap_pass.c_str();
}

const char* wifi_ap_ssid_default()
{
  return ap_ssid_default;
}

const char* wifi_ap_pass_default()
{
  return ap_pass_default;
}

// AP 凭据校验：ssid 1..31 字节；pass 留空（开放热点）或 8..63 字节（WPA2 的要求）。
// 必须在写 EEPROM 之前调用：存了非法密码 → 重启后 softAP 起不来 → 网页也进不去，
// 只能接串口/重新烧写来救。
bool wifi_ap_cred_valid(const String& ssid, const String& pass, String& err)
{
  if(ssid.length() < 1){
    err = "ap ssid 不能为空";
    return false;
  }
  if(ssid.length() > 31){
    err = "ap ssid 最长 31 字节";
    return false;
  }
  if(0 == pass.length()){
    return true;   // 空密码 = 开放热点，合法
  }
  if(pass.length() < 8){
    err = "ap pass 要么留空(开放热点)，要么至少 8 个字符";
    return false;
  }
  if(pass.length() > 63){
    err = "ap pass 最长 63 个字符";
    return false;
  }
  return true;
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
