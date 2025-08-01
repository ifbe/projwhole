
//wifi
#include <WiFi.h>
#include <string.h>
//
#include "kbd_eeprom.h"
#include "webkbd.h"
#include "udpkbd.h"
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
    Serial.println("ARDUINO_EVENT_WIFI_OFF");
    break;
  case ARDUINO_EVENT_WIFI_READY:
    Serial.println("ARDUINO_EVENT_WIFI_READY");
    break;
  case ARDUINO_EVENT_WIFI_SCAN_DONE:
    Serial.println("ARDUINO_EVENT_WIFI_SCAN_DONE");
    break;
  case ARDUINO_EVENT_WIFI_FTM_REPORT:
    Serial.println("ARDUINO_EVENT_WIFI_FTM_REPORT");
    break;
  case ARDUINO_EVENT_WIFI_STA_START:   //110
    Serial.println("ARDUINO_EVENT_WIFI_STA_START");
    break;
  case ARDUINO_EVENT_WIFI_STA_STOP:
    Serial.println("ARDUINO_EVENT_WIFI_STA_STOP");
    break;
  case ARDUINO_EVENT_WIFI_STA_CONNECTED:
    Serial.println("ARDUINO_EVENT_WIFI_STA_CONNECTED");
    break;
  case ARDUINO_EVENT_WIFI_STA_DISCONNECTED:
    switch(info.wifi_sta_disconnected.reason){
    case WIFI_REASON_NO_AP_FOUND:
      Serial.printf("ARDUINO_EVENT_WIFI_STA_DISCONNECTED: reason=WIFI_REASON_NO_AP_FOUND\n");
      if(false==sta_connected)WiFi.setAutoReconnect(false);   //never connected
      break;
    default:
      Serial.printf("ARDUINO_EVENT_WIFI_STA_DISCONNECTED: reason=%d\n", info.wifi_sta_disconnected.reason);
      break;
    }
    sta_connected = false;
    break;
  case ARDUINO_EVENT_WIFI_STA_AUTHMODE_CHANGE:
    Serial.println("ARDUINO_EVENT_WIFI_STA_AUTHMODE_CHANGE");
    break;
  case ARDUINO_EVENT_WIFI_STA_GOT_IP:
    Serial.printf("ARDUINO_EVENT_WIFI_STA_GOT_IP: %s\n", WiFi.localIP().toString());
    sta_connected = true;
    break;
  case ARDUINO_EVENT_WIFI_STA_GOT_IP6:
    Serial.println("ARDUINO_EVENT_WIFI_STA_GOT_IP6");
    break;
  case ARDUINO_EVENT_WIFI_STA_LOST_IP:
    Serial.println("ARDUINO_EVENT_WIFI_STA_LOST_IP");
    break;
  case ARDUINO_EVENT_WIFI_AP_START:    //130
    Serial.println("ARDUINO_EVENT_WIFI_AP_START");
    break;
  case ARDUINO_EVENT_WIFI_AP_STOP:
    Serial.println("ARDUINO_EVENT_WIFI_AP_STOP");
    break;
  case ARDUINO_EVENT_WIFI_AP_STACONNECTED:
    Serial.println("ARDUINO_EVENT_WIFI_AP_STACONNECTED");
    break;
  case ARDUINO_EVENT_WIFI_AP_STADISCONNECTED:
    Serial.println("ARDUINO_EVENT_WIFI_AP_STADISCONNECTED");
    break;
  case ARDUINO_EVENT_WIFI_AP_STAIPASSIGNED:
    Serial.println("ARDUINO_EVENT_WIFI_AP_STAIPASSIGNED");
    break;
  case ARDUINO_EVENT_WIFI_AP_PROBEREQRECVED:
    Serial.println("ARDUINO_EVENT_WIFI_AP_PROBEREQRECVED");
    break;
  case ARDUINO_EVENT_WIFI_AP_GOT_IP6:
    Serial.println("ARDUINO_EVENT_WIFI_AP_GOT_IP6");
    break;
  default:
    Serial.printf("Unknown WiFi event: %d\n", event);
    break;
  }
}

void wifi_init()
{
  //load
  if(sta_ssid.equals(""))ssidpass_load(sta_ssid, sta_pass);
  Serial.printf("ap: ssid=%s, pass=%s\n", ap_ssid, ap_pass);
  Serial.printf("sta: ssid=%s, pass=%s\n", sta_ssid.c_str(), sta_pass.c_str());

  //event
  WiFi.onEvent(WiFiEvent);

  //ap
  WiFi.softAP(ap_ssid, ap_pass);
  Serial.println("AP IP address: " + WiFi.softAPIP().toString());

  //sta
  if( (sta_ssid[0]>=' ')&&(sta_ssid[0]<0x80) ){
    Serial.println("wifi.begin");
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
