#include <Arduino.h>
#include <NetworkUdp.h>
void motor_static_set(int* in);
void motor_dynamic_set(int type);


NetworkUDP udp;
//
String udp_self_ipv4 = "";
int udp_self_port = 9999;
//
String udp_peer_ipv4 = "";  //"192.168.5.217";
int udp_peer_port = 0;    //9999;


//
extern bool sta_connected;


static int height = 0;
void riseorfall(int delta){
  height += delta;
  if(height >  25)height = 25;
  if(height < -25)height =-25;

  int val[12];
  for(int j=0;j<12;j++)val[j] = 0;
  for(int j=1;j<12;j+=2)val[j] = height;
  motor_static_set(val);
}


static int xxxx = 0;
void leftorright(int delta){
  xxxx += delta;
  if(xxxx >  25)xxxx = 25;
  if(xxxx < -25)xxxx =-25;

  int val[12];
  for(int j=0;j<12;j++)val[j] = 0;
  for(int j=0;j<6;j+=2)val[j] = xxxx; //left
  for(int j=6;j<12;j+=2)val[j] =-xxxx; //right
  motor_static_set(val);
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
  if(readlen <= 0)return;

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

  switch(buf[0]){
  case 'f':
  case 'b':
  case 'l':
  case 'r':
    motor_dynamic_set(buf[0]);
    break;
  case '+':
    riseorfall(-5);
    break;
  case '-':
    riseorfall(5);
    break;
  case 'j':
    leftorright(-5);
    break;
  case 'k':
    leftorright(5);
    break;
  }
}




void wifi_udp_init()
{
  Serial.println(__FUNCTION__);
  udp.begin(udp_self_port);
}