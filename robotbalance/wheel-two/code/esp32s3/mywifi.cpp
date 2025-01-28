#include <WiFi.h>
#include <WebServer.h>
#include <EEPROM.h>

const char* ap_ssid = "esp32s3_muselab";
const char* ap_password = "12345678";

String sta_ssid = "";
String sta_password = "";

WebServer server(80);

void saveCredentials() {
  EEPROM.begin(512);
  EEPROM.put(0, sta_ssid);
  EEPROM.put(128, sta_password);
  EEPROM.commit();
  EEPROM.end();
}

void loadCredentials() {
  EEPROM.begin(512);
  EEPROM.get(0, sta_ssid);
  EEPROM.get(128, sta_password);
  EEPROM.end();
}

void handleRoot() {
  String html = "<form action='/save' method='POST'>";
  html += "SSID: <input type='text' name='ssid' value='" + sta_ssid + "'><br>";
  html += "Password: <input type='password' name='password' value='" + sta_password + "'><br>";
  html += "<input type='submit' value='Save'>";
  html += "</form>";
  server.send(200, "text/html", html);
}

void handleSave() {
  sta_ssid = server.arg("ssid");
  sta_password = server.arg("password");
  saveCredentials();
  server.send(200, "text/plain", "Credentials saved. Restarting...");
  delay(1000);
  ESP.restart();
}

