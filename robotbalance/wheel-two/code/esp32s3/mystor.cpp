
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
