
#include "mod_log.h"
#include <WebServer.h>
#include <esp_system.h>
#include "esp32-hal-tinyusb.h"
#include "keyled.h"
#include "mod_eeprom.h"
#include "mod_ws2812b.h"
#include "mod_usb.h"
#include "mod_ble.h"
#include "mod_wifi.h"
#include "mod_socket.h"

WebServer server(80);
//
extern String sta_ssid;
extern String sta_pass;
extern String ap_ssid;
extern String ap_pass;
//
extern String udp_peer_ipv4;
extern int udp_peer_port;
extern String tcp_peer_ipv4;
extern int tcp_peer_port;
extern String ws_url;


void build_page_head(String& html){
  html += "<a href='/wifistat'>wifi</a>\n";
  html += "<a href='/bt'>bt</a>\n";
  html += "<a href='/socketstat'>socket</a>\n";
  html += "<a href='/ws2812bstat'>ws2812b</a>\n";
  html += "<a href='/kbdstat'>keyboard</a>\n";
  html += "<a href='/gpio'>gpio</a>\n";
  html += "<a href='/log'>log</a>\n";
  html += "<a href='/sys'>sys</a>\n";
  html += "<hr>\n";
}

// 转义 & < > " '：键值/日志里可能有用户输入
static String html_escape(const String& in){
  String out;
  out.reserve(in.length() + 16);
  for(const char* p=in.c_str(); '\0'!=*p; p++){
    switch(*p){
    case '&':  out += "&amp;";  break;
    case '<':  out += "&lt;";   break;
    case '>':  out += "&gt;";   break;
    case '"':  out += "&quot;"; break;
    case '\'': out += "&#39;";  break;
    default:   out += *p;       break;
    }
  }
  return out;
}


// wifi 页面：sta（客户端）+ ap（热点）的账号/密码都在这改，保存后重启。
// 全机的 wifi 状态只在这里显示，别的页面不再重复（bt 也一样，见 handle_bt()）。
void handle_wifi_stat() {
  kbdlog.println(__FUNCTION__);

  String html;
  html.reserve(2048);

  html += "<html><head><meta charset='utf-8'><title>wifi</title>";
  html += "<style>body{font-family:monospace;}";
  html += "table{border-collapse:collapse;} td{padding:0 10px 0 0;vertical-align:top;}";
  html += "input[type='text'],input[type='password']{width:240px;}";
  // 每段一张卡片：sta 一张、ap 一张（fit-content 不支持的浏览器退化成整行宽，也能看）
  html += ".card{border:1px solid #ccc;border-radius:6px;padding:8px 12px;margin-bottom:12px;width:fit-content;}";
  html += "</style></head><body>\n";
  build_page_head(html);

  html += "<h3>wifi</h3>\n";

  // status 卡：只放 wifi 共有的东西（AP/STA 是同一颗射频的两个角色）。
  // 各角色自己的 status/ip/rssi/stations 留在各自那张卡里。
  html += "<div class='card'>\n";
  html += "<b>status</b>\n";
  html += "<table>\n";
  html += "<tr><td>mode</td><td>" + String(wifi_mode_str()) + "</td></tr>\n";
  html += "<tr><td>channel</td><td>" + wifi_channel() + "</td></tr>\n";
  html += "<tr><td>txpower</td><td>" + wifi_txpower() + "</td></tr>\n";
  html += "<tr><td>hostname</td><td>" + html_escape(wifi_hostname()) + "</td></tr>\n";
  html += "</table>\n";
  html += "</div>\n";

  // sta 配置卡：/stasave 只碰 sta；status/ip/rssi 是这个角色自己的状态，放这张卡里
  html += "<div class='card'>\n";
  html += "<b>sta (client)</b>\n";
  html += "<form action='/stasave' method='POST'>";
  html += "<table>\n";
  html += "<tr><td>sta ssid</td><td><input type='text' name='ssid' value='" + html_escape(sta_ssid) + "'></td></tr>\n";
  html += "<tr><td>sta pass</td><td><input type='password' name='pass' value='" + html_escape(sta_pass) + "'></td></tr>\n";
  html += "<tr><td>sta status</td><td>" + String(wifi_sta_status_str()) + "</td></tr>\n";
  html += "<tr><td>sta ip</td><td>" + wifi_sta_ip() + "</td></tr>\n";
  html += "<tr><td>sta mac</td><td>" + wifi_sta_mac() + "</td></tr>\n";
  html += "<tr><td>sta rssi</td><td>" + String(wifi_sta_rssi()) + "</td></tr>\n";
  html += "<tr><td></td><td><input type='submit' value='Save sta'></td></tr>\n";
  html += "</table>\n";
  html += "</form>\n";
  html += "</div>\n";

  // ap 配置卡：/apsave 只碰 ap（EEPROM 里没存过就用 mod_wifi.cpp 里的默认值）；
  // ip/stations/已连客户端也是这个角色自己的状态，放这张卡里
  html += "<div class='card'>\n";
  html += "<b>ap (access point)</b>\n";
  html += "<form action='/apsave' method='POST'>";
  html += "<table>\n";
  html += "<tr><td>ap ssid</td><td><input type='text' name='apssid' value='" + html_escape(String(wifi_ap_ssid())) + "'></td></tr>\n";
  html += "<tr><td>ap pass</td><td><input type='password' name='appass' value='" + html_escape(String(wifi_ap_pass())) + "'></td></tr>\n";
  html += "<tr><td>ap ip</td><td>" + wifi_ap_ip() + "</td></tr>\n";
  html += "<tr><td>ap mac</td><td>" + wifi_ap_mac() + "</td></tr>\n";
  html += "<tr><td>ap stations</td><td>" + String(wifi_ap_station_count()) + "</td></tr>\n";

  kbd_wifi_sta_t stas[KBD_WIFI_AP_STA_MAX];
  int n = wifi_ap_station_list(stas, KBD_WIFI_AP_STA_MAX);
  for(int i=0;i<n;i++){
    html += "<tr><td>station " + String(i) + "</td><td>ip=" + String(stas[i].ip)
          + " mac=" + String(stas[i].mac) + " rssi=" + String(stas[i].rssi) + "</td></tr>\n";
  }

  html += "<tr><td></td><td><input type='submit' value='Save ap'></td></tr>\n";
  html += "</table>\n";
  html += "</form>\n";
  html += "</div>\n";

  html += "<small>";
  html += "1. sta = the network this keyboard joins (empty = don't join); ap = the hotspot it creates.<br>";
  html += "2. each Save writes only its own side to EEPROM, then reboots; values are read when the page loads (reload to refresh).<br>";
  html += "3. ap defaults " + html_escape(String(wifi_ap_ssid_default())) + " / "
        + html_escape(String(wifi_ap_pass_default())) + "; pass blank = open hotspot, else 8-63 chars (ssid 1-31). "
          "after a change the phone must rejoin (forget the old network first).";
  html += "</small>\n";
  html += "</body></html>\n";

  server.send(200, "text/html; charset=utf-8", html);
}

