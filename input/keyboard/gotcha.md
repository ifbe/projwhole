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

## 13. `reset=TASK_WDT`：core0 的 IDLE0 被"饿死"，不是崩溃也不是内存

编译期只有 **core0 的 idle 任务**在任务看门狗名单里（`CONFIG_ESP_TASK_WDT_CHECK_IDLE_TASK_CPU0=y`，
CPU1 那条没开），超时 5s、`trigger_panic=y`；`loopTask` 默认**不在**名单里（要显式 `enableLoopWDT()`）。
所以 `reset=TASK_WDT` 的含义很确定：**core0 上有任务连续 5 秒没让步，idle 一次都没跑**——
跟 PANIC（崩溃）、BROWNOUT（供电）完全不是一类问题。

本工程 core0 上只有协议栈（WiFi 驱动 / BT controller 都 pin 在 core0，优先级 23；esp_timer 22；lwIP 18）
和我们的 `casualloop`（core0、优先级 1）。`loop()` + 矩阵扫描 ISR 在 core1
（`CONFIG_ARDUINO_RUNNING_CORE=1`），core1 的 idle 不在名单里——**但别把这当设计依据**，那只是编译配置的巧合。

踩到的两条自旋路径，都在 arduino `WebServer` / `Stream` **内部**，我们的代码插不进去让步：

1. `WebServer::handleClient()`：client 连上但没数据时走 `keepCurrentClient=true; callYield=true;`，
   窗口是 `HTTP_MAX_DATA_WAIT = 5000` ms，结尾只调 `yield()`；而 `yield()` 就是 `vPortYield()`，
   **只让给同级及以上优先级，永远不会让 IDLE0 跑**。
2. `_parseRequest()` → `Stream::readStringUntil()` → `Stream::timedRead()`：**纯忙等，连 `yield()` 都没有**，
   超时是 `setTimeout(HTTP_MAX_SEND_WAIT) = 5000` ms。请求只发一半（安卓省电、探测器那种半死连接）就卡满 5 秒。
   **这条在单次 `handleClient()` 调用内部**，所以"循环末尾加 delay"救不了它。

顺带一个坑：`NetworkClient::connected()` 收到 FIN（对端正常关闭，`res == 0`）仍返回 `true`
（落到 `default:` 分支），所以浏览器关了连接，上面那个 5 秒窗口也不会提前结束，只能等 accept+5s 超时。

经验规则：

- 常驻轮询任务每轮**必须** `vTaskDelay(1)`（≥1 tick）；**`yield()` / `delay(0)` 不算让步**。
  本工程 tick = 1ms（`CONFIG_FREERTOS_HZ=1000`）所以 `delay(1)` 也等于 1 tick，但别依赖 tick 率。
- 网页请求处理完就 `server.client().stop()`，别等对端 FIN（见上一条）。
- 想在保留 5s 看门狗的前提下根治路径 2，只能让 web 轮询跑在 **core1**（core1 的 idle 不在名单里）。
  `disableCore0WDT()` 也能立刻不炸，但那是拆安全网，本工程明确不用。
- 诊断手法：`handleClient()` 前后打 `millis()`（能看到 1~5s 的单次调用）；
  `xPortGetCoreID()` 确认谁在哪个核；IDF 的 panic 原文（"Task watchdog got triggered … IDLE0 (CPU 0)"）
  在本机**看不到**——USB 口被 TinyUSB 占了、`Serial`(HWCDC) 又没 begin，想看得接 UART0 或自己落 RTC。
  上游同类 issue：<https://github.com/espressif/arduino-esp32/issues/12788>。

## 14. AP 的 ssid/密码存 EEPROM：保存前必须校验，否则会把自己锁在外面

`/wifistat` 现在能改热点（AP）的 ssid/密码，值存在 EEPROM 里（`mod_eeprom.cpp` 的
`apssidpass_save/load`，slot 256/384，紧挨着 sta 的 0/128），启动时 `wifi_init()` 用 EEPROM 的值覆盖
`mod_wifi.cpp` 里的默认值 `esp32s3_keyboard` / `12345678`。

坑点在于：**AP 起不来 = 你也进不去网页**（没有第二个入口，除非 STA 那边正好连着路由，或者接串口）。

- 所以 `wifi_ap_cred_valid()` 在**写盘之前**拦一道：ssid 1–31 字节；pass 留空（开放热点）
  或 8–63 字节（WPA2 最短 8）。不合法就 400 + 提示，一个字节都不写。
  （core 的 `APClass::create()` 只拒绝 pass<8，ssid/pass 超长是**静默截断**，还让 `ssid_len` 和数组对不上，
  所以 31/63 这两个上限必须我们自己把关。）
