#include <WiFi.h>
#include <NetworkUdp.h>
#include <WebServer.h>
#include <string.h>
#include "config.h"
#include "mystor.h"
#include "battery.h"
#include "mahony.h"
#include "planner.h"
//ap
const char* ap_ssid = BOARDNAME;
const char* ap_pass = "12345678";
//std::vector<clients> xxx;
//sta
String sta_ssid = "";
String sta_pass = "";
bool sta_connected = 0;
//tcp 80
WebServer server(80);
//udp 9999
NetworkUDP udp;
String udp_peer_ip = "192.168.5.217";
int udp_peer_port = 9999;




void build_page_head(String& html){
  html += "<a href='/wifi'>wifi</a>\n";
  html += "<a href='/ble'>ble</a>\n";
  html += "<a href='/sensor'>sensor</a>\n";
  html += "<a href='/mahony'>mahony</a>\n";
  html += "<a href='/planner'>planner</a>\n";
  html += "<a href='/led'>led</a>\n";
  html += "<a href='/motor'>motor</a>\n";
  html += "<a href='/battery'>battery</a>\n";
  html += "<hr>\n";
}

void handle_wifi() {
  Serial.println(__FUNCTION__);

  String html;
  build_page_head(html);
  html += "<form action='/wifisave' method='POST'>";
  html += "SSID: <input type='text' name='ssid' value='" + sta_ssid + "'><br>";
  html += "PASS: <input type='password' name='pass' value='" + sta_pass + "'><br>";
  html += "<input type='submit' value='Save'>";
  html += "</form>";
  server.send(200, "text/html", html);
}

void handle_wifi_save() {
  Serial.println(__FUNCTION__);

  sta_ssid = server.arg("ssid");
  sta_pass = server.arg("pass");
  saveCredentials(sta_ssid, sta_pass);
  server.send(200, "text/plain", "Credentials saved. Restarting...");
  delay(1000);
  esp_restart();
}

void handle_ble() {
  Serial.println(__FUNCTION__);

  String html;
  build_page_head(html);
  html += "...";
  server.send(200, "text/html", html);
}

void handle_sensor() {
  Serial.println(__FUNCTION__);

  String html;
  build_page_head(html);
  server.send(200, "text/html", html);
}

void handle_mahony() {
  Serial.println(__FUNCTION__);

  float pid[3];
  mahony_getpid(pid);

  String html;
  build_page_head(html);
  html += "<form action='/mahonysave' method='POST'>";
  html += "p: <input type='text' name='p' value='" + String(pid[0]) + "'><br>";
  html += "i: <input type='text' name='i' value='" + String(pid[1]) + "'><br>";
  html += "<input type='submit' value='Save'>";
  html += "</form>";
  server.send(200, "text/html", html);
}

void handle_mahony_save() {
  Serial.println(__FUNCTION__);

  String str_p = server.arg("p");
  String str_i = server.arg("i");

  float pid[3];
  pid[0] = str_p.toFloat();
  pid[1] = str_i.toFloat();
  Serial.printf("mahony setpid=%f,%f\n", pid[0], pid[1]);
  mahony_setpid(pid);

  server.sendHeader("Location", "/mahony");
  server.send(303);
}