// 保存失败时的提示页（几个 Save handler 共用）：400 + 原因 + 规则 + 返回链接
static void send_save_error(const String& what, const String& err, const String& rule, const char* back) {
  String html;
  html += "<html><head><meta charset='utf-8'><title>save</title></head><body>\n";
  html += "<b>没有保存 (" + what + ")</b><br>" + html_escape(err) + "<br><br>\n";
  html += "<small>" + rule + "</small><br><br>\n";
  html += "<a href='" + String(back) + "'>back</a>\n";
  html += "</body></html>\n";
  server.send(400, "text/html; charset=utf-8", html);
}

// /stasave：只管 sta。ap 的值由 /apsave 管，两个按钮互不影响。
void handle_sta_save() {
  kbdlog.println(__FUNCTION__);

  //表单里没有的字段（老页面/手写 curl）沿用当前值，不要当成清空
  String new_ssid = server.hasArg("ssid") ? server.arg("ssid") : sta_ssid;
  String new_pass = server.hasArg("pass") ? server.arg("pass") : sta_pass;

  //空 ssid = 不连这个网络（合法）。非空时长度要在 core 能接受的范围内：
  //WiFi.begin() 对 strlen(ssid) > 32 或 strlen(passphrase) > 64 直接返回 false（不报错，就是连不上）。
  if(new_ssid.length() > 32){
    kbdlog.println("stasave: rejected (ssid too long)");
    send_save_error("sta", "sta ssid 最长 32 字节", "留空 = 不连这个网络。改好再存。", "/wifistat");
    return;
  }
  if(new_pass.length() > 64){
    kbdlog.println("stasave: rejected (pass too long)");
    send_save_error("sta", "sta pass 最长 64 字节", "留空 = 开放网络/不加密。改好再存。", "/wifistat");
    return;
  }

  sta_ssid = new_ssid;
  sta_pass = new_pass;
  ssidpass_save(sta_ssid, sta_pass);

  server.send(200, "text/plain", "sta saved. Restarting...");
  delay(200);   //够把响应发出去就行（原来 1000 是白等）
  esp_restart();
}

// /apsave：只管 ap。
void handle_ap_save() {
  kbdlog.println(__FUNCTION__);

  String new_ssid = server.hasArg("apssid") ? server.arg("apssid") : ap_ssid;
  String new_pass = server.hasArg("appass") ? server.arg("appass") : ap_pass;

  //ap 凭据必须校验通过才写 EEPROM：存了非法密码，重启后 softAP 起不来，
  //网页也进不去，只能接串口/重新烧写来救。
  String err;
  if(!wifi_ap_cred_valid(new_ssid, new_pass, err)){
    kbdlog.printf("apsave: rejected (%s)\n", err.c_str());
    send_save_error("ap", err, "ap ssid 1-31 字节；ap pass 留空(开放热点)或 8-63 字节。改好再存。", "/wifistat");
    return;
  }

  ap_ssid = new_ssid;
  ap_pass = new_pass;
  apssidpass_save(ap_ssid, ap_pass);

  server.send(200, "text/plain", "ap saved. Restarting...");
  delay(200);
  esp_restart();
}


// ---- bt (蓝牙状态 + 广播名/配对码设置) ----
// 这页现在有输入框，所以**不能**自动刷新（3 秒重载会把没保存的输入冲掉）；要刷新就手动重载。
// 全机的蓝牙状态只在这里显示，/sys 上不再重复。
void handle_bt() {
  if(server.hasArg("bt"))kbdlog_set_bt_verbose(0 != server.arg("bt").toInt());

  int conn = blekbd_is_connected() ? 1 : 0;
  int adv = blekbd_is_advertising() ? 1 : 0;
  int peers = blekbd_connected_count();

  String html;
  html.reserve(1536);

  html += "<html><head><meta charset='utf-8'><title>bt</title>";
  html += "<style>body{font-family:monospace;}";
  html += "table{border-collapse:collapse;} td{padding:0 10px 0 0;vertical-align:top;}";
  html += "input[type='text']{width:240px;}";
  html += ".card{border:1px solid #ccc;border-radius:6px;padding:8px 12px;margin-bottom:12px;width:fit-content;}";
  html += "</style></head><body>\n";
  build_page_head(html);

  html += "<h3>bt</h3>\n";

  // 状态卡（只读）
  html += "<div class='card'>\n";
  html += "<b>status</b>\n";
  html += "<table>\n";
  html += "<tr><td>name</td><td>" + html_escape(String(blekbd_name())) + "</td></tr>\n";
  html += "<tr><td>address</td><td>" + blekbd_address() + "</td></tr>\n";
  html += "<tr><td>connected</td><td>" + String(conn) + "</td></tr>\n";
  html += "<tr><td>advertising</td><td>" + String(adv) + "</td></tr>\n";
  html += "<tr><td>peers</td><td>" + String(peers) + "</td></tr>\n";
  html += "</table>\n";

  if( (!adv) && (!conn) ){
    html += "<b>not advertising</b>: the phone may only be showing a cached/paired entry, forget the device and retry<br>\n";
  }
  else if(peers > 1){
    html += "<b>another host is connected</b>: this library serves one host at a time<br>\n";
  }

  html += "<a href='/bt?bt=" + String(kbdlog_bt_verbose() ? 0 : 1) + "'>[bt verbose: "
        + String(kbdlog_bt_verbose() ? "on" : "off") + "]</a><br>\n";
  html += "</div>\n";

  // 键盘配置卡：广播名 + 配对码，保存后重启
  html += "<div class='card'>\n";
  html += "<b>keyboard</b>\n";
  html += "<form action='/btsave' method='POST'>";
  html += "<table>\n";
  html += "<tr><td>name</td><td><input type='text' name='name' value='" + html_escape(String(blekbd_name())) + "'></td></tr>\n";
  html += "<tr><td>passkey</td><td><input type='text' name='passkey' value='"
        + (blekbd_passkey() ? String(blekbd_passkey()) : String("")) + "'></td></tr>\n";
  html += "<tr><td></td><td><input type='submit' value='Save bt'></td></tr>\n";
  html += "</table>\n";
  html += "</form>\n";
  html += "</div>\n";

  // 手柄卡片：现在只是占位（没有任何 HID 报告/服务被创建），
  // 先把这个位置留出来，等真做的时候把状态接到这里（见 todo.md 的"蓝牙手柄"条目）。
  html += "<div class='card'>\n";
  html += "<b>gamepad</b> <small>placeholder, no reports sent yet</small>\n";
  html += "<table>\n";
  html += "<tr><td>enabled</td><td>no</td></tr>\n";
  html += "<tr><td>name</td><td>-</td></tr>\n";
  html += "<tr><td>connected</td><td>-</td></tr>\n";
  html += "<tr><td>advertising</td><td>-</td></tr>\n";
  html += "</table>\n";
  html += "</div>\n";

  html += "<small>";
  html += "1. name/passkey are stored in EEPROM and applied after a reboot; a blank name uses the library default (ESP32 Keyboard), and a short name (&lt;= 10 chars) is safest for the phone's scan list.<br>";
  html += "2. passkey blank or 0 = no pairing code (just works); otherwise 1-6 digits, and the phone asks for it (shown padded to 6, e.g. 12345 -&gt; 012345).<br>";
  html += "3. saving bt clears the pairing on the keyboard side, so the phone has to pair again (forget the device on the phone if it keeps using the old entry); keys still go to USB HID and BLE at the same time.<br>";
  html += "4. no auto refresh here (it would wipe the boxes) - reload the page to update the values.";
  html += "</small>\n";
  html += "</body></html>\n";

  server.send(200, "text/html; charset=utf-8", html);
}

