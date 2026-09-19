#ifndef KBD_EEPROM_H
#define KBD_EEPROM_H

#include <Arduino.h>

void ssidpass_save(String& sta_ssid, String& sta_pass);
void ssidpass_load(String& sta_ssid, String& sta_pass);

void udppeer_save(String& ipv4, int& port);
void udppeer_load(String& ipv4, int& port);

#endif
