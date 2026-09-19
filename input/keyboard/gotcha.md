# gotcha.md —— 踩过的坑

按"踩坑 → 原因 → 现状"记，方便以后不再犯。带行号的都能在 `code/keyled/` 里找到。

## 1. NimBLE 下 BLE 一连就 PANIC（已修）

`ESP32_BLE_Keyboard` 0.3.2 头里的 `//#define USE_NIMBLE` 是注释的 → 走 Bluedroid 分支：

```cpp
// BleKeyboard.cpp onConnect()
BLE2902* desc = (BLE2902*)inputKeyboard->getDescriptorByUUID(BLEUUID(0x2902));
desc->setNotifications(true);   // desc == nullptr → LoadProhibited → PANIC
```

但 core 3.3.10 的蓝牙主机栈是 **NimBLE**（`CONFIG_BT_NIMBLE_ENABLED=y`）：
`BLEHIDDevice::inputReport()` 里创建 0x2902 描述符那段被 `#if CONFIG_BLUEDROID_ENABLED` 包着，
`BLECharacteristic::addDescriptor()` 对 0x2902 也是直接 `return`（"NimBLE 自动创建"），所以查找必然返回 nullptr。
更冤的是 `BLE2902::setNotifications()` 在 NimBLE 下本身就是空函数。

**现状**：`mod_ble.cpp` 里派生 `KbdBleKeyboard`，重写 `onConnect/onDisconnect` 跳过那两个调用。

## 2. 绕过回调后必须自己维护 `connected`，否则连上了也收不到键（已修）

```cpp
// BleKeyboard::sendReport() —— 这个 private 标志为假就什么都不发
if (this->isConnected()) { inputKeyboard->setValue(...); inputKeyboard->notify(); }
```

而 `connected` **只在库自己的 onConnect/onDisconnect 里赋值**。跳过了回调 → 标志永远为 false →
链路通、手机显示已连接，但对端一个按键都收不到。

**现状**：`mod_ble.cpp` 用 `#define private public` 把库的 `connected` 在本 TU 里暴露出来，在两个回调里亲自置位/清零；
`blekbd_is_connected()` 直接返回 `blekbd.isConnected()`，保证我们和库的判断同源。
（更干净的做法：给库补 null 判断后删掉这层派生；或把修好的库放进工程的 `src/`。）

## 3. `Serial` 在你们这套配置下是"死的"

`USBMode=hwcdc` → `ARDUINO_USB_MODE=1` → `#define Serial HWCDCSerial`（USB-Serial/JTAG），
而 core 只在 `CDC_ON_BOOT && !USB_MODE` 时自动 `Serial.begin()` → 从不 begin →
`HWCDC::write()` 里 `tx_ring_buf == NULL` 直接 return 0。**所有 `Serial.print` 都是空写。**

**现状**：日志统一走 `kbdlog`（`mod_log.cpp`），它同时写环形缓冲和 **`USBSerial`**（sketch 自己定义的 TinyUSB CDC，
也是唯一能在串口监视器里看到的那个口）。

## 4. 不要把 `String` 丢进 varargs

`kbdlog.printf("...%s", WiFi.localIP().toString())` 是 UB：短串走 SSO 时"侥幸"能打印对，
一长就打出垃圾。**现状**：改成 `.c_str()`。

## 5. USB HID ⇒ 点上传不能自动进下载模式

- 不用 TinyUSB 的 sketch（Blink、只 printf）：USB 口是**硬件 USB-Serial/JTAG**（303A:**1001**），
  esptool 的 `--before default-reset` 是硬件级复位 → 随便刷、不用 GPIO0。
- 我们的固件调了 `USB.begin()`（USB HID 键盘必须走 TinyUSB）→ USB 口变成我们自己的复合设备（303A:**0002**），
  esptool 只能靠 CDC 的 DTR/RTS 或 1200bps 触摸，让**固件自己**调 `usb_persist_restart(RESTART_BOOTLOADER)`。
- core 里这两个触发都有（`USBCDC.cpp:216` 的 4 步 DTR/RTS、`:280` 的 1200bps），
  但 IDE 的上传配方（`platform.txt:342`）只有 `--before default-reset`，**没有 1200bps 触摸那步**。
- 注意 core 自带的那两个 TinyUSB 示例（`libraries/USB/examples/USBSerial|CompositeDevice`）开头是
  `#elif ARDUINO_USB_MODE == 1 → #warning ... + 空 setup/loop`，在你们现在的设置下**根本不启动 USB**，
  拿它们和本固件对比会得出错误结论。

**现状**：`/sys` 页有 **enter USB bootloader** 按钮；也可以 `stty -f /dev/cu.usbmodemXXXX 1200` 手动触摸。