// /btsave：广播名 + 配对码，重启生效
void handle_bt_save() {
  kbdlog.println(__FUNCTION__);

  //缺字段就沿用当前生效的值（老页面/手写请求）
  String new_name = server.hasArg("name") ? server.arg("name") : String(blekbd_name());
  String keytext = server.hasArg("passkey") ? server.arg("passkey")
                 : (blekbd_passkey() ? String(blekbd_passkey()) : String(""));

  String err;
  if(!blekbd_name_check(new_name, err)){
    kbdlog.printf("btsave: rejected (%s)\n", err.c_str());
    send_save_error("bt", err, "name 留空 = 用默认名；否则 1-24 字节、不要不可见字符。", "/bt");
    return;
  }

  uint32_t key = 0;
  if(!blekbd_passkey_parse(keytext, key, err)){
    kbdlog.printf("btsave: rejected (%s)\n", err.c_str());
    send_save_error("bt", err, "配对码留空或 0 = 不用；否则 1-6 位数字。", "/bt");
    return;
  }

  blekbd_cfg_set(new_name, key);
  blekbd_forget_bonds();   // 清掉老绑定，否则手机复用老密钥、新配对码不会弹

  server.send(200, "text/plain", "bt saved. Restarting...");
  delay(200);
  esp_restart();
}


// ---- socket：udp / tcp / ws(websocket) 三个独立目标 ----
// 每个一张卡片、各自一个 Set 按钮、各自一个端点（/udpsave /tcpsave /wssave）；
// **配置留空 = 不启用**，保存是立即生效（不用重启），所以直接 303 回本页。
void handle_socket_stat() {
  kbdlog.println(__FUNCTION__);

  String html;
  html.reserve(2048);

  html += "<html><head><meta charset='utf-8'><title>socket</title>";
  html += "<style>body{font-family:monospace;}";
  html += "table{border-collapse:collapse;} td{padding:0 10px 0 0;vertical-align:top;}";
  html += "input[type='text']{width:240px;}";
  html += ".card{border:1px solid #ccc;border-radius:6px;padding:8px 12px;margin-bottom:12px;width:fit-content;}";
  html += "</style></head><body>\n";
  build_page_head(html);

  html += "<h3>socket</h3>\n";

  // udp：现在唯一真的会发按键的通道（arrow 模式）
  html += "<div class='card'>\n";
  html += "<b>udp</b>\n";
  html += "<form action='/udpsave' method='POST'>";
  html += "<table>\n";
  html += "<tr><td>ipv4</td><td><input type='text' name='ipv4' value='" + html_escape(udp_peer_ipv4) + "'></td></tr>\n";
  html += "<tr><td>port</td><td><input type='text' name='port' value='"
        + (udp_peer_port ? String(udp_peer_port) : String("")) + "'></td></tr>\n";
  html += "<tr><td>status</td><td>" + String(udp_enabled() ? "enabled" : "disabled (empty)") + "</td></tr>\n";
  html += "<tr><td></td><td><input type='submit' value='Set udp'></td></tr>\n";
  html += "</table>\n";
  html += "</form>\n";
  html += "</div>\n";

  // tcp：配置就位，但还没接发送
  html += "<div class='card'>\n";
  html += "<b>tcp</b>\n";
  html += "<form action='/tcpsave' method='POST'>";
  html += "<table>\n";
  html += "<tr><td>ipv4</td><td><input type='text' name='ipv4' value='" + html_escape(tcp_peer_ipv4) + "'></td></tr>\n";
  html += "<tr><td>port</td><td><input type='text' name='port' value='"
        + (tcp_peer_port ? String(tcp_peer_port) : String("")) + "'></td></tr>\n";
  html += "<tr><td>status</td><td>" + String(tcp_enabled() ? "enabled" : "disabled (empty)")
        + (tcp_enabled() ? " - config only, not sending yet" : "") + "</td></tr>\n";
  html += "<tr><td></td><td><input type='submit' value='Set tcp'></td></tr>\n";
  html += "</table>\n";
  html += "</form>\n";
  html += "</div>\n";

  // ws：WebSocket（注意别和上面的 ws2812b 灯带页混了）
  html += "<div class='card'>\n";
  html += "<b>ws (websocket)</b>\n";
  html += "<form action='/wssave' method='POST'>";
  html += "<table>\n";
  html += "<tr><td>url</td><td><input type='text' name='url' value='" + html_escape(ws_url) + "'></td></tr>\n";
  html += "<tr><td>status</td><td>" + String(ws_enabled() ? "enabled" : "disabled (empty)")
        + (ws_enabled() ? " - config only, not sending yet" : "") + "</td></tr>\n";
  html += "<tr><td></td><td><input type='submit' value='Set ws'></td></tr>\n";
  html += "</table>\n";
  html += "</form>\n";
  html += "</div>\n";

  html += "<small>";
  html += "1. udp/tcp need both ipv4 and port; ws needs a url; anything left blank = disabled.<br>";
  html += "2. saved to EEPROM and applied immediately (no reboot); status is recomputed from the saved values.<br>";
  html += "3. only udp sends keys today (arrow mode, one byte per key press). tcp/ws are config-only for now.";
  html += "</small>\n";
  html += "</body></html>\n";

  server.send(200, "text/html; charset=utf-8", html);
}

