#pragma once

#include <Arduino.h>

// 日志同时写到 Serial 和一块内存环形缓冲，/log 页面可以看缓冲内容。
// 用法和 Serial 完全一样：kbdlog.printf(...) / kbdlog.println(...)
class KbdLogClass : public Print {
public:
  size_t write(uint8_t c) override;
  size_t write(const uint8_t* buf, size_t len) override;
};

extern KbdLogClass kbdlog;

#define KBDLOG_BUFSIZE 8192

void kbdlog_init();                            // 记录复位原因/启动计数，挂 IDF 日志钩子
void kbdlog_clear();
size_t kbdlog_copy(char* out, size_t maxlen);  // 取快照（带结尾 '\0'），返回写入字节数
uint32_t kbdlog_boot_count();
const char* kbdlog_reset_reason_str();
void kbdlog_set_bt_verbose(bool on);           // 打开底层蓝牙(BT_*)的 IDF 日志
bool kbdlog_bt_verbose();
void kbdlog_set_keylog(bool on);               // 按键事件日志开关（高频，看蓝牙问题时可以关掉）
bool kbdlog_keylog();