void handle_planner() {
  Serial.println(__FUNCTION__);

  float yaw_pid[3];
  planner_yawring_getpid(yaw_pid);

  float yaw_want;
  planner_yawring_getyaw(&yaw_want);

  float pitch_pid[3];
  planner_pitchring_getpid(pitch_pid);

  float pitch_bias;
  planner_pitchring_getbias(&pitch_bias);

  float speed_pid[3];
  planner_speedring_getpid(speed_pid);

  float speed_ilimit;
  float speed_inte;
  planner_speedring_getilimit(&speed_ilimit, &speed_inte);

  float speed_want;
  float speed_curr;
  planner_speedring_getspeed(&speed_want, &speed_curr);

  char str[3][64];
  String html;
  build_page_head(html);
  html += "<form action='/plannersave' method='POST'>";

  snprintf(str[0], 64, "%.6f", yaw_pid[0]);
  snprintf(str[1], 64, "%.6f", yaw_pid[1]);
  snprintf(str[2], 64, "%.6f", yaw_pid[2]);
  html += "yaw_pid: ";
  html += "<input type='text' name='yaw_p' value='" + String(str[0]) + "'>";
  html += "<input type='text' name='yaw_i' value='" + String(str[1]) + "'>";
  html += "<input type='text' name='yaw_d' value='" + String(str[2]) + "'>";
  html += "<br>";

  snprintf(str[0], 64, "%.f", yaw_want);
  html += "yaw_want: ";
  html += "<input type='text' name='yaw_want' value='" + String(str[0]) + "'>";
  html += "<br>";
  html += "<br>";

  snprintf(str[0], 64, "%.6f", pitch_pid[0]);
  snprintf(str[1], 64, "%.6f", pitch_pid[1]);
  snprintf(str[2], 64, "%.6f", pitch_pid[2]);
  html += "pitch_pid: ";
  html += "<input type='text' name='pitch_p' value='" + String(str[0]) + "'>";
  html += "<input type='text' name='pitch_i' value='" + String(str[1]) + "'>";
  html += "<input type='text' name='pitch_d' value='" + String(str[2]) + "'>";
  html += "<br>";

  snprintf(str[0], 64, "%.6f", pitch_bias);
  html += "pitch_bias: ";
  html += "<input type='text' name='pitch_bias' value='" + String(str[0]) + "'>";
  html += "<br>";
  html += "<br>";

  snprintf(str[0], 64, "%.6f", speed_pid[0]);
  snprintf(str[1], 64, "%.6f", speed_pid[1]);
  snprintf(str[2], 64, "%.6f", speed_pid[2]);
  html += "speed_pid: ";
  html += "<input type='text' name='speed_p' value='" + String(str[0]) + "'>";
  html += "<input type='text' name='speed_i' value='" + String(str[1]) + "'>";
  html += "<input type='text' name='speed_d' value='" + String(str[2]) + "'>";
  html += "<br>";

  snprintf(str[0], 64, "%.6f", speed_ilimit);
  snprintf(str[1], 64, "%.6f", speed_inte);
  html += "speed_ilimit: ";
  html += "<input type='text' name='speed_ilimit' value='" + String(str[0]) + "'>";
  html += "<input type='text' name='speed_inte' value='" + String(str[1]) + "'>";
  html += "<br>";

  snprintf(str[0], 64, "%f", speed_want);
  snprintf(str[1], 64, "%f", speed_curr);
  html += "speed_value: ";
  html += "<input type='text' name='speed_want' value='" + String(str[0]) + "'>";
  html += "<input type='text' name='speed_curr' value='" + String(str[1]) + "'>";
  html += "<br>";

  html += "<input type='submit' value='Save'>";
  html += "</form>";
  server.send(200, "text/html", html);
}

void handle_planner_save() {
  Serial.println(__FUNCTION__);

  float pid[3];
  pid[0] = server.arg("yaw_p").toFloat();
  pid[1] = server.arg("yaw_i").toFloat();
  pid[2] = server.arg("yaw_d").toFloat();
  Serial.printf("planner yawring setpid=%f,%f,%f\n", pid[0], pid[1], pid[2]);
  planner_yawring_setpid(pid);

  float yaw_want;
  yaw_want = server.arg("yaw_want").toFloat();
  Serial.printf("planner yawring setwant=%f\n", yaw_want);
  planner_yawring_setyaw(&yaw_want);

  pid[0] = server.arg("pitch_p").toFloat();
  pid[1] = server.arg("pitch_i").toFloat();
  pid[2] = server.arg("pitch_d").toFloat();
  Serial.printf("planner pitchring setpid=%f,%f,%f\n", pid[0], pid[1], pid[2]);
  planner_pitchring_setpid(pid);

  float bias;
  bias = server.arg("pitch_bias").toFloat();
  Serial.printf("planner pitchring setbias=%f\n", bias);
  planner_pitchring_setbias(&bias);

  pid[0] = server.arg("speed_p").toFloat();
  pid[1] = server.arg("speed_i").toFloat();
  pid[2] = server.arg("speed_d").toFloat();
  Serial.printf("planner speedring setpid=%f,%f,%f\n", pid[0], pid[1], pid[2]);
  planner_speedring_setpid(pid);

  float ilimit;
  ilimit = server.arg("speed_ilimit").toFloat();
  Serial.printf("planner speedhring setilimit=%f\n", ilimit);
  planner_speedring_setilimit(&ilimit);

  float speed_want;
  speed_want = server.arg("speed_want").toFloat();
  Serial.printf("planner speedhring setspeed=%f\n", speed_want);
  planner_speedring_setspeed(&speed_want);

  server.sendHeader("Location", "/planner");
  server.send(303);
}

