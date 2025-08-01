#include "config.h"
#include <Arduino.h>
#include <NetworkUdp.h>
#include "kbd_eeprom.h"


NetworkUDP udp;
//
String udp_self_ipv4 = "";
int udp_self_port = 9999;
//
String udp_peer_ipv4 = "";  //"192.168.5.217";
int udp_peer_port = 0;    //9999;


//
static uint8_t keytable_arrow[4][4] = {
  {  0,   0, '+', 'k'},
  {  0,   0, 'j', '-'},
  {'f', 'r',   0,   0},
  {'l', 'b',   0,   0}
};




void wifi_udp_send(int x, int y)
{
  if(0 == udp_peer_port)return;

  if(mode_chosen == mode_arrow){
    if( (x<0) || (x>=4) || (y<0) || (y>=4) )return;
    if(keytable_arrow[y][x] == 0)return;

    udp.beginPacket(udp_peer_ipv4.c_str(), udp_peer_port);
    //udp.write(buf, len);
    udp.write(keytable_arrow[y][x]);
    udp.endPacket();
  }
}




void wifi_udp_init()
{
  Serial.println(__FUNCTION__);
  udp.begin(udp_self_port);

  if(udp_peer_ipv4.equals("") || (0 == udp_peer_port) ){
    udppeer_load(udp_peer_ipv4, udp_peer_port);
  }
  Serial.printf("udppeer: ipv4=%s, port=%d\n", udp_peer_ipv4.c_str(), udp_peer_port);
}
void wifi_udp_poll()
{
  int pktlen = udp.parsePacket();
  if(pktlen <= 0)return;
//Serial.println(ret);

  int sz = (pktlen<256) ? pktlen : 256; 
  unsigned char buf[256];
  int readlen = udp.read(buf, sz);
  if(readlen < 0)return;

  if(readlen < pktlen){
    Serial.printf("(pktlen=%d, uselen=%d, drop remain)\n", pktlen, readlen);
    udp.clear();
  }

#if 1
  char str[256] = {0};
  int printlen = (readlen<16) ? readlen : 16;
  int offs = 0;
  for(int j=0;j<printlen;j++)offs += snprintf(str+offs, 256-offs, "%02x%c", buf[j], (j+1<printlen) ? ',' : '\0');

  IPAddress ip = udp.remoteIP();
  int port = udp.remotePort();
  Serial.printf("%d.%d.%d.%d@%d: %d/%d %s\n", ip[0], ip[1], ip[2], ip[3], port, readlen, pktlen, str);
#endif
}
