
#define mode_arrow 0
#define mode_8x18 1
#define mode_chosen mode_8x18

// 8x18 模式下 currmode 的含义（arrow 模式只有一个键表，不用这些）
#define kbdmode_normal 0      // 常规键位
#define kbdmode_abcdef 1
#define kbdmode_ascii 2
#define kbdmode_periodic 3    // 元素周期表（字符串表在 mod_usb.cpp / mod_ble.cpp 里）

#if mode_chosen==mode_arrow
  #define ROWS 4
  #define COLS 4
#else
  #define ROWS 8
  #define COLS 18
#endif

// 模式键（右下角 4 个）暂时取消：现在只能在网页里切模式（/kbdstat 的 set mode 按钮）。
// 几何宏先留着，以后想恢复把 kbd_is_modekey 改回下面注释那行即可。
#define KBD_MODEKEY_COUNT 4
#define KBD_MODEKEY_ROW   (ROWS-1)
#define KBD_MODEKEY_COL0  (COLS-KBD_MODEKEY_COUNT)

//#define kbd_is_modekey(x, y)  ( ((y)==KBD_MODEKEY_ROW) && ((x)>=KBD_MODEKEY_COL0) )
#define kbd_is_modekey(x, y)  (0)

// 只有 8x18 模式才有元素周期表模式（模式 3）
#if mode_chosen==mode_8x18
  #define kbd_periodic_enabled 1
#else
  #define kbd_periodic_enabled 0
#endif


#define board_version1 1
#define board_version2 2
#define board_chosen board_version2

#if board_chosen==board_version1
  #define PIN_KEY_Y4 15
  #define PIN_KEY_Y5 16
  #define PIN_KEY_Y6 17
  #define PIN_KEY_Y7 18

  #define PIN_LED_Y0 3
  #define PIN_LED_Y2 46
  #define PIN_LED_Y4 45
  #define PIN_LED_Y6 0
#elif board_chosen==board_version2
  #define PIN_KEY_Y4 3
  #define PIN_KEY_Y5 46
  #define PIN_KEY_Y6 45
  #define PIN_KEY_Y7 0

  #define PIN_LED_Y0 15
  #define PIN_LED_Y2 16
  #define PIN_LED_Y4 17
  #define PIN_LED_Y6 18
#endif


#define PIN_KEY_Y0 4
#define PIN_KEY_Y1 5
#define PIN_KEY_Y2 6
#define PIN_KEY_Y3 7

#define PIN_CANH 1
#define PIN_CANL 2
#define PIN_XN2 8
#define PIN_XN1 21

#define PIN_X0 42
#define PIN_X1 41
#define PIN_X2 40
#define PIN_X3 39

#define PIN_X4 38
#define PIN_X5 37
#define PIN_X6 36
#define PIN_X7 35

#define PIN_X8 48
#define PIN_X9 47
#define PIN_X10 14
#define PIN_X11 13

#define PIN_X12 12
#define PIN_X13 11
#define PIN_X14 10
#define PIN_X15 9
