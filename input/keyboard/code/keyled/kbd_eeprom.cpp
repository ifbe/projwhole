#include <Arduino.h>
#include <string.h>
#include <EEPROM.h>


#define where_ssid 0
#define where_pass 128
void ssidpass_save(String& sta_ssid, String& sta_pass) {
  EEPROM.begin(512);
  EEPROM.put(where_ssid, sta_ssid);
  EEPROM.put(where_pass, sta_pass);
  EEPROM.commit();
  EEPROM.end();
}
void ssidpass_load(String& sta_ssid, String& sta_pass) {
  EEPROM.begin(512);
  EEPROM.get(where_ssid, sta_ssid);
  EEPROM.get(where_pass, sta_pass);
  EEPROM.end();
}


#define where_udppeer_ipv4 (128*2)
#define where_udppeer_port (128*3)
void udppeer_save(String& ipv4, int& port){
  EEPROM.begin(512);
  EEPROM.put(where_udppeer_ipv4, ipv4);
  EEPROM.put(where_udppeer_port, port);
  EEPROM.commit();
  EEPROM.end();
}
void udppeer_load(String& ipv4, int& port){
  EEPROM.begin(512);
  EEPROM.get(where_udppeer_ipv4, ipv4);
  EEPROM.get(where_udppeer_port, port);
  EEPROM.end();
}