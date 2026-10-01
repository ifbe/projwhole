# todo.md —— 待办 / 已知问题

## 高优先（影响实际使用）

1. **矩阵扫描会丢事件，去抖也没生效**（`keyled.ino`）
   - `state[y][x].cnt` 只写不读 → debounce 是死代码，触点抖动可能被当成两次按下；
   - ISR 置 `changed=1`、`loop()` 清 0，中间若 ISR 更新了 `val`，这次变化就丢了；
   - 每行 5ms、8 行一轮 40ms，窄脉冲可能整轮采不到。
   - 做法：ISR 只采样入队，去抖与状态机搬到 `loop()`；`changed` 用临界区或原子交换。
2. **LED 状态不一致、Web 保存只改 RAM**
   - `ws2812b_press/release` 不更新 `rgbtable_8x18`，而 `/ws2812bstat` 读的是它 → 页面显示与实际灯不符；
   - `release` 直接写 0 → 网页配好的颜色一按键就丢；
   - 保存不落 flash，重启恢复编译期默认。
3. **键值表 / 周期表不做持久化**
   - 现在只改 RAM，重启回到编译期默认表；要做得用 NVS `Preferences`（现有 EEPROM 512B 装不下 8×18 的表）。
4. **STA 有效性判断恒真**（`mod_wifi.cpp`）
   - `sta_ssid[0] < 0x80` 在 `char` 为有符号时永远成立（有编译告警），实际只判了 `>= ' '`。
5. **半截 HTTP 请求仍能触发 `reset=TASK_WDT`（web 自旋"路径 2"，未解）**
   - `WebServer::_parseRequest()` → `Stream::readStringUntil()` → `Stream::timedRead()` 是**纯忙等**
     （连 `yield()` 都没有），超时 `HTTP_MAX_SEND_WAIT=5000`；client 只发一半请求
     （安卓省电、探测器那种半死连接）就在 core0 上卡满 5 秒 → IDLE0 饿死 → `reset=TASK_WDT`
     （完整分析见 [gotcha.md](gotcha.md) #13）。
   - 已做：`casualloop`/`loop()` 每轮 `vTaskDelay(1)`、处理完 `server.client().stop()`。
     这解决"路径 1"（连上不发数据的连接干挂 5 秒）并把 core0 占用降下来，
     但**挡不住路径 2**——那次自旋在单次 `handleClient()` 调用内部。
   - 既然不 `disableCore0WDT()`，要根治只能：把 `server.handleClient()` 挪到一个 pin 在 **core1** 的独立任务
     （core1 的 idle 不在看门狗名单里），或者换掉同步 `WebServer`（自己写非阻塞应答层）。
   - 先加诊断确认它到底还发生不发生：`handleClient()` 前后打 `millis()`，超 200ms 就记一条日志。

## 中优先（体验 / 一致性）

6. `/wifistat`、`/udpstat` 的输入框没居中（`/kbdstat`、`/ws2812bstat` 已居中）。
7. `/log` 的开关点完 URL 上留着查询串（`/log?clear=1` 等），而页面 3 秒自动刷新 → `?clear=1` 会**每 3 秒清一次日志**。
   `bt` 那个已经在 `kbdlog_set_bt_verbose()` 里做了去重（值没变就直接返回），`clear`/`key` 还没处理；
   彻底做法是处理完查询串后 303 跳回 `/log`（`/udpsave`、`/ws2812bsave` 已经是这么干的）。
