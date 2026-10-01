# arduino.md —— 开发环境 / 编译 / 烧录 / 网页

## 1. 环境

| 项目 | 版本 |
|---|---|
| Arduino IDE | 2.x（内置 arduino-cli 1.5.1） |
| esp32 core | **3.3.10**（`~/Library/Arduino15/packages/esp32/hardware/esp32/3.3.10`） |
| esptool | 5.3.0（core 自带，二进制） |
| Adafruit NeoPixel | **1.15.5**（必需） |
| ESP32 BLE Keyboard | **0.3.2**（必需，见 [gotcha.md](gotcha.md) #1/#2） |

其余都用 core 自带：`USB.h` / `USBHIDKeyboard.h` / `WebServer.h` / `WiFi.h` / `NetworkUdp.h` / `EEPROM.h` /
`esp32-hal-tinyusb.h`。

## 2. 开发板设置（Tools 菜单）

Board = **ESP32S3 Dev Module**，其余：

```
USBMode         = Hardware CDC and JTAG     (ARDUINO_USB_MODE=1)
CDCOnBoot       = Enabled                   (ARDUINO_USB_CDC_ON_BOOT=1)
FlashSize       = 8MB
PartitionScheme = default_8MB
PSRAM           = disabled
DebugLevel      = None                      (库里的 log_i/log_e 会被编译掉)
UploadSpeed     = 921600
```

完整 FQBN：

```
esp32:esp32:esp32s3:UploadSpeed=921600,USBMode=hwcdc,CDCOnBoot=cdc,MSCOnBoot=default,DFUOnBoot=default,UploadMode=default,CPUFreq=240,FlashMode=qio,FlashSize=8M,PartitionScheme=default_8MB,DebugLevel=none,PSRAM=disabled,LoopCore=1,EventsCore=1,EraseFlash=none,JTAGAdapter=default,ZigbeeMode=default
```

## 3. 源文件

| 文件 | 作用 |
|---|---|
| `keyled.ino` | 入口：定时器 ISR 扫矩阵、`loop()` 分发按键、`casualloop`(core0) 跑网页/UDP/周期表打字 |
| `keyled.h` | 编译期配置：`mode_chosen`(arrow/8x18)、`board_chosen`(v1/v2，v3 见 [esp32s3.md](esp32s3.md) §7)、引脚、模式编号、`kbd_periodic_enabled`、模式键几何（目前停用） |
| `mod_usb.cpp/.h` | USB HID：四张键表 + `usbkbd_press/release`(switch currmode) + 周期表(字符串表/打字队列) |
| `mod_ble.cpp/.h` | BLE：同上的四张表 + `KbdBleKeyboard`(绕开 NimBLE 崩溃) + 连接状态/广播名/地址查询 + 广播名/配对码配置（校验 + 存 EEPROM + 清绑定） |
| `mod_log.cpp/.h` | 日志：8KB 环形缓冲 + `Print` 接口(`kbdlog.printf`)，同时镜像到 `USBSerial`，并挂 IDF 日志钩子 |
| `mod_web.cpp/.h` | 网页：wifi / bt / udp / ws2812b / keyboard / log / sys / gpio 八个页面 |
| `mod_wifi.cpp/.h` | WiFi AP+STA、事件日志、STA/AP 状态查询、AP 已连客户端列表（ip/mac/rssi）、AP 凭据默认值与校验 |
| `mod_socket.cpp/.h` | 对外通道：udp 收(9999)/发键值（只有 arrow 模式会发）+ tcp/ws 目标的配置与校验（后两个还没接发送） |
| `mod_eeprom.cpp/.h` | 持久化 STA/AP 凭据 + UDP/TCP 目标 + WS url + BLE 名字/配对码（固定 128B slot + 校验，不再用 `EEPROM.put(String)`；总容量 2048B）。**slot 偏移、总大小、布局版本号都定义在 `mod_eeprom.h` 里**（`KBD_EE_*` 宏），改布局的规矩和一次性迁移见头文件注释 / [gotcha.md](gotcha.md) #14 |
| `mod_ws2812b.cpp/.h` | WS2812B 灯带（蛇形映射，按键上色，颜色随 currmode）+ 开机灯效：`initled()` 后 `ws2812b_fill(WS2812B_DIM_RGB)` 全灯很暗的白（1/255），setup 末尾 `ws2812b_flow()` 跑一遍流水灯（按灯带顺序 0→ROWS*COLS-1，每颗约 15ms，完事全灭） |

> 除主文件 `keyled.ino` / `keyled.h` 外，各模块统一用 `mod_` 前缀：既一眼看出是我们自己的文件，
> 也避免和 core 的同名头文件（`USB.h` / `WiFi.h` / `EEPROM.h` / `Udp.h` / `BLE.h` …）在 macOS/Windows
> 这种**不区分大小写**的盘上互相遮蔽（踩过的坑见 [gotcha.md](gotcha.md) #12）。

## 4. 编译期配置（`keyled.h`）

```c
#define mode_chosen mode_8x18   // 或 mode_arrow（4x4：只有方向键/翻页/Home/End）
#define board_chosen board_version2
```

8×18 下 `currmode`：**0 = normal(常规键位)、1 = abcdef、2 = ascii、3 = periodic(元素周期表)**，≥4 按 0 处理；
**模式切换目前只能从网页做**：`/kbdstat` 上点模式名（`normal`/`abcdef`/`ascii`/`periodic`）就是切到它，
同时页面切去编辑它那张表（`GET /kbdstat?t=N`）。只有一行切换控件，切模式和改键值都在这一页。
右下角 4 键当模式键的方案暂时停用（`keyled.h` 里 `kbd_is_modekey` 恒为 0，想恢复把注释那行换回来）。

**模式 2 (ascii) 的特殊布局**：第 0/1 列查 `keytable_ascii`（16 个特殊键），其余 16×8 格按位置直接对应 ASCII
`0x00–0x7F`（`ascii = y*16 + (x-2)`，行优先），按下就按 ASCII 发（USB/BLE 库内部查 `_asciimap`，大写和符号自动带 Shift）；
网页上这些格子是只读的，显示可读字符（`-` 表示该码库里映射为 0，按了不发东西）。
arrow 模式只有一个键表，没有 ascii/周期表模式（`kbd_periodic_enabled=0`，相关代码整块不编译）。

## 5. 网页

上电后开热点 **`esp32s3_keyboard` / `12345678`**（默认值，可在 `/wifistat` 改并存 EEPROM），浏览器打开 <http://192.168.4.1>（也可用 STA 连上你的路由后访问它的 IP）。

| 页面 | 端点 | 说明 |
|---|---|---|
| wifi | `/wifistat`（别名 `/wifi`） `/stasave`(sta) `/apsave`(ap) | 三张卡片：**status**（只放 wifi 共有的东西：`mode` / `channel` / `txpower` / `hostname`，见 [gotcha.md](gotcha.md) #16）、**sta (client)**（SSID/密码可改，存 EEPROM，保存后重启 + 本角色的 status/ip/mac/rssi）、**ap (access point)**（SSID/密码可改，默认 `esp32s3_keyboard`/`12345678`，存 EEPROM，保存后重启 + 本角色的 ip/mac/stations/每个已连客户端的 ip/mac/rssi）。配置卡里各有自己的表单和 Save 按钮，各存各的、互不影响（`/wifisave` 作为老页面的别名仍指向 sta）；AP 密码留空 = 开放热点，非空必须 8–63 字符（**保存前校验**，不合法直接拒绝，见 [gotcha.md](gotcha.md) #14） |
| bt | `/bt` `/btsave` | 三张卡片：**status**（广播名 / 地址 / connected / advertising / peers + `[bt verbose]` 开关，只读）、**keyboard**（广播名 / 配对码，可改，存 EEPROM，保存后重启并清本机配对绑定）、**gamepad**（占位，还没实现，只是把位置留出来）。有输入框所以这页**不自动刷新**，手动重载看状态 |
| socket | `/socketstate`（别名 `/udpstat`） `/udpsave` `/tcpsave` `/wssave` | 三张卡片：**udp**（ipv4+port，现在唯一真的发按键的通道）、**tcp**（ipv4+port）、**ws**（websocket，url）——各一个 Set 按钮、各存各的，**留空 = 不启用**（udp/tcp 要 ip+port 都在，ws 要 url 非空），保存立即生效不用重启。tcp/ws 目前只有配置和状态，还没接发送（见 [gotcha.md](gotcha.md) #17、[todo.md](todo.md)） |
| ws2812b | `/ws2812bstat` `/ws2812bsave` | 每键 RGB（`RRGGBB` 十六进制，只改 RAM） |
| keyboard | `/kbdstat` `/kbdsave` | 键值表 + 模式切换（同一排控件）：点模式名 = 切模式 + 编辑该表（`?t=0..3`）。0/1/3 是 hex 或字符串键值；2(ascii) 只有前两列可编辑，其余只读显示字符 |
| log | `/log` | 日志（3 秒自动刷新）+ `[clear]` `[bt verbose]` `[key events]` |
| sys | `/sys` `/sysaction` | 状态表（几何/uptime/boot/heap）+ **reboot** / **enter USB bootloader** 按钮 |
| gpio | `/gpio` | 三段：**info**（board/mode）→ **non-matrix pins**（非行列脚按 GPIO 升序，模组内部 flash 的 26-32 和 33/34 只在注脚里说明）→ **matrix**（ROWS×COLS 矩形，格子为空，底部一行标每列的 GPIO，最右一列标每行的 GPIO），段间空两行 |

状态只在自己那一页显示，别处不重复：wifi → `/wifistat`，蓝牙 → `/bt`，当前模式 → `/kbdstat`，
几何/uptime/boot/heap → `/sys`；`/log` 里的 30 秒 `stat:` 行只留 uptime/heap（wifi/ble 的"事件"照旧记流水）。

对外通道（socket，`mod_socket.cpp`）：本机 UDP 监听 9999；`wifi_udp_send()` 在 arrow 模式下把按键对应的字节发给
`/socketstate` 上配的 udp 目标（8×18 下不发送）。tcp / ws 两个目标现在只是配置（留空 = 不启用）。

## 6. 烧录

正常情况（USB 线插着 = 固件那个 CDC 口）：

1. **网页按钮**（最省事）：`/sys` → **enter USB bootloader** → USB 口切成 ROM 下载口 → IDE 里点上传。
2. **手动 1200bps 触摸**：`stty -f /dev/cu.usbmodemXXXX 1200`，设备重新枚举（PID 变 `0x1001`）后点上传。
3. **短 GPIO0 到 GND 再插 USB**（固件跑飞时的后路）。

串口输出：只有 `USBSerial`（TinyUSB CDC）有日志——`Serial` 在 `USBMode=hwcdc` 下是 HWCDC 且从不 `begin()`，
是死写（见 [gotcha.md](gotcha.md) #3）。日志双路（串口 + 网页）由 `kbdlog` 负责。

为什么不能直接点上传，见 [gotcha.md](gotcha.md) #5。

## 7. 只想做语法检查（不用 IDE）

IDE 的构建缓存里有真实编译命令（`~/Library/Caches/arduino/sketches/*/compile_commands.json`），
把里面的 `-MMD -c ... -o xxx.o` 换成 `-fsyntax-only`、输入文件换成当前源文件即可，例如：

```bash
GXX=~/Library/Arduino15/packages/esp32/tools/esp-x32/2601/bin/xtensa-esp32s3-elf-g++
$GXX -fsyntax-only <从 compile_commands.json 抄来的 flags> code/keyled/mod_web.cpp
```

（`keyled.ino` 要额外加 `-x c++ -include Arduino.h`。）换 `mode_chosen` 时把源码复制到临时目录改副本，
避免动到仓库里的 `keyled.h`。