// 三个 Set 按钮的公共部分：读字段（缺字段沿用当前值）→ 校验 → 落盘 → 303 回本页
static bool socket_arg_int(const char* name, int& out) {
  String s = server.arg(name);
  s.trim();
  if(0 == s.length()){
    out = 0;                     // 留空 = 不启用
    return true;
  }
  for(size_t i=0;i<s.length();i++){
    if(s[i] < '0' || s[i] > '9')return false;
  }
  out = s.toInt();
  return true;
}

void handle_udp_save() {
  kbdlog.println(__FUNCTION__);

  String new_ip    = server.hasArg("ipv4") ? server.arg("ipv4") : udp_peer_ipv4;
  int    new_port  = udp_peer_port;

  String err;
  if(!socket_arg_int("port", new_port)){
    kbdlog.println("udpsave: rejected (port not a number)");
    send_save_error("udp", "port 要是数字", "留空或 0 = 不启用。改好再存。", "/socketstat");
    return;
  }
  if(!socket_ipv4_check(new_ip, err) || !socket_port_check(new_port, err)){
    kbdlog.printf("udpsave: rejected (%s)\n", err.c_str());
    send_save_error("udp", err, "ipv4 形如 192.168.4.2；port 1-65535；任一项留空 = 不启用。", "/socketstat");
    return;
  }

  udp_peer_ipv4 = new_ip;
  udp_peer_port = new_port;
  udppeer_save(udp_peer_ipv4, udp_peer_port);

  server.sendHeader("Location", "/socketstat");
  server.send(303);
}

void handle_tcp_save() {
  kbdlog.println(__FUNCTION__);

  String new_ip    = server.hasArg("ipv4") ? server.arg("ipv4") : tcp_peer_ipv4;
  int    new_port  = tcp_peer_port;

  String err;
  if(!socket_arg_int("port", new_port)){
    kbdlog.println("tcpsave: rejected (port not a number)");
    send_save_error("tcp", "port 要是数字", "留空或 0 = 不启用。改好再存。", "/socketstat");
    return;
  }
  if(!socket_ipv4_check(new_ip, err) || !socket_port_check(new_port, err)){
    kbdlog.printf("tcpsave: rejected (%s)\n", err.c_str());
    send_save_error("tcp", err, "ipv4 形如 192.168.4.2；port 1-65535；任一项留空 = 不启用。", "/socketstat");
    return;
  }

  tcp_peer_ipv4 = new_ip;
  tcp_peer_port = new_port;
  tcppeer_save(tcp_peer_ipv4, tcp_peer_port);

  server.sendHeader("Location", "/socketstat");
  server.send(303);
}

void handle_ws_save() {
  kbdlog.println(__FUNCTION__);

  String new_url = server.hasArg("url") ? server.arg("url") : ws_url;

  String err;
  if(!socket_wsurl_check(new_url, err)){
    kbdlog.printf("wssave: rejected (%s)\n", err.c_str());
    send_save_error("ws", err, "留空 = 不启用；填的话形如 ws://192.168.4.2:81/。", "/socketstat");
    return;
  }

  ws_url = new_url;
  wsurl_save(ws_url);

  server.sendHeader("Location", "/socketstat");
  server.send(303);
}


void handle_ws2812b_stat() {
  kbdlog.println(__FUNCTION__);

  String html;
  html += "<style>";
  html += "input[type='text'] { width: 60px; text-align: center; }";
  html += ".row { margin-bottom: 5px; white-space: nowrap; }";
  html += "</style>";
  build_page_head(html);

  html += "<form action='/ws2812bsave' method='POST'>";
  for(int y=0;y<ROWS;y++){
    html += "<div class='row'>";
    html += "row" + String(y) + ": ";
    for(int x=0;x<COLS;x++){
      String key = "y" + String(y) + "x" + String(x);
      String val = String(ws2812b_getpixel(x,y), HEX);
      html += "<input type='text' name='" + key + "' value='" + val + "'>";
    }
    html += "</div>";
  }
  html += "<input type='submit' value='Save'>";
  html += "</form>";
  server.send(200, "text/html", html);
}
void handle_ws2812b_save() {
  kbdlog.println(__FUNCTION__);

  for(int y=0;y<ROWS;y++){
  for(int x=0;x<COLS;x++){
    String key = "y" + String(y) + "x" + String(x);
    if(!server.hasArg(key))continue;

    int val = strtol(server.arg(key).c_str(), NULL, 16);
    ws2812b_setpixel(x, y, val);
  }
  }

  server.sendHeader("Location", "/ws2812bstat");
  server.send(303);
}


// ---- keyboard (键值表) ----
// USB HID 和 BLE 各有一套表，同一个数字在两套里含义不同，所以页面上分开显示。
// 表编号 0/1/2 = abcdef/ascii/default，和 usbkbd_press()/blekbd_press() 里的
// switch(currmode) 一致（arrow 模式下只有一张表）。

extern int currmode;

static String kbd_hexval(uint32_t val){
  char buf[16];
  if(val <= 0xff)snprintf(buf, sizeof(buf), "%02x", (unsigned)val);
  else snprintf(buf, sizeof(buf), "%08x", (unsigned)val);
  return String(buf);
}