void handle_led() {
  Serial.println(__FUNCTION__);

  String html;
  build_page_head(html);
  server.send(200, "text/html", html);
}

void handle_motor() {
  Serial.println(__FUNCTION__);

  String html;
  build_page_head(html);
  server.send(200, "text/html", html);
}

void handle_battery() {
  Serial.println(__FUNCTION__);

  float volt[4];
  getvolt(volt);

  String html;
  build_page_head(html);
  html += "<pre>";
  html += "v1=" + String(volt[0]) + "\n";
  html += "v2=" + String(volt[1]) + "\n";
  html += "v3=" + String(volt[2]) + "\n";
  html += "v4=" + String(volt[3]) + "\n";
  html += "</pre>";
  server.send(200, "text/html", html);
}

void handleRoot() {
  //Serial.printf("%s\n", __FUNCTION__);
  handle_wifi();
}

void wifi_init_webserver()
{
  server.on("/", handleRoot);

  server.on("/wifi", handle_wifi);
  server.on("/wifisave", handle_wifi_save);

  server.on("/ble", handle_ble);

  server.on("/sensor", handle_sensor);

  server.on("/mahony", handle_mahony);
  server.on("/mahonysave", handle_mahony_save);

  server.on("/planner", handle_planner);
  server.on("/plannersave", handle_planner_save);

  server.on("/led", handle_led);

  server.on("/motor", handle_motor);

  server.on("/battery", handle_battery);

  server.begin();
}




void wifi_udp_send(uint8_t buf, int len)
{
  if(sta_connected != true)return;

  udp.beginPacket(udp_peer_ip.c_str(), udp_peer_port);
  //udp.write(buf, len);
  udp.endPacket();
}
void wifi_udp_init()
{
  Serial.println(__FUNCTION__);
  udp.begin(9999);
}
void wifi_udp_poll()
{
  if(sta_connected != true)return;

  int pktlen = udp.parsePacket();
  if(pktlen <= 0)return;
//Serial.println(ret);

  int sz = (pktlen<256) ? pktlen : 256; 
  unsigned char buf[256];
  int readlen = udp.read(buf, sz);
  if(readlen < 0)return;

#if 1
  char str[256] = {0};
  int printlen = (readlen<16) ? readlen : 16;
  int offs = 0;
  for(int j=0;j<printlen;j++)offs += snprintf(str+offs, 256-offs, "%02x%c", buf[j], (j+1<printlen) ? ',' : '\0');

  IPAddress ip = udp.remoteIP();
  int port = udp.remotePort();
  Serial.printf("%d.%d.%d.%d@%d -> %s\n", ip[0], ip[1], ip[2], ip[3], port, str);
#endif

  float val = 0;
  switch(buf[0]){
  case 's':
    val = -5000;
    planner_speedring_setspeed(&val);
    break;
  case 'w':
    val = 5000;
    planner_speedring_setspeed(&val);
    break;
  case 'a':
    val = -600;
    planner_yawring_setyaw(&val);
    break;
  case 'd':
    val = 600;
    planner_yawring_setyaw(&val);
    break;
  }

  if(readlen < pktlen){
    Serial.printf("(pktlen=%d, uselen=%d, drop remain)\n", pktlen, readlen);
    udp.clear();
  }
}




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
    wifi_udp_init();
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
  if(sta_ssid.equals(""))loadCredentials(sta_ssid, sta_pass);
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

    for(int j=0;j<3;j++){
      if(WiFi.status() == WL_CONNECTED) {
        Serial.println("WL_CONNECTED");
        break;
      }
      delay(500);
    }
  }

  //web
  wifi_init_webserver();
}

void wifi_poll()
{
  server.handleClient();
  wifi_udp_poll();
}
