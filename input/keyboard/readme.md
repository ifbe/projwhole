# ESP32-S3 三模键盘

ESP32-S3 机械键盘：**USB HID / 蓝牙 BLE / WiFi(UDP)** 三路同时输出，每键 WS2812B 灯效，
8×18 与 4×4(arrow) 两种矩阵在编译期切换，板载网页可以改键值、改灯效、看日志、重启/进下载模式。

## 目录

| 路径 | 内容 |
|---|---|
| `code/keyled/` | Arduino 固件（`keyled.ino` + 各模块） |
| `kicad/` | PCB 工程（kbd2x2 / kbd4x4 / kbd5x5 / esp32s3-wroom1 底板） |
| `scad/` | 外壳与键帽（OpenSCAD，以及导出的 stl / 3mf） |

## 其他文档

- [`arduino.md`](arduino.md) —— 开发环境、编译参数、烧录方式、网页入口
- [`gotcha.md`](gotcha.md) —— 踩过的坑（NimBLE / USB CDC / 下载模式 / EEPROM / 中断…）
- [`esp32s3.md`](esp32s3.md) —— ESP32-S3 引脚用途（8x18 + board v2），含未使用脚清单
- [`todo.md`](todo.md) —— 待办与已知问题

## 相关链接

- Arduino ESP32 core：<https://github.com/espressif/arduino-esp32>
- ESP32-S3 产品页/文档：<https://www.espressif.com/en/products/socs/esp32-s3>
- ESP32-BLE-Keyboard：<https://github.com/T-vK/ESP32-BLE-Keyboard>
- Adafruit NeoPixel：<https://github.com/adafruit/Adafruit_NeoPixel>
- esptool：<https://github.com/espressif/esptool>
