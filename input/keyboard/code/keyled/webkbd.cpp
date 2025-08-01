
#include <WebServer.h>
#include "kbd_eeprom.h"

WebServer server(80);
//
extern String sta_ssid;
extern String sta_pass;
//
extern String udp_peer_ipv4;
extern int udp_peer_port;


void build_page_head(String& html){
  html += "<a href='/wifistat'>wifi</a>\n";
  html += "<a href='/udpstat'>udp</a>\n";
  html += "<hr>\n";
}


void handle_wifi_stat() {
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
  ssidpass_save(sta_ssid, sta_pass);
  server.send(200, "text/plain", "ssidpass saved. Restarting...");
  delay(1000);
  esp_restart();
}


void handle_udp_stat() {
  Serial.println(__FUNCTION__);

  String html;
  build_page_head(html);
  html += "<form action='/udpsave' method='POST'>";
  html += "ipv4: <input type='text' name='ipv4' value='" + udp_peer_ipv4 + "'><br>";
  html += "port: <input type='text' name='port' value='" + String(udp_peer_port) + "'><br>";
  html += "<input type='submit' value='Save'>";
  html += "</form>";
  server.send(200, "text/html", html);
}
void handle_udp_save() {
  Serial.println(__FUNCTION__);

  udp_peer_ipv4 = server.arg("ipv4");
  udp_peer_port = server.arg("port").toInt();
  udppeer_save(udp_peer_ipv4, udp_peer_port);

  server.sendHeader("Location", "/udpstat");
  server.send(303);
}


void handleRoot() {
  handle_wifi_stat();
}


void wifi_web_poll(){
  server.handleClient();
}
void wifi_web_init()
{
  server.on("/wifistat", handle_wifi_stat);
  server.on("/wifisave", handle_wifi_save);

  server.on("/udpstat", handle_udp_stat);
  server.on("/udpsave", handle_udp_save);

  server.on("/", handleRoot);
  server.begin();
}