8. 第 0/1 列的灰底已无特殊含义（模式键已停用），要不要取消。
9. ascii 模式下 `keytable_ascii` 只有第 0/1 列在用（其余列被位置推导的 ASCII 取代），表里的老值留着没用，要不要精简成 8×2。
10. **模式键（右下角 4 键）目前停用**，只能在网页切模式；要恢复的话 `keyled.h` 里把 `kbd_is_modekey` 那行换回来，并想清楚 ascii 模式下它会遮住 `0x7C–0x7F` 四格。
11. 周期表模式下 `wifi_udp_send()` 是空操作（UDP 只在 arrow 模式发），要不要也逐字节发。
12. `/sys` 的 enter USB bootloader 按钮在 arrow 模式下也在（芯片级动作），要不要只在 8×18 显示。
13. `mod_ws2812b.cpp` 里 `pixels_y2y3` 分配了却从未使用；8×18 下 144 颗灯全挂在 Y0。
14. 每个按键事件都 `show()`（8×18 阻塞约 4ms）；批量改灯（网页保存）应只 `show()` 一次。
15. `ws2812b_setpixel()` 没有空指针保护（`press/release` 有）。
16. `/wifistat` 是表单页所以不能自动刷新（会冲掉没保存的输入），状态值只在打开时读一次；
    要不要加个"只刷新一次状态、不动输入框"的 JS，或者把状态挪到单独一页。
17. **蓝牙手柄（`/bt` 上的卡片现在只是占位，没有任何 HID 报告）**
    - 目标：同一个 BLE 设备上同时提供"键盘 + 手柄"两种 HID 报告；以后可能还想当 BLE 主机。
    - 走法：**一个 HID service（0x1812）+ 多个 report ID**。库现在就是这么做的（keyboard=1、media=2），
      加手柄 = 往 report map 里再塞一个 report ID（比如 3）+ `hid->inputReport(3)`；
      **不要**开两个 HID service 实例，手机/Windows 对多实例 HID 支持很差。
    - 从机 + 主机同时当是可以的：预编译 NimBLE 四个角色都开着
      （`CONFIG_BT_NIMBLE_ROLE_CENTRAL/PERIPHERAL/BROADCASTER/OBSERVER=y`），`MAX_CONNECTIONS=3`、`MAX_BONDS=3`。
      但"主机"只能做 **BLE central**——ESP32-S3 没有经典蓝牙（BR/EDR）。要读别人的手柄（HID 主机）
      得自己写 HOGP client（BLEClient 发现 0x1812 + 订阅 report 特征），core/Arduino 层没有现成封装。
    - 限制：一个广告实例 + 库的 `connected` 是单个 bool ⇒ 只能服务一个 host，多 host 要自己改造；
      WiFi AP+STA 与 BLE 共用一根 2.4G 天线（`CONFIG_ESP_COEX_SW_COEXIST_ENABLE=y`），链路一多 HID 延迟会抖。
18. **tcp / ws 只做了配置，还没接发送**（`/socketstate` 上两张卡现在只是存 EEPROM + 显示状态）
    - tcp：目标 ip:port 已存好，要做的是按键时连上去发（长连接还是每次发完关？断线重连要自己管）。
    - ws(websocket)：url 已存好；core/Arduino 没有 websocket 客户端，得自己实现握手（HTTP Upgrade +
      `Sec-WebSocket-Key` 的 SHA1/base64）和帧封装，或者砍掉这页换成纯 tcp/udp。
    - 两个都别忘了 8×18 模式（`keytable_arrow` 那套只服务 arrow 模式，8×18 现在 `wifi_udp_send()` 是空函数）。

## 低优先（工程化）

19. 崩溃现场落 RTC：PANIC 时把复位原因/最后几行日志存进 RTC 内存，下次开机打到 `/log`（现在回溯只能接 UART0 看）。
20. 日志导出入口（现在只能在页面看）。
21. 板级配置固化（`sketch.yaml` 之类），现在只能靠 [arduino.md](arduino.md) 里记的设置。
22. 目录里的 `.DS_Store` 清理掉。
23. `wifi_web_poll()` 里那个"`handleClient()` ≥1s 就记一行"的**临时计时探针**，观察一段时间确认
    路径 2（见第 5 条）确实不再出现后删掉（连注释一起删）。

## 已完成（留档）