// 解析十六进制：允许 "0x" 前缀和首尾空白，1~8 位十六进制数字
static bool kbd_parse_hex(const String& s, uint32_t& out){
  const char* p = s.c_str();
  while( (' '==*p) || ('\t'==*p) )p++;
  if( ('0'==p[0]) && (('x'==p[1]) || ('X'==p[1])) )p += 2;

  uint32_t val = 0;
  int ndigit = 0;
  for(; '\0'!=*p; p++){
    char c = *p;
    if( (' '==c) || ('\t'==c) || ('\r'==c) || ('\n'==c) ){
      for(const char* q=p; '\0'!=*q; q++){
        if( (' '!=*q) && ('\t'!=*q) && ('\r'!=*q) && ('\n'!=*q) )return false;
      }
      break;
    }

    int d;
    if( (c>='0') && (c<='9') )d = c - '0';
    else if( (c>='a') && (c<='f') )d = c - 'a' + 10;
    else if( (c>='A') && (c<='F') )d = c - 'A' + 10;
    else return false;

    if(ndigit >= 8)return false;
    val = (val << 4) | (uint32_t)d;
    ndigit++;
  }

  if(0 == ndigit)return false;

  out = val;
  return true;
}

static String kbd_cell_name(char kind, int y, int x){
  String name;
  name += kind;
  name += "_y";
  name += String(y);
  name += "x";
  name += String(x);
  return name;
}

// currmode -> 表号：0/1/2/3 一一对应，4 及以上按常规键位
// （和 usbkbd_press()/blekbd_press() 里的 switch 保持一致）
static int kbd_mode_to_table(int mode){
  if(usbkbd_table_count() <= 1)return 0;   // arrow 模式只有一张表
  if( (mode >= 0) && (mode <= kbdmode_periodic) )return mode;
  return kbdmode_normal;
}

// ascii 模式只在 8x18 下存在
static bool kbd_is_ascii(int t){
#if mode_chosen==mode_8x18
  return (t == kbdmode_ascii);
#else
  (void)t;
  return false;
#endif
}

// ascii 模式：第 2 列起按位置对应 ASCII 0x00-0x7f
static uint8_t kbd_ascii_of(int x, int y){
  return (uint8_t)(y*16 + (x-2));
}

// 给网页看的可读标签（"-" = 库映射为 0，按了不发东西）
static String kbd_ascii_label(uint8_t c){
  if(0x08 == c)return "BS";
  if(0x09 == c)return "TAB";
  if(0x0a == c)return "LF";
  if(0x20 == c)return "SP";
  if( (c >= 0x21) && (c <= 0x7e) )return String((char)c);
  return "-";
}

static bool kbd_is_periodic(int t){
  if(!kbd_periodic_enabled)return false;
  return (t == kbdmode_periodic);
}

// 周期表的字符串表每个通道一张（mod_usb.cpp / mod_ble.cpp 各一份）
static bool kbd_periodic_valid(char kind, const char* s){
  return ('u'==kind) ? usbkbd_str_valid(s) : blekbd_str_valid(s);
}

static const char* kbd_getstr(char kind, int x, int y){
  return ('u'==kind) ? usbkbd_getstr(x, y) : blekbd_getstr(x, y);
}

static bool kbd_setstr(char kind, int x, int y, const char* s){
  return ('u'==kind) ? usbkbd_setstr(x, y, s) : blekbd_setstr(x, y, s);
}

static int kbd_str_maxlen(char kind){
  return ('u'==kind) ? usbkbd_str_maxlen() : blekbd_str_maxlen();
}

static int kbd_clamp_table(int t){
  int n = usbkbd_table_count();
  if(t < 0)t = 0;
  if(t > n-1)t = n-1;
  return t;
}

static bool kbd_key_valid(char kind, uint32_t val){
  return ('u'==kind) ? usbkbd_key_valid(val) : blekbd_key_valid(val);
}

// 下面两个 helper 的参数顺序和 cell 名一致：(y, x)
static uint32_t kbd_getkey(char kind, int t, int y, int x){
  return ('u'==kind) ? usbkbd_getkey(t, x, y) : blekbd_getkey(t, x, y);
}

static bool kbd_setkey(char kind, int t, int y, int x, uint32_t val){
  return ('u'==kind) ? usbkbd_setkey(t, x, y, val) : blekbd_setkey(t, x, y, val);
}

static void kbd_build_grid(String& html, char kind, const char* title, int t, bool from_post){
  bool periodic = kbd_is_periodic(t);

  html += "<b>" + String(title) + "</b> table <b>" + String(usbkbd_table_name(t)) + "</b>:<br>\n";
  for(int y=0;y<ROWS;y++){
    html += "<div class='row'><span class='lbl'>y" + String(y) + "</span>";
    for(int x=0;x<COLS;x++){
      if(kbd_is_modekey(x, y)){
        // 右下角 4 个键是模式键（按下只切模式，不发键值）
        html += "<input class='mode' type='text' value='m" + String(x - KBD_MODEKEY_COL0) + "' disabled title='mode key'>";
        continue;
      }

      if( kbd_is_ascii(t) && (x >= 2) ){
        // ascii 模式的第 2 列起是算出来的，不存表也不可编辑，只显示可读字符
        uint8_t c = kbd_ascii_of(x, y);
        html += "<input class='cell fixed' type='text' value='" + html_escape(kbd_ascii_label(c))
              + "' disabled title='0x" + String((unsigned int)c, HEX) + "'>";
        continue;
      }

      String name = kbd_cell_name(kind, y, x);
      String val;
      bool bad = false;

      if(from_post && server.hasArg(name)){
        val = server.arg(name);
        if(periodic){
          if(!kbd_periodic_valid(kind, val.c_str()))bad = true;
        }
        else{
          uint32_t tmp = 0;
          if(0 == val.length())bad = false;   // 留空 = 00
          else if( !kbd_parse_hex(val, tmp) || !kbd_key_valid(kind, tmp) )bad = true;
        }
      }
      else{
        val = periodic ? String(kbd_getstr(kind, x, y)) : kbd_hexval(kbd_getkey(kind, t, y, x));
      }

      // 第 0/1 列是特殊列，标灰；第 0 列在模式 0-2 还是模式切换列
      String cls = "cell";
      if(x < 2)cls += " special";
      if(bad)cls += " bad";

      if(periodic){
        html += "<input class='" + cls + "' type='text' maxlength='" + String(kbd_str_maxlen(kind)-1)
              + "' name='" + name + "' value='" + html_escape(val) + "'>";
      }
      else{
        html += "<input class='" + cls + "' type='text' name='" + name + "' value='" + html_escape(val) + "'>";
      }
    }
    html += "</div>\n";
  }
}

