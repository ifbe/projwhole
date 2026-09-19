#pragma once

#include <Arduino.h>

void blekbd_init();

void blekbd_press(int x, int y);

void blekbd_release(int x, int y);

// 周期表模式用：按 ASCII 字符发送（库内部会查 ASCII->HID 表并自动处理 Shift）
void blekbd_press_ascii(char c);
void blekbd_release_ascii(char c);

// 元素周期表模式（8x18 的模式 3）：每格一个字符串，按下时逐字符发送
int blekbd_str_maxlen();
bool blekbd_str_valid(const char* s);
const char* blekbd_getstr(int x, int y);
bool blekbd_setstr(int x, int y, const char* s);
void blekbd_type(const char* s);        // 入队（onpress 里调用，不阻塞）
void blekbd_type_poll();                // 逐字符发送（casualloop 里调用）
size_t blekbd_type_len();
void blekbd_type_clear();

// 键值表读写（Web 改键用），表编号 = 模式号，见 mod_ble.cpp 里的 blekbd_table()
int blekbd_table_count();
const char* blekbd_table_name(int table);
bool blekbd_key_valid(uint32_t val);
uint32_t blekbd_getkey(int table, int x, int y);
bool blekbd_setkey(int table, int x, int y, uint32_t val);

// 蓝牙状态（/bt 页面用）
bool blekbd_is_connected();
bool blekbd_is_advertising();
int blekbd_connected_count();
const char* blekbd_name();     // 广播/手机列表里看到的名字
String blekbd_address();       // 本机 BLE 地址（没初始化时是 00:00:00:00:00:00）
