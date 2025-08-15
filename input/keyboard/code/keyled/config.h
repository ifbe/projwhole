
#define mode_arrow 0
#define mode_8x18 1
#define mode_8x18_abcdef 1
#define mode_chosen mode_arrow

#if mode_chosen==mode_arrow
  #define ROWS 4
  #define COLS 4
#else
  #define ROWS 8
  #define COLS 18
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
