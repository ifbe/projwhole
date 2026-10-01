// 对外通道（socket）：udp / tcp / ws（websocket）三个独立目标，各自在 /socketstat 上配置。
// 约定：**配置留空 = 不启用**（udp/tcp 要 ip+port 都填，ws 要 url 非空），
// 目前只有 udp 真的在发按键（arrow 模式），tcp/ws 先把配置和状态放在这里。
#include "mod_log.h"
#include "keyled.h"
#include <Arduino.h>
#include <NetworkUdp.h>
#include "mod_eeprom.h"
#include "mod_socket.h"


NetworkUDP udp;
//
String udp_self_ipv4 = "";
int udp_self_port = 9999;
//
String udp_peer_ipv4 = "";  //"192.168.5.217";
int udp_peer_port = 0;    //9999;
//
String tcp_peer_ipv4 = "";
int tcp_peer_port = 0;
//
String ws_url = "";         // 形如 ws://192.168.4.2:81/


bool udp_enabled()
{
  return (udp_peer_ipv4.length() > 0) && (udp_peer_port > 0) && (udp_peer_port <= 65535);
}

bool tcp_enabled()
{
  return (tcp_peer_ipv4.length() > 0) && (tcp_peer_port > 0) && (tcp_peer_port <= 65535);
}

bool ws_enabled()
{
  return ws_url.length() > 0;
}


// ---- 配置校验（/socketstat 页面用）----
// 空值一律合法（= 不启用），所以这几个函数只管"填了的话合不合法"。

bool socket_ipv4_check(const String& ip, String& err)
{
  if(0 == ip.length())return true;   // 空 = 不启用

  int dots = 0;
  int val = 0;
  int digits = 0;
  bool ok = true;

  for(size_t i=0;i<ip.length() && ok;i++){
    char c = ip[i];
    if(c == '.'){
      if(0 == digits){
        ok = false;                  // "1..2" / 开头就是 '.'
      }
      else{
        dots++;
        val = 0;
        digits = 0;
      }
    }
    else if(c >= '0' && c <= '9'){
      val = val * 10 + (c - '0');
      digits++;
      if((val > 255) || (digits > 3))ok = false;
    }
    else{
      ok = false;
    }
  }

  if(!ok || (3 != dots) || (0 == digits)){   // 必须是四段
    err = "ipv4 要写成 a.b.c.d（留空 = 不启用）";
    return false;
  }
  return true;
}

bool socket_port_check(int port, String& err)
{
  if(0 == port)return true;          // 0 = 不启用

  if((port < 1) || (port > 65535)){
    err = "port 范围 1-65535（0 或留空 = 不启用）";
    return false;
  }
  return true;
}

bool socket_wsurl_check(const String& url, String& err)
{
  if(0 == url.length())return true;  // 空 = 不启用

  if(url.length() > 127){
    err = "url 最长 127 字节";
    return false;
  }
  for(size_t i=0;i<url.length();i++){
    uint8_t c = (uint8_t)url[i];
    if(c <= 0x20 || c >= 0x7f){      // 不许空格/控制字符/非 ASCII
      err = "url 里不能有空格或不可见字符";
      return false;
    }
  }

  // 至少要像 <scheme>://<host>：不强制只能是 ws/wss，但必须有 scheme 和 host
  int sep = url.indexOf("://");
  if(sep < 1){
    err = "url 要带协议头，形如 ws://192.168.4.2:81/";
    return false;
  }
  if((size_t)sep + 3 >= url.length()){
    err = "url 里 :// 后面没有主机名";
    return false;
  }
  return true;
}


#if mode_chosen == mode_arrow2x2

static uint8_t keytable_arrow[2][2] = {
  {'f', 'r'},
  {'l', 'b'}
};
void wifi_udp_send(int x, int y)
{
  if(!udp_enabled())return;

    if( (x<0) || (x>=2) || (y<0) || (y>=2) )return;
    if(keytable_arrow[y][x] == 0)return;

    udp.beginPacket(udp_peer_ipv4.c_str(), udp_peer_port);
    //udp.write(buf, len);
    udp.write(keytable_arrow[y][x]);
    udp.endPacket();
}

#elif mode_chosen == mode_arrow4x4

static uint8_t keytable_arrow[4][4] = {
  {  0,   0, '+', 'k'},
  {  0,   0, 'j', '-'},
  {'f', 'r',   0,   0},
  {'l', 'b',   0,   0}
};
void wifi_udp_send(int x, int y)
{
  if(!udp_enabled())return;

    if( (x<0) || (x>=4) || (y<0) || (y>=4) )return;
    if(keytable_arrow[y][x] == 0)return;

    udp.beginPacket(udp_peer_ipv4.c_str(), udp_peer_port);
    //udp.write(buf, len);
    udp.write(keytable_arrow[y][x]);
    udp.endPacket();
}

#else

void wifi_udp_send(int x, int y)
{
}

#endif




void socket_init()
{
  kbdlog.println(__FUNCTION__);
  udp.begin(udp_self_port);

  // 三份配置都从 EEPROM 读；读不到就是 ""/0 = 不启用
  if(udp_peer_ipv4.equals("") || (0 == udp_peer_port) ){
    udppeer_load(udp_peer_ipv4, udp_peer_port);
  }
  if(tcp_peer_ipv4.equals("") || (0 == tcp_peer_port) ){
    tcppeer_load(tcp_peer_ipv4, tcp_peer_port);
  }
  if(ws_url.equals("")){
    wsurl_load(ws_url);
  }

  kbdlog.printf("socket: udp=%s (%s:%d)\n", udp_enabled() ? "on" : "off",
                udp_peer_ipv4.c_str(), udp_peer_port);
  kbdlog.printf("socket: tcp=%s (%s:%d)\n", tcp_enabled() ? "on" : "off",
                tcp_peer_ipv4.c_str(), tcp_peer_port);
  kbdlog.printf("socket: ws=%s (%s)\n", ws_enabled() ? "on" : "off", ws_url.c_str());
}

void socket_poll()
{
  int pktlen = udp.parsePacket();
  if(pktlen <= 0)return;
//kbdlog.println(ret);

  int sz = (pktlen<256) ? pktlen : 256; 
  unsigned char buf[256];
  int readlen = udp.read(buf, sz);
  if(readlen < 0)return;

  if(readlen < pktlen){
    kbdlog.printf("(pktlen=%d, uselen=%d, drop remain)\n", pktlen, readlen);
    udp.clear();
  }

#if 1
  char str[256] = {0};
  int printlen = (readlen<16) ? readlen : 16;
  int offs = 0;
  for(int j=0;j<printlen;j++)offs += snprintf(str+offs, 256-offs, "%02x%c", buf[j], (j+1<printlen) ? ',' : '\0');

  IPAddress ip = udp.remoteIP();
  int port = udp.remotePort();
  kbdlog.printf("%d.%d.%d.%d@%d: %d/%d %s\n", ip[0], ip[1], ip[2], ip[3], port, readlen, pktlen, str);
#endif
}
