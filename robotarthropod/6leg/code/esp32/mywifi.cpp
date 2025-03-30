/*
pin adc(warning: adc2 conflict with wifi)
  0 2.1
  2 2.2
  4 2.0
 12 2.5
 13 2.4
 14 2.6
 15 2.3
 25 2.8
 26 2.9
 27 2.7
 32 1.4
 33 1.5
 34 1.6
 35 1.7
 36 1.0
 37 1.1
 38 1.2
 39 1.3
*/
#define PIN_VOLT1 34
#define PIN_VOLT2 35




//motor
void motor_disable();
//
void motor_static_get(int* out);
void motor_static_set(int* in);
//
void motor_dynamic_set(int type);




//eeprom
#include <EEPROM.h>
#define where_ssid 0
#define where_pass 128
void saveCredentials(String& sta_ssid, String& sta_pass) {
  EEPROM.begin(512);
  EEPROM.put(where_ssid, sta_ssid);
  EEPROM.put(where_pass, sta_pass);
  EEPROM.commit();
  EEPROM.end();
}
void loadCredentials(String& sta_ssid, String& sta_pass) {
  EEPROM.begin(512);
  EEPROM.get(where_ssid, sta_ssid);
  EEPROM.get(where_pass, sta_pass);
  EEPROM.end();
}




//wifi
#include <WiFi.h>
//#include <NetworkUdp.h>
#include <WebServer.h>
#include <string.h>
//ap
const char* ap_ssid = "esp32_goouuu";
const char* ap_pass = "12345678";
//std::vector<clients> xxx;
//sta
String sta_ssid = "";
String sta_pass = "";
bool sta_connected = 0;
//tcp 80
WebServer server(80);
/*
//udp 9999
NetworkUDP udp;
String udp_peer_ip = "192.168.5.217";
int udp_peer_port = 9999;
*/




void build_page_head(String& html){
  html += "<a href='/wifi'>wifi</a>\n";
  html += "<a href='/battery'>battery</a>\n";
  html += "<a href='/motor'>motor</a>\n";
  html += "<hr>\n";
}

void handle_battery() {
  Serial.println(__FUNCTION__);

  float a1 = analogRead(PIN_VOLT1) * 3.3 / 4096;
  float a2 = analogRead(PIN_VOLT2) * 3.3 / 4096;
  a1 *= (100+50) / 100.0;
  a2 *= (100+50) / 50.0;
  Serial.printf("volt:%f,%f\n", a1, a2);

  String html;
  build_page_head(html);
  html += "<input type='text' value='" + String(a1) + "'>";
  html += "<br>";
  html += "<input type='text' value='" + String(a2) + "'>";
  html += "<br>";

  server.send(200, "text/html", html);
}

void handle_motor() {
  Serial.println(__FUNCTION__);

  /*
  0 6
  1 7
  2 8
  3 9
  4 10
  5 11
  */
  int val[12];
  motor_static_get(val);

  String html;
  build_page_head(html);

  //
  html += "<form action='/motor_dynamic_moveforward' method='POST'>";
  html += "<input type='submit' value='move forward'>";
  html += "</form>";

  html += "<form action='/motor_dynamic_moveback' method='POST'>";
  html += "<input type='submit' value='move back'>";
  html += "</form>";

  html += "<form action='/motor_dynamic_rotateleft' method='POST'>";
  html += "<input type='submit' value='rotate left'>";
  html += "</form>";

  html += "<form action='/motor_dynamic_rotateright' method='POST'>";
  html += "<input type='submit' value='rotate right'>";
  html += "</form>";

  html += "<hr>";

  //
  html += "<form action='/motor_static_up' method='POST'>";
  html += "<input type='submit' value='up'>";
  html += "</form>";

  //
  html += "<form action='/motor_static_mid' method='POST'>";
  html += "<input type='submit' value='mid'>";
  html += "</form>";

  //
  html += "<form action='/motor_static_down' method='POST'>";
  html += "<input type='submit' value='down'>";
  html += "</form>";

  html += "<hr>";

  //
  html += "<form action='/motor_static_raw' method='POST'>";
  //front
  html += "<input class='resetable' type='text' name='lft' value='" + String(val[0]) + "'>";
  html += " front-top";
  html += "<input class='resetable' type='text' name='rft' value='" + String(val[6]) + "'>";
  html += "<br>";
  html += "<input class='resetable' type='text' name='lfb' value='" + String(val[1]) + "'>";
  html += " front-bot";
  html += "<input class='resetable' type='text' name='rfb' value='" + String(val[7]) + "'>";
  html += "<br>";
  //mid
  html += "<input class='resetable' type='text' name='lmt' value='" + String(val[2]) + "'>";
  html += " mid-top";
  html += "<input class='resetable' type='text' name='rmt' value='" + String(val[8]) + "'>";
  html += "<br>";
  html += "<input class='resetable' type='text' name='lmb' value='" + String(val[3]) + "'>";
  html += " mid-bot";
  html += "<input class='resetable' type='text' name='rmb' value='" + String(val[9]) + "'>";
  html += "<br>";
  //back
  html += "<input class='resetable' type='text' name='lbt' value='" + String(val[4]) + "'>";
  html += " back-top";
  html += "<input class='resetable' type='text' name='rbt' value='" + String(val[10]) + "'>";
  html += "<br>";
  html += "<input class='resetable' type='text' name='lbb' value='" + String(val[5]) + "'>";
  html += " back-bot";
  html += "<input class='resetable' type='text' name='rbb' value='" + String(val[11]) + "'>";
  html += "<br>";
  //button
  html += "<input type='submit' value='set'>";
  //button
  //html += "<button onclick='resetValues()'>Reset to 75</button>";
  //
  html += "</form>";

  //seprator
  html += "<hr>";

  //disable
  html += "<form action='/motor_disable' method='POST'>";
  html += "<input type='submit' value='disable'>";
  html += "</form>";

/*
  //js
  html += "<script>"
"function resetValues(){"
" var inputs = document.querySelectorAll('.resetable');"
" inputs.forEach("
"  function(input){input.value = '0';}"
" );"
"}"
"</script>";
*/
  server.send(200, "text/html", html);
}

void handle_motor_disable() {
  Serial.println(__FUNCTION__);

  motor_disable();

  server.sendHeader("Location", "/motor");
  server.send(303);
}

void handle_motor_raw() {
  Serial.println(__FUNCTION__);

  int val[12];
  val[0] = server.arg("lft").toInt();
  val[1] = server.arg("lfb").toInt();
  val[2] = server.arg("lmt").toInt();
  val[3] = server.arg("lmb").toInt();
  val[4] = server.arg("lbt").toInt();
  val[5] = server.arg("lbb").toInt();
  val[6] = server.arg("rft").toInt();
  val[7] = server.arg("rfb").toInt();
  val[8] = server.arg("rmt").toInt();
  val[9] = server.arg("rmb").toInt();
  val[10] = server.arg("rbt").toInt();
  val[11] = server.arg("rbb").toInt();
  motor_static_set(val);

  server.sendHeader("Location", "/motor");
  server.send(303);
}

void motor_static_up() {
  Serial.println(__FUNCTION__);

  int val[12];
  for(int j=0;j<12;j++)val[j] = 0;
  for(int j=1;j<12;j+=2)val[j] = -25;
  motor_static_set(val);

  server.sendHeader("Location", "/motor");
  server.send(303);
}

void motor_static_mid() {
  Serial.println(__FUNCTION__);

  int val[12];
  for(int j=0;j<12;j++)val[j] = 0;
  motor_static_set(val);

  server.sendHeader("Location", "/motor");
  server.send(303);
}

void motor_static_down() {
  Serial.println(__FUNCTION__);

  int val[12];
  for(int j=0;j<12;j++)val[j] = 0;
  for(int j=1;j<12;j+=2)val[j] = 25;
  motor_static_set(val);

  server.sendHeader("Location", "/motor");
  server.send(303);
}

void motor_dynamic_moveforward() {
  Serial.println(__FUNCTION__);

  motor_dynamic_set('f');

  server.sendHeader("Location", "/motor");
  server.send(303);
}
void motor_dynamic_moveback() {
  Serial.println(__FUNCTION__);

  motor_dynamic_set('b');

  server.sendHeader("Location", "/motor");
  server.send(303);
}
void motor_dynamic_rotateleft() {
  Serial.println(__FUNCTION__);

  motor_dynamic_set('l');

  server.sendHeader("Location", "/motor");
  server.send(303);
}

void motor_dynamic_rotateright() {
  Serial.println(__FUNCTION__);

  motor_dynamic_set('r');

  server.sendHeader("Location", "/motor");
  server.send(303);
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

void handleRoot() {
  handle_wifi();
}

void wifi_init_webserver()
{
  server.on("/", handleRoot);

  server.on("/wifi", handle_wifi);
  server.on("/wifisave", handle_wifi_save);


  server.on("/battery", handle_battery);

  server.on("/motor", handle_motor);
  server.on("/motor_disable", handle_motor_disable);
  server.on("/motor_static_raw", handle_motor_raw);
  server.on("/motor_static_up", motor_static_up);
  server.on("/motor_static_mid", motor_static_mid);
  server.on("/motor_static_down", motor_static_down);
  server.on("/motor_dynamic_rotateleft", motor_dynamic_rotateleft);
  server.on("/motor_dynamic_rotateright", motor_dynamic_rotateright);
  server.on("/motor_dynamic_moveforward", motor_dynamic_moveforward);
  server.on("/motor_dynamic_moveback", motor_dynamic_moveback);

  server.begin();
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
    //wifi_udp_init();
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
  loadCredentials(sta_ssid, sta_pass);
  Serial.printf("ap: ssid=%s, pass=%s\n", ap_ssid, ap_pass);
  Serial.printf("sta: ssid=%s, pass=%s\n", sta_ssid.c_str(), sta_pass.c_str());

  //event
  WiFi.onEvent(WiFiEvent);

  //ap
  WiFi.softAP(ap_ssid, ap_pass);
  Serial.println("AP IP address: " + WiFi.softAPIP().toString());

  //sta
  if( (sta_ssid[0]>=' ')&&(sta_ssid[0]<0x80) ){
    WiFi.begin(sta_ssid.c_str(), sta_pass.c_str());
  }

  //web
  wifi_init_webserver();
}

void wifi_poll()
{
  server.handleClient();
  //wifi_udp_poll();

  pinMode(PIN_VOLT1, INPUT);
  pinMode(PIN_VOLT2, INPUT);
}