void WiFiEvent(WiFiEvent_t event) {
  switch (event) {
    ARDUINO_EVENT_WIFI_READY:
      Serial.println("ARDUINO_EVENT_WIFI_READY");
      break;
    ARDUINO_EVENT_WIFI_SCAN_DONE:
      Serial.println("ARDUINO_EVENT_WIFI_SCAN_DONE");
      break;
    ARDUINO_EVENT_WIFI_STA_START:
      Serial.println("ARDUINO_EVENT_WIFI_STA_START");
      break;
    ARDUINO_EVENT_WIFI_STA_STOP:
      Serial.println("ARDUINO_EVENT_WIFI_STA_STOP");
      break;
    ARDUINO_EVENT_WIFI_STA_CONNECTED:
      Serial.println("ARDUINO_EVENT_WIFI_STA_CONNECTED");
      break;
    ARDUINO_EVENT_WIFI_STA_DISCONNECTED:
      Serial.println("ARDUINO_EVENT_WIFI_STA_DISCONNECTED");
      break;
    ARDUINO_EVENT_WIFI_STA_AUTHMODE_CHANGE:
      Serial.println("ARDUINO_EVENT_WIFI_STA_AUTHMODE_CHANGE");
      break;
    ARDUINO_EVENT_WIFI_STA_GOT_IP:
      Serial.printf("ARDUINO_EVENT_WIFI_STA_GOT_IP: %s\n", WiFi.localIP());
      break;
    ARDUINO_EVENT_WIFI_STA_GOT_IP6:
      Serial.println("ARDUINO_EVENT_WIFI_STA_GOT_IP6");
      break;
    ARDUINO_EVENT_WIFI_STA_LOST_IP:
      Serial.println("ARDUINO_EVENT_WIFI_STA_LOST_IP");
      break;
    ARDUINO_EVENT_WIFI_AP_START:
      Serial.println("ARDUINO_EVENT_WIFI_AP_START");
      break;
    ARDUINO_EVENT_WIFI_AP_STOP:
      Serial.println("ARDUINO_EVENT_WIFI_AP_STOP");
      break;
    ARDUINO_EVENT_WIFI_AP_STACONNECTED:
      Serial.println("ARDUINO_EVENT_WIFI_AP_STACONNECTED");
      break;
    ARDUINO_EVENT_WIFI_AP_STADISCONNECTED:
      Serial.println("ARDUINO_EVENT_WIFI_AP_STADISCONNECTED");
      break;
    ARDUINO_EVENT_WIFI_AP_STAIPASSIGNED:
      Serial.println("ARDUINO_EVENT_WIFI_AP_STAIPASSIGNED");
      break;
    ARDUINO_EVENT_WIFI_AP_PROBEREQRECVED:
      Serial.println("ARDUINO_EVENT_WIFI_AP_PROBEREQRECVED");
      break;
    ARDUINO_EVENT_WIFI_AP_GOT_IP6:
      Serial.println("ARDUINO_EVENT_WIFI_AP_GOT_IP6");
      break;
    ARDUINO_EVENT_WIFI_FTM_REPORT:
      Serial.println("ARDUINO_EVENT_WIFI_FTM_REPORT");
      break;
    ARDUINO_EVENT_ETH_START:
      Serial.println("ARDUINO_EVENT_ETH_START");
      break;
    ARDUINO_EVENT_ETH_STOP:
      Serial.println("ARDUINO_EVENT_ETH_STOP");
      break;
    ARDUINO_EVENT_ETH_CONNECTED:
      Serial.println("ARDUINO_EVENT_ETH_CONNECTED");
      break;
    ARDUINO_EVENT_ETH_DISCONNECTED:
      Serial.println("ARDUINO_EVENT_ETH_DISCONNECTED");
      break;
    ARDUINO_EVENT_ETH_GOT_IP:
      Serial.println("ARDUINO_EVENT_ETH_GOT_IP");
      break;
    ARDUINO_EVENT_ETH_GOT_IP6:
      Serial.println("ARDUINO_EVENT_ETH_GOT_IP6");
      break;
    ARDUINO_EVENT_WPS_ER_SUCCESS:
      Serial.println("ARDUINO_EVENT_WPS_ER_SUCCESS");
      break;
    ARDUINO_EVENT_WPS_ER_FAILED:
      Serial.println("ARDUINO_EVENT_WPS_ER_FAILED");
      break;
    ARDUINO_EVENT_WPS_ER_TIMEOUT:
      Serial.println("ARDUINO_EVENT_WPS_ER_TIMEOUT");
      break;
    ARDUINO_EVENT_WPS_ER_PIN:
      Serial.println("ARDUINO_EVENT_WPS_ER_PIN");
      break;
    ARDUINO_EVENT_WPS_ER_PBC_OVERLAP:
      Serial.println("ARDUINO_EVENT_WPS_ER_PBC_OVERLAP");
      break;
    ARDUINO_EVENT_SC_SCAN_DONE:
      Serial.println("ARDUINO_EVENT_SC_SCAN_DONE");
      break;
    ARDUINO_EVENT_SC_FOUND_CHANNEL:
      Serial.println("ARDUINO_EVENT_SC_FOUND_CHANNEL");
      break;
    ARDUINO_EVENT_SC_GOT_SSID_PSWD:
      Serial.println("ARDUINO_EVENT_SC_GOT_SSID_PSWD");
      break;
    ARDUINO_EVENT_SC_SEND_ACK_DONE:
      Serial.println("ARDUINO_EVENT_SC_SEND_ACK_DONE");
      break;
    ARDUINO_EVENT_PROV_INIT:
      Serial.println("ARDUINO_EVENT_PROV_INIT");
      break;
    ARDUINO_EVENT_PROV_DEINIT:
      Serial.println("ARDUINO_EVENT_PROV_DEINIT");
      break;
    ARDUINO_EVENT_PROV_START:
      Serial.println("ARDUINO_EVENT_PROV_START");
      break;
    ARDUINO_EVENT_PROV_END:
      Serial.println("ARDUINO_EVENT_PROV_END");
      break;
    ARDUINO_EVENT_PROV_CRED_RECV:
      Serial.println("ARDUINO_EVENT_PROV_CRED_RECV");
      break;
    ARDUINO_EVENT_PROV_CRED_FAIL:
      Serial.println("ARDUINO_EVENT_PROV_CRED_FAIL");
      break;
    ARDUINO_EVENT_PROV_CRED_SUCCESS:
      Serial.println("ARDUINO_EVENT_PROV_CRED_SUCCESS");
      break;
    default:
      Serial.printf("Unknown WiFi event: %d\n", event);
      break;
  }
}

void initwifi()
{
  loadCredentials();
  Serial.printf("ap: ssid=%s, pass=%s\n", ap_ssid, ap_password);
  Serial.printf("sta: ssid=%s, pass=%s\n", sta_ssid.c_str(), sta_password.c_str());

  WiFi.onEvent(WiFiEvent);

  WiFi.softAP(ap_ssid, ap_password);
  WiFi.begin(sta_ssid.c_str(), sta_password.c_str());

  server.on("/", handleRoot);
  server.on("/save", handleSave);
  server.begin();

  Serial.println("AP IP address: " + WiFi.softAPIP().toString());
}

void pollwifi()
{
  server.handleClient();
}