- `wifi_init()` 读回 EEPROM 之后再校验一次：万一存的是老版本/写坏的值，就**回退到默认值**并打日志，
  绝不让设备以"起不来的 AP"启动。
- `/stasave`（sta）和 `/apsave`（ap）是**两个独立端点**，页面上 sta / ap 各一张卡片（`.card`），
  卡片里各有自己的表单和 Save 按钮：改一边不会碰到另一边的值。`/wifisave` 还留着当别名（指向 sta），
  给手机缓存的旧页面兜底。两个 handler 里都用 `server.hasArg(...)` 兜底——字段缺失就沿用当前值，
  别当成"清空"。
- 改完 AP 密码重启后，手机要用新密码重连；旧配置会一直连不上，先在手机上"忘记网络"再连。

### EEPROM 布局改顺序 = 一定要带版本号迁移

布局是 sta_ssid(0) / sta_pass(128) / ap_ssid(256) / ap_pass(384) / udp_ipv4(512) / udp_port(640)，
版本号写在 768。**动 slot 顺序或含义时必须把 `KBD_EEPROM_LAYOUT` +1**，`eeprom_migrate()`
（在 `eeprom_open()` 里调用）会在版本不匹配时把"含义变了"的 ap/udp 四个 slot 清成 0xFF，
只保住 0/128 的 sta 配置。

为什么非要清：v1 布局里 256/384 放的是 udp 的 ip/port，直接让它们变成 ap 的 ssid/pass 的话，
老的 udp ip（比如 `192.168.5.217`，15 字节、是合法 ssid）会被当成 AP 的 ssid；如果旧 port 的字节恰好以
`0x00` 开头（比如 port=256），384 会读成"空 pass" → 合法 → **热点被静默改名成那个 IP、还变成开放网络**。
这种"数据还在、含义变了"的坑只能靠版本号一次性迁移解决，读取时再校验也兜不住。

扩容本身是安全的：core 的 `EEPROMClass::begin()` 就是 NVS 里的一个 blob，扩容时先
`memset(..., 0xFF)` 再回填老数据，新增区域读出来就是"未写入"（`slot_load()` 会拒绝）。

## 15. BLE 广播名 / 配对码：`setName` 要在 `begin()` 前，安全参数要在 `begin()` 后

`/bt` 页面现在能改广播名和配对码（存 EEPROM：名字 slot @896、配对码 @772）。三个顺序坑：

1. **广播名必须在 `blekbd.begin()` 之前设**：库的 `begin()` 里是 `BLEDevice::init(String(deviceName.c_str()))`，
   而 `setName()` 只是给 `deviceName` 赋值，`begin()` 之后再设就白设了。
2. **配对码的安全参数必须在 `begin()` 之后设**：`BLEDevice::init()` 会先把
   `sm_io_cap` 复位成 `NO_INPUT_OUTPUT`、`sm_bonding/mitm` 清零，接着库的 `begin()` 只调
   `setAuthenticationMode(ESP_LE_AUTH_BOND)`（bonding=1、**mitm=0**）——mitm=0 就永远不会弹配对码。
   所以要在 `begin()` 返回后覆盖：
   ```c
   BLESecurity::setPassKey(true, pin);                    // 静态码
   BLESecurity::setCapability(BLE_HS_IO_DISPLAY_ONLY);    // 本机"显示"，手机端输入
   BLESecurity::setAuthenticationMode(true, true, true);  // bonding + mitm + SC
   ```
   注意 `USE_NIMBLE` 在这个库的 `BleKeyboard.h` 里是**注释掉的**，所以它走 Bluedroid 分支；
   而 core 3.x 的 `BLESecurity` 在 NimBLE 下只在 `setCapability`/`setAuthenticationMode` 里直接写
   `ble_hs_cfg.*`，`setPassKey()` 的驱动调用被 `#if defined(CONFIG_BLUEDROID_ENABLED)` 包着、**不生效**——
   它只是把码存进静态成员，靠 core `BLEServer.cpp` 里 `BLE_SM_IOACT_DISP` 分支调
   `BLESecurity::getPassKey()` 用 `ble_sm_inject_io()` 注入。**别自己去找 `esp_ble_gap_set_security_param`**，
   那些 Bluedroid 符号在这个 build 里根本不存在（也正因为被 `#if` 包着才编得过）。
3. **改了名字/配对码必须清本机绑定**（`ble_store_clear()`，包在 `blekbd_forget_bonds()` 里）：
   双方都存着老密钥时手机会直接复用老绑定，新配对码根本不弹，表现就是"设了码但没用"。
   清了之后手机那边可能还留着老记录，必要时在手机上"忘记此设备"再配对。

另一个不是 BLE 的坑：**有输入框的页面不能自动刷新**。`/bt` 原来是 3 秒 `<meta refresh>`，
加了 name/passkey 输入框之后只能去掉（否则每 3 秒把没保存的输入冲掉），改成手动重载，和 `/wifistat` 一样。

