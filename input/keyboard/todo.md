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

## 中优先（体验 / 一致性）

5. `/wifistat`、`/udpstat` 的输入框没居中（`/kbdstat`、`/ws2812bstat` 已居中）。
6. `/log` 的开关点完 URL 上留着查询串（`/log?clear=1` 等），而页面 3 秒自动刷新 → `?clear=1` 会**每 3 秒清一次日志**。
   `bt` 那个已经在 `kbdlog_set_bt_verbose()` 里做了去重（值没变就直接返回），`clear`/`key` 还没处理；
   彻底做法是处理完查询串后 303 跳回 `/log`（`/udpsave`、`/ws2812bsave` 已经是这么干的）。
7. 第 0/1 列的灰底已无特殊含义（模式键已停用），要不要取消。
8. ascii 模式下 `keytable_ascii` 只有第 0/1 列在用（其余列被位置推导的 ASCII 取代），表里的老值留着没用，要不要精简成 8×2。
9. **模式键（右下角 4 键）目前停用**，只能在网页切模式；要恢复的话 `keyled.h` 里把 `kbd_is_modekey` 那行换回来，并想清楚 ascii 模式下它会遮住 `0x7C–0x7F` 四格。
10. 周期表模式下 `wifi_udp_send()` 是空操作（UDP 只在 arrow 模式发），要不要也逐字节发。
11. `/sys` 的 enter USB bootloader 按钮在 arrow 模式下也在（芯片级动作），要不要只在 8×18 显示。
12. `mod_ws2812b.cpp` 里 `pixels_y2y3` 分配了却从未使用；8×18 下 144 颗灯全挂在 Y0。
13. 每个按键事件都 `show()`（8×18 阻塞约 4ms）；批量改灯（网页保存）应只 `show()` 一次。
14. `ws2812b_setpixel()` 没有空指针保护（`press/release` 有）。
15. `/wifistat` 是表单页所以不能自动刷新（会冲掉没保存的输入），状态值只在打开时读一次；
    要不要加个"只刷新一次状态、不动输入框"的 JS，或者把状态挪到单独一页。
16. `/bt` 的广播名（`blekbd_name()`）现在恒为库默认的 "ESP32 Keyboard"（没调过 `setName()`），要不要给个网页入口改。

## 低优先（工程化）

17. 崩溃现场落 RTC：PANIC 时把复位原因/最后几行日志存进 RTC 内存，下次开机打到 `/log`（现在回溯只能接 UART0 看）。
18. 日志导出入口（现在只能在页面看）。
19. 板级配置固化（`sketch.yaml` 之类），现在只能靠 [arduino.md](arduino.md) 里记的设置。
20. 目录里的 `.DS_Store` 清理掉。

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