static void kbd_build_page(String& html, int t, bool from_post, const String& errors){
  // 8x18 模式下最多 2*ROWS*COLS 个输入框，先预留，避免拼接时反复重分配
  html.reserve(html.length() + (unsigned)(2*ROWS*COLS*90 + 2048));
  html += "<style>";
  html += "input.cell { width: 70px; font-family: monospace; text-align: center; }";
  html += "input.special { background: #d8d8d8; }";
  html += "input.mode { width: 70px; background: #eee; color: #999; text-align: center; }";
  html += "input.fixed { background: #f0f0f0; color: #333; }";
  html += "form{display:inline; margin:0;} button{padding:2px 6px;}";
  html += "input.bad { background: #ffd0d0; }";
  html += ".row { margin-bottom: 4px; white-space: nowrap; }";
  html += ".lbl { display: inline-block; width: 28px; color: #666; }";
  html += "</style>";
  build_page_head(html);

  html += "<h3>keyboard</h3>\n";
  html += "currmode=" + String(currmode) + ", ROWS=" + String(ROWS) + ", COLS=" + String(COLS) + "<br>\n";
  // 模式切换和改键值都在这页：点一个模式 = 切到它 + 编辑它那张表
  html += "mode (click to switch & edit): ";
  for(int i=0;i<usbkbd_table_count();i++){
    if(i == t)html += "[<b>" + String(usbkbd_table_name(i)) + "</b>] ";
    else html += "[<a href='/kbdstat?t=" + String(i) + "'>" + String(usbkbd_table_name(i)) + "</a>] ";
  }
  html += "<br>\n";

  if(errors.length() > 0)html += "<div style='color:#b00'>" + errors + "</div>\n";

  html += "<form action='/kbdsave' method='POST'>";
  html += "<input type='hidden' name='t' value='" + String(t) + "'>";
  kbd_build_grid(html, 'u', "USB HID", t, from_post);
  html += "<br>\n";
  kbd_build_grid(html, 'b', "BLE", t, from_post);
  html += "<br><input type='submit' value='Save'>";
  html += "</form>\n";

  html += "<small>";
  html += "1. modes: 0 normal / 1 abcdef / 2 ascii / 3 periodic; click a mode above to switch + edit it (mode keys on the keyboard are disabled).<br>";
  html += "2. mode 2: cols 0-1 = special keys (editable), cols 2-17 = ASCII 0x00-0x7f by position (ascii = y*16+x-2, read-only, \"-\" = sends nothing); mode 3: strings typed out per character.<br>";
  html += "3. hex, empty = 00 (sends nothing), grey cols 0-1 are ordinary keys. USB: 04-A4 keys (04=a, 28=Enter, 29=Esc, 2C=Space, 4F-52=arrows), E0-E7 modifiers. BLE: 20-7E ASCII, 80-87 modifiers, 88-FF non-printing (B1=Esc, C1=CapsLock), 800000xx media.<br>";
  html += "4. RAM only, a reboot restores the compile-time tables (USB and BLE keep separate tables).";
  html += "</small>\n";
}

void handle_kbd_stat() {
  kbdlog.println(__FUNCTION__);

  int t = kbd_mode_to_table(currmode);
  if(server.hasArg("t")){
    // 点 tab 就是切模式（模式键取消后，这里是唯一的切换入口）
    t = kbd_clamp_table(server.arg("t").toInt());
    if(t != currmode){
      currmode = t;
      kbdlog.printf("kbd: set mode %d (%s)\n", t, usbkbd_table_name(t));
    }
  }

  String html;
  kbd_build_page(html, t, false, String(""));
  server.send(200, "text/html; charset=utf-8", html);
}

void handle_kbd_save() {
  kbdlog.println(__FUNCTION__);

  int t = kbd_mode_to_table(currmode);
  if(server.hasArg("t"))t = kbd_clamp_table(server.arg("t").toInt());

  const char kinds[2] = {'u', 'b'};
  String errors;
  int applied = 0;
  int rejected = 0;

  bool periodic = kbd_is_periodic(t);

  for(int y=0;y<ROWS;y++){
    for(int x=0;x<COLS;x++){
      if(kbd_is_modekey(x, y))continue;                // 模式键，不可编辑
      if( kbd_is_ascii(t) && (x >= 2) )continue;       // ascii 模式第 2 列起是算出来的，不收

      for(int k=0;k<2;k++){
        String name = kbd_cell_name(kinds[k], y, x);
        if(!server.hasArg(name))continue;

        String raw = server.arg(name);

        if(periodic){
          if(!kbd_periodic_valid(kinds[k], raw.c_str())){
            errors += "invalid string: " + name + "='" + html_escape(raw) + "' (max "
                    + String(kbd_str_maxlen(kinds[k])-1) + " printable ASCII)<br>";
            rejected++;
            continue;
          }
          if(kbd_setstr(kinds[k], x, y, raw.c_str()))applied++;
          else{
            errors += "rejected: " + name + "<br>";
            rejected++;
          }
          continue;
        }

        uint32_t val = 0;
        bool ok = (0 == raw.length()) ? true : kbd_parse_hex(raw, val);

        if(!ok){
          errors += "invalid hex: " + name + "='" + html_escape(raw) + "'<br>";
          rejected++;
          continue;
        }
        if(!kbd_key_valid(kinds[k], val)){
          errors += "out of range: " + name + "=" + kbd_hexval(val) + "<br>";
          rejected++;
          continue;
        }
        if(kbd_setkey(kinds[k], t, y, x, val))applied++;
        else{
          errors += "rejected: " + name + "<br>";
          rejected++;
        }
      }
    }
  }

  kbdlog.printf("kbdsave: table=%d applied=%d rejected=%d\n", t, applied, rejected);

  if(rejected > 0){
    String html;
    kbd_build_page(html, t, true,
      String("saved ") + String(applied) + " value(s), rejected " + String(rejected) + ":<br>" + errors);
    server.send(200, "text/html; charset=utf-8", html);
    return;
  }

  server.sendHeader("Location", "/kbdstat?t=" + String(t));
  server.send(303);
}


// ---- sys (系统状态 + 重启 / 进 bootloader) ----