## 6. GPIO0 当行线：上电按按键进不了下载模式

board v2 把 `PIN_KEY_Y7` 放在 GPIO0（strapping）。复位瞬间按键只是把行线接到列线，
而列线的 `INPUT_PULLDOWN` 是 `setup()` 里才配的 → 那一刻等于接到悬空线，GPIO0 仍被内部弱上拉抬着 → 正常启动。
想要"按键进下载模式"必须硬件上有**直接接 GND 的 BOOT 键**（或把 EN/GPIO0 接 USB-UART 桥的 RTS/DTR）。

另外 GPIO0/45/46 是 strapping、GPIO39–42 是 JTAG，用在行/列输出上要留意上电和调试冲突。

## 7. `EEPROM.put/get` 不能存 `String`（已修）

core 的 `EEPROM.put/get` 是 `memcpy` 模板，存的是 `String` **对象内存**（堆指针 + 长度/容量，短串是 SSO 内联缓冲）。
≤14 字符时碰巧能往返，超过就走野指针；空片（0xFF）读回来是 `len=127` 的假串。

**现状**：`mod_eeprom.cpp` 用固定 128B slot 存 C 字符串 + 校验（必须能找到 `'\0'` 且之前无 `0xFF`），
写的时候整 slot 补零，读不懂就当"未配置"。

## 8. 定时器 ISR 里不要打印

ISR 里调 `kbdlog`/`Serial` 会进临界区、还可能阻塞在 USB 写上。**现状**：`keyled.ino` 里那段 ISR 调试打印是注释掉的，
并加了警告注释；要看矩阵状态就攒起来搬到 `loop()`。

## 9. 日志缓冲会被高频按键刷掉

8KB 环形缓冲大概只装几十秒连打。**现状**：`/log` 有 `[key events: off]` 开关。

## 10. 编译期宏的顺序（我踩过）

`keyled.h` 里 `kbd_periodic_enabled` 的 `#if mode_chosen==mode_8x18` 必须写在 `#define mode_chosen` **之后**，
放前面的话 `mode_chosen` 未定义（按 0 算）→ 宏恒为 0 → 8×18 下周期表整体失效。

## 11. 网页键值的取值范围

- USB HID：`00` 空位、`04–A4` 普通键、`E0–E7` 修饰键，其余拒绝。
- BLE：`00`、`20–7E` 可打印 ASCII、`80–FF` 非打印键/修饰键、`8000xxxx` 媒体键（`80000020`=音量+）。
- 周期表：字符串，≤7 个可打印 ASCII（`H`/`He`/`La-Lu`），按下时逐字符发送。
- 不用自己写 ASCII→键值表：库里 `press(uint8_t)` 自带 `_asciimap` 并会处理 Shift。

## 12. 文件名和 core 头文件只差大小写 ⇒ 互相遮蔽（已按 `mod_` 前缀解决）

当初把模块文件命名成 `usb.h` / `wifi.h` / `eeprom.h` / `udp.h`，它们和 core 的
`USB.h`（TinyUSB）/ `WiFi.h` / `EEPROM.h` / `cores/esp32/Udp.h` **只差大小写**。
macOS、Windows 的盘不区分大小写，而 arduino-cli 把 sketch 目录放在 `-I` **最前面**，
于是 `#include <USB.h>` / `<WiFi.h>` / `<EEPROM.h>` 全都先撞上我们自己的同名文件：

```
eeprom.cpp: 'EEPROM' was not declared        (拿到的是自己的 eeprom.h)
wifi.cpp:   'WiFiEvent_t' was not declared   (拿到的是自己的 wifi.h)
keyled.ino: 'USB' was not declared           (拿到的是自己的 usb.h)
```

**现在的做法**：模块统一加 `mod_` 前缀（`mod_usb.h` / `mod_wifi.h` / `mod_eeprom.h` / `mod_udp.h` …），
和 core 头文件再也不会重名，问题根除。**别再把模块头文件起成 core 已有的名字**——
尤其别用 `usb.h`/`wifi.h`/`eeprom.h`/`udp.h`/`ble.h`/`log.h` 这类和 core 库同名的。

想当初试过的绕法（现已全部删除，留个记录）：在冲突的头文件开头加 `#include_next <USB.h>` 继续往后找真身。
它有两个坑：① arduino-cli 会把整个 sketch 复制到 `build/sketch` 再编译，同一份头文件出现"副本+原件"两份，
`#include_next` 会从副本绕回原件，内容走两遍，`#pragma once` 管不住 → 声明了 struct/class 的头文件必须再加传统
include guard；② 自己包含 core 头文件时要用尖括号，引号形式会先在"本文件所在目录"里找，正好撞上同名文件。
**重命名比这套绕法干净得多，遇到就当机立断改名。**