- BLE 连接崩溃（NimBLE 下 0x2902 描述符空指针）与 `connected` 标志不同步（连上收不到键）
- EEPROM 存 `String` 的野指针问题 → 固定 slot + 校验
- 日志统一走 `kbdlog`（USB 串口 + 网页双路）；`Serial` 是死写的问题一并解决
- `/log` 与 `/sys` 拆分；`/sys` 加 reboot / enter USB bootloader 按钮
- 模式重排（0 normal / 1 abcdef / 2 ascii / 3 periodic）与元素周期表模式
- 模式切换改到右下角 4 键；周期表只编译进 8×18（4×4 下完全不存在）
- 键表集中到文件开头并统一命名（`keytable_default/abcdef/ascii/periodic`）
- 网页键值表格文字居中
- 源文件按模块重命名：`config.h`→`keyled.h`，其余模块统一 `mod_` 前缀
  （`mod_ble/mod_usb/mod_wifi/mod_udp/mod_eeprom/mod_log/mod_web/mod_ws2812b`）；
  早先直接叫 `ble/usb/wifi/udp` 时和 core 头文件撞大小写会编译不过，见 [gotcha.md](gotcha.md) #12
- 状态归位：wifi（含 AP 客户端 ip/mac/rssi）只在 `/wifistat`，蓝牙（名字/地址/连接/广播/peers）只在 `/bt`；
  `/sys` 去掉 wifi/ble/currmode 行和 `[refresh]`，30 秒 `stat:` 日志行只留 uptime/heap
- `reset=TASK_WDT` 止血（core0 IDLE0 饿死）：`casualloop` 与 `loop()` 每轮 `vTaskDelay(1)`，
  网页请求处理完立刻 `server.client().stop()`（不等对端 FIN），`handle_wifi_save` 的 `delay(1000)` → `delay(200)`；
  保留任务看门狗不动（不 `disableCore0WDT()`）。分析、残留风险与判据见 [gotcha.md](gotcha.md) #13、本文件第 5 条
- BLE 广播名 + 配对码可配置：`/bt` 拆成 **status** 卡片（只读，含 `[bt verbose]`）和 **settings** 卡片
  （name/passkey 输入 + `Save bt` → `/btsave`），存 EEPROM（名字 slot @896、配对码 @772），保存后重启；
  name 空 = 库默认名（1-24 字节），passkey 空/0 = 不用（否则 1-6 位数字，走 `BLESecurity::setPassKey` +
  `setCapability(DISPLAY_ONLY)` + bonding/MITM/SC），保存时 `ble_store_clear()` 清本机绑定。
  加了输入框所以 `/bt` 的 3 秒自动刷新去掉了（手动重载）；顺序/生效细节见 [gotcha.md](gotcha.md) #15
- `/bt` 底下加了 **gamepad 占位卡片**（只有显示，没有 HID 报告/服务；真做的话见第 17 条）
- AP（热点）的 ssid/密码改成可配置：默认仍是 `esp32s3_keyboard`/`12345678`，`/wifistat` 上可改，
  存 EEPROM（`mod_eeprom.cpp` 的 `apssidpass_save/load`）；EEPROM 扩到 1024B 并重排为
  `0 sta_ssid / 128 sta_pass / 256 ap_ssid / 384 ap_pass / 512 udp_ipv4 / 640 udp_port / 768 layout 版本`，
  带 `eeprom_migrate()` 一次性迁移（版本不符就清掉 ap/udp 四个 slot，保住 sta 配置）。
  保存前用 `wifi_ap_cred_valid()` 校验（ssid 1–31、pass 空或 8–63），启动时读回也再校验一次、不合法回退默认值。
  sta 与 ap 各一张卡片、各一个表单/按钮（`/stasave` 只管 sta、`/apsave` 只管 ap，互不影响；
  `/wifisave` 留作别名）；细节和坑见 [gotcha.md](gotcha.md) #14