// 和日志无关的状态都在这儿。wifi 状态在 /wifistat、蓝牙状态在 /bt，
// 当前模式在 /kbdstat，这里不重复。
static void build_sys_status(String& html){
  html += "<table>\n";
  html += "<tr><td>mode</td><td>ROWS=" + String(ROWS) + " COLS=" + String(COLS)
        + " board=" + String(board_chosen) + " tables=" + String(usbkbd_table_count()) + "</td></tr>\n";
  html += "<tr><td>uptime</td><td>" + String((unsigned long)(millis()/1000)) + " s</td></tr>\n";
  html += "<tr><td>boot</td><td>#" + String(kbdlog_boot_count())
        + ", reset=" + String(kbdlog_reset_reason_str()) + "</td></tr>\n";
  html += "<tr><td>heap</td><td>free=" + String((unsigned long)ESP.getFreeHeap())
        + " min=" + String((unsigned long)ESP.getMinFreeHeap())
        + " maxblock=" + String((unsigned long)ESP.getMaxAllocHeap()) + "</td></tr>\n";
  html += "</table>\n";
}

// 这个页面是手动刷新的，就不往日志里插行了
void handle_sys() {
  String html;
  html.reserve(2048);

  html += "<html><head><meta charset='utf-8'><title>sys</title>";
  html += "<style>body{font-family:monospace;}";
  html += "table{border-collapse:collapse;} td{padding:0 10px 0 0;vertical-align:top;}";
  html += "button{padding:4px 10px;} form{display:inline-block; margin-right:10px;}";
  html += "</style></head><body>\n";
  build_page_head(html);

  html += "<h3>sys</h3>\n";
  build_sys_status(html);

  html += "<form action='/sysaction' method='POST'>";
  html += "<button type='submit' name='do' value='reboot'>reboot</button>";
  html += "</form>";
  html += "<form action='/sysaction' method='POST'>";
  html += "<button type='submit' name='do' value='bootloader'>enter USB bootloader</button>";
  html += "</form>";
  html += "<br>\n";
  html += "<small>reboot = esp_restart(). enter USB bootloader = usb_persist_restart(RESTART_BOOTLOADER): "
          "switches the USB port to the ROM download device, so the IDE can upload without shorting GPIO0. "
          "After the upload (or a power cycle) it boots normally again.</small>\n";
  html += "</body></html>\n";

  server.send(200, "text/html; charset=utf-8", html);
}

void handle_sys_action() {
  String act = server.arg("do");
  kbdlog.printf("sys: action '%s'\n", act.c_str());

  String html;
  html += "<html><head><meta charset='utf-8'><title>sys</title></head><body>\n";
  build_page_head(html);

  if(act.equals("reboot")){
    html += "<p>rebooting...</p>\n</body></html>\n";
    server.send(200, "text/html; charset=utf-8", html);
    delay(300);
    esp_restart();
  }
  else if(act.equals("bootloader")){
    html += "<p>switching to the USB bootloader...</p>\n</body></html>\n";
    server.send(200, "text/html; charset=utf-8", html);
    delay(300);
    usb_persist_restart(RESTART_BOOTLOADER);
  }
  else{
    html += "<p>unknown action</p>\n</body></html>\n";
    server.send(400, "text/html; charset=utf-8", html);
  }
}


// ---- gpio (引脚用途 + 矩阵图) ----

// 行/列脚数组定义在 keyled.ino
extern byte rowPins[];
extern byte colPins[];

static bool gpio_is_row(int g){
  for(int i=0;i<ROWS;i++){
    if(rowPins[i] == g)return true;
  }
  return false;
}

static bool gpio_is_col(int g){
  for(int i=0;i<COLS;i++){
    if(colPins[i] == g)return true;
  }
  return false;
}

// 非行列脚的用途（跟当前 board_chosen 走）；返回空串表示"这脚是行列脚"
static String gpio_purpose(int g){
  if(gpio_is_row(g) || gpio_is_col(g))return "";

  switch(g){
  case PIN_LED_Y0: return "LED strip Y0 (driven)";
  //case PIN_LED_Y2: return "LED strip Y2 (init only, never shown)";
  //case PIN_LED_Y4: return "LED strip Y4 (not used)";
  //case PIN_LED_Y6: return "LED strip Y6 (not used)";
  //case PIN_CANH:   return "CANH (reserved, unused)";
  //case PIN_CANL:   return "CANL (reserved, unused)";
  case 19:         return "USB D- (TinyUSB CDC+HID)";
  case 20:         return "USB D+ (TinyUSB CDC+HID)";
  case 43:         return "UART0 TX (ROM console)";
  case 44:         return "UART0 RX (ROM console)";
  }

  // 26-32 是模组内部 SPI flash：下面循环里直接跳过不列，这里留着是为了说明这几个脚不是"空闲脚"
  if( (g >= 26) && (g <= 32) )return "SPI flash (module internal, not usable)";
  return "unused (free)";
}

// 页面从上到下三块：info（板子/矩阵）→ non-matrix（引脚用途表）→ matrix（ROWS x COLS 矩形）。
// 每块之间空两行。矩阵最后一行显示每列的 GPIO，最右一列显示每行的 GPIO，格子内部为空。
void handle_gpio() {
  String html;
  html.reserve(4096);

  html += "<html><head><meta charset='utf-8'><title>gpio</title>";
  html += "<style>body{font-family:monospace;}";
  html += "table.pins{border-collapse:collapse;} table.pins td{padding:0 10px 0 0;vertical-align:top;}";
  html += "table.mx{border-collapse:collapse;margin-top:6px;}";
  html += "table.mx td{width:26px;height:26px;border:1px solid #bbb;text-align:center;font-size:11px;color:#666;}";
  html += "table.mx td.rl,table.mx td.cl{border:none;color:#000;font-size:12px;}";
  html += "</style></head><body>\n";
  build_page_head(html);

  // info
  html += "<b>info</b><br>\n";
  html += "board=v" + String(board_chosen) + "<br>\n";
  html += "mode=" + String(ROWS) + "x" + String(COLS) + "<br>\n";
  html += "<br><br>\n";

  // non-matrix pins
  html += "<b>non-matrix pins</b>\n";
  html += "<table class='pins'>\n";
  for(int g=0; g<=48; g++){
    if( (g >= 22) && (g <= 25) )continue;          // 芯片上没有这些脚
    if( (g >= 26) && (g <= 32) )continue;          // 模组内部 SPI flash，不可用，不列
    if( (33 == g) || (34 == g) )continue;          // 带 octal flash/PSRAM 的模组被占了，不列
    String purpose = gpio_purpose(g);
    if(0 == purpose.length())continue;             // 行列脚不在这里列
    html += "<tr><td>GPIO" + String(g) + "</td><td>" + purpose + "</td></tr>\n";
  }
  html += "</table>\n";
  html += "<small>GPIO26-32 are not listed: module internal SPI flash, not usable. "
          "GPIO33/34 are not listed: on modules with octal (8-line) flash/PSRAM (e.g. -N8R8, -N16R8V) they are not available.</small>\n";
  html += "<br><br><br>\n";   // 到 matrix 之间空 3 行（比上面那个间隔再多一行）

  // matrix
  html += "<b>matrix (" + String(ROWS) + " rows x " + String(COLS) + " cols)</b>\n";
  html += "<table class='mx'>\n";
  for(int y=0;y<ROWS;y++){
    html += "<tr>";
    for(int x=0;x<COLS;x++){
      html += "<td class='c' title='row " + String(y) + ", col " + String(x) + "'></td>";
    }
    html += "<td class='rl' title='row " + String(y) + "'>" + String(rowPins[y]) + "</td>";
    html += "</tr>\n";
  }
  html += "<tr>";
  for(int x=0;x<COLS;x++){
    html += "<td class='cl' title='col " + String(x) + "'>" + String(colPins[x]) + "</td>";
  }
  html += "</tr>\n";
  html += "</table>\n";
  html += "<small>matrix cells are empty; the bottom row is the GPIO of each column, the right column is the GPIO of each row.</small>\n";

  html += "</body></html>\n";

  server.send(200, "text/html; charset=utf-8", html);
}


