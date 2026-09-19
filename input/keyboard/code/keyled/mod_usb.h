#pragma once

#include "USBHIDKeyboard.h"

void usbkbd_press(int x, int y);

void usbkbd_release(int x, int y);

// 周期表模式用：按 ASCII 字符发送（库内部会查 ASCII->HID 表并自动处理 Shift）
void usbkbd_press_ascii(char c);
void usbkbd_release_ascii(char c);

// 元素周期表模式（8x18 的模式 3）：每格一个字符串，按下时逐字符发送
int usbkbd_str_maxlen();
bool usbkbd_str_valid(const char* s);
const char* usbkbd_getstr(int x, int y);
bool usbkbd_setstr(int x, int y, const char* s);
void usbkbd_type(const char* s);        // 入队（onpress 里调用，不阻塞）
void usbkbd_type_poll();                // 逐字符发送（casualloop 里调用）
size_t usbkbd_type_len();
void usbkbd_type_clear();

// 键值表读写（Web 改键用），表编号 = 模式号，见 mod_usb.cpp 里的 usbkbd_table()
int usbkbd_table_count();
const char* usbkbd_table_name(int table);
bool usbkbd_key_valid(uint32_t val);
uint32_t usbkbd_getkey(int table, int x, int y);
bool usbkbd_setkey(int table, int x, int y, uint32_t val);