## 16. WiFi 那几个"看起来是全局、其实是按接口"的属性

做 `/wifistat` 的 status 卡时踩到的，判据是"这东西属于整颗射频/整栈，还是属于某个接口"：

- **`channel` 算共有**：AP+STA 时 IDF 会把 AP 拉到 STA 连上的那个信道，整颗射频只有一个当前信道
  （`esp_wifi_get_channel(&primary, &second)`）。所以"热点怎么自己换信道了"不是 bug。
- **`txpower` 算共有**：arduino 的 `WiFi.getTxPower()` 用的是无接口参数的 `esp_wifi_get_max_tx_power()`。
  坑在单位：它是 **0.25dBm 为单位**（`WIFI_POWER_19_5dBm = 78` → 19.5dBm），直接当 dBm 用会差 4 倍。
- **`hostname` 算共有**：arduino 3.x 把它放在 `NetworkManager` 里（`WiFi.getHostname()`），
  哪个 netif 起来就套哪个，默认 `esp32s3-XXXXXX`（XXXXXX 取 MAC 后 3 字节）。
- **`MAC` 不算共有**：STA/AP 各有自己的 MAC（AP 的通常是 STA+1），分别放各自卡片。
  读的时候用 `esp_wifi_get_mac(WIFI_IF_STA/AP, mac)`，**别用 `WiFi.macAddress()`**——
  那个在接口没起来（比如 sta ssid 留空、根本没 begin()）时返回空。
- **`sleep`/省电不算共有**：`esp_wifi_set_ps` 是 station 概念（AP 不睡），arduino 的 `getSleep()`
  还只是它自己的软件标志。
- **`bandwidth`/`protocol`/promiscuous 是按接口的**：IDF 里都是 `esp_wifi_xxx(ifx, …)` 形式。
- 想做但拿不到：lwIP 的 pbuf/内存统计（`CONFIG_LWIP_STATS` 没开，预编译 libs 改不了）、
  coex 偏好（只有 setter，没 getter）。

## 17. socket 三目标的约定：留空 = 不启用（不是独立开关）

`/socketstate`（原 `/udpstat`）把对外通道拆成 udp / tcp / ws 三张卡片，各一个 Set 按钮。
"启用"是**从配置推导**的：udp/tcp 要 ipv4 + port 都在（port 1-65535），ws 要 url 非空；
没有单独的 enable 标志位 —— 所以**清空即关闭**，别指望留个开关下次还能开回来。

- 校验（`mod_socket.cpp` 的 `socket_ipv4_check` / `socket_port_check` / `socket_wsurl_check`）：
  空值一律合法；ipv4 必须是 a.b.c.d（有 DNS 也不解析，主机名不收）；port 纯数字且 1-65535；
  url 只收可打印 ASCII、≤127 字节、必须带 `scheme://host`。
- 保存是**立即生效**（不重启）：udp 是每次发包才读全局变量，所以改完下一个按键就用新目标；
  tcp/ws 现在只有配置没有发送。
- EEPROM 为此从 1024B 扩到 **2048B**（TCP 目标 1024/1152、ws url 1156）：扩容只是往 0xFF 的空白区加字段，
  老偏移一个没动，**不需要提升 `KBD_EEPROM_LAYOUT`**；新区域读出来是"未写入"，所以升级后默认就是"不启用"。
- 命名提醒：这页的 **ws = WebSocket**，和灯带那个 `ws2812b` 页完全无关（卡片标题写成 `ws (websocket)`）。

## 18. 移动/重命名 sketch 文件后，`--build-path` 必须清掉重建

arduino-cli 会把 sketch 复制到 `<build-path>/sketch/` 再编译，而且**只复制、不清理已经消失的文件**。
所以 `mod_udp.cpp` → `mod_socket.cpp` 这种改名之后，旧副本还留着，链接期直接炸：

```
multiple definition of `udp'; mod_udp.cpp.o: ... first defined here (mod_socket.cpp.o)
```

**做法**：改文件名之后先 `rm -rf <build-path>` 再编（本工程用的是 `/tmp/kbd_realbuild`）。
项目内没有 `build/` 目录，所以这条只影响手工编译/脚本，不影响 IDE 的"验证/上传"（IDE 自己会重扫 sketch）。

顺带一条更常见的：**每个 .cpp 都要 `#include` 自己的头文件**。这次把 EEPROM 布局宏从 .cpp 挪到
`mod_eeprom.h` 之后，`mod_eeprom.cpp` 因为原来没包含自己的头文件，一堆 `KBD_EE_*` 全部 "not declared"。
包含自己的头文件能让这类"宏/声明放错地方"在编译期就暴露，不会等到别的模块引用时才发现。
