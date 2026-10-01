#pragma once

#include <Arduino.h>

// 对外通道模块（udp / tcp / ws=websocket）。三个目标各自独立配置在 /socketstat 上，
// 约定 **配置留空 = 不启用**。目前只有 udp 真的把按键发出去（arrow 模式），
// tcp/ws 先把配置与启用状态放这儿（见 todo.md）。
void socket_init();                 // 开 udp 监听 + 从 EEPROM 读三份配置（wifi_init 里调）
void socket_poll();                 // udp 收包（casualloop 里调）
void wifi_udp_send(int x, int y);   // arrow 模式：把按键字节发给 udp 目标

// 是否启用（由配置推导：udp/tcp 要 ip+port，ws 要 url）
bool udp_enabled();
bool tcp_enabled();
bool ws_enabled();

// 配置校验（/socketstat 页面用）：空值一律合法（= 不启用）
bool socket_ipv4_check(const String& ip, String& err);
bool socket_port_check(int port, String& err);
bool socket_wsurl_check(const String& url, String& err);