// ---- log (只剩日志本身) ----
// 这个页面每 3 秒自动刷新，所以它自己不打日志，免得把有用的内容冲掉。
void handle_log() {
  if(server.hasArg("clear"))kbdlog_clear();
  if(server.hasArg("bt"))kbdlog_set_bt_verbose(0 != server.arg("bt").toInt());
  if(server.hasArg("key"))kbdlog_set_keylog(0 != server.arg("key").toInt());

  String html;
  html.reserve(1024 + KBDLOG_BUFSIZE*2);

  html += "<html><head><meta charset='utf-8'>";
  html += "<meta http-equiv='refresh' content='3'>";
  html += "<title>log</title>";
  html += "<style>body{font-family:monospace;}";
  html += "pre{white-space:pre-wrap;word-break:break-all;background:#f4f4f4;padding:6px;}";
  html += "</style></head><body>\n";
  build_page_head(html);

  html += "<h3>log</h3>\n";
  html += "<a href='/log?clear=1'>[clear]</a> ";
  html += "<a href='/log?bt=" + String(kbdlog_bt_verbose() ? 0 : 1) + "'>[bt verbose: "
        + String(kbdlog_bt_verbose() ? "on" : "off") + "]</a> ";
  html += "<a href='/log?key=" + String(kbdlog_keylog() ? 0 : 1) + "'>[key events: "
        + String(kbdlog_keylog() ? "on" : "off") + "]</a> ";
  html += "<a href='/log'>[refresh now]</a> ";
  html += "<a href='/sys'>[status]</a><br>\n";
  html += "<small>auto refresh 3s. heap/uptime are on the <a href='/sys'>sys</a> page, wifi on "
          "<a href='/wifistat'>wifi</a>, bluetooth on <a href='/bt'>bt</a>. "
          "turn bt verbose on, then try to connect from the phone and watch the ble: CONNECTED / DISCONNECTED lines; "
          "key events can be switched off to keep the log readable.</small>\n";

  char* buf = (char*)malloc(KBDLOG_BUFSIZE + 1);
  if(buf){
    size_t n = kbdlog_copy(buf, KBDLOG_BUFSIZE + 1);
    html += "<pre>";
    for(size_t i=0;i<n;i++){
      char c = buf[i];
      if('&' == c)html += "&amp;";
      else if('<' == c)html += "&lt;";
      else if('>' == c)html += "&gt;";
      else html += c;
    }
    html += "</pre>\n";
    free(buf);
  }
  else{
    html += "<pre>(malloc failed)</pre>\n";
  }

  html += "</body></html>\n";

  server.send(200, "text/html; charset=utf-8", html);
}


void handleRoot() {
  handle_wifi_stat();
}


void wifi_web_poll(){
  //临时诊断（观察期结束可删）：单次 handleClient() 超过 1s，说明踩到了
  //_parseRequest() -> Stream::readStringUntil() -> Stream::timedRead() 那条
  //"纯忙等"路径（gotcha.md #13 的路径 2，client 只发一半请求）。
  //它自旋在单次调用内部，循环末尾的 vTaskDelay(1) 插不进去，理论上仍能饿死 IDLE0。
  uint32_t t0 = millis();
  server.handleClient();
  uint32_t dt = millis() - t0;
  if(dt >= 1000)kbdlog.printf("web: handleClient %ums\n", (unsigned)dt);

  //处理完就主动关，不等对端关。
  //NetworkClient::connected() 收到 FIN（对端正常关闭）时仍然返回 true，
  //所以这条连接会一直挂在 handleClient() 里直到 accept+HTTP_MAX_DATA_WAIT(5s)，
  //那 5 秒 casualloop 只能 yield()，core0 的 IDLE0 拿不到 CPU -> TASK_WDT。
  //stop() 是优雅关闭（close(fd)），响应数据已经交给 lwIP，会先发完再 FIN。
  if(server.client())server.client().stop();
}
void wifi_web_init()
{
  server.on("/wifistat", handle_wifi_stat);
  server.on("/stasave", handle_sta_save);
  server.on("/apsave", handle_ap_save);

  server.on("/bt", handle_bt);
  server.on("/btsave", handle_bt_save);

  server.on("/socketstat", handle_socket_stat);
  server.on("/udpsave", handle_udp_save);
  server.on("/tcpsave", handle_tcp_save);
  server.on("/wssave", handle_ws_save);

  server.on("/ws2812bstat", handle_ws2812b_stat);
  server.on("/ws2812bsave", handle_ws2812b_save);

  server.on("/kbdstat", handle_kbd_stat);
  server.on("/kbdsave", handle_kbd_save);

  server.on("/gpio", handle_gpio);
  
  server.on("/log", handle_log);

  server.on("/sys", handle_sys);
  server.on("/sysaction", handle_sys_action);

  server.on("/", handleRoot);
  server.begin();
}
