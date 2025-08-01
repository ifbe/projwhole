#include "config.h"
#include <Arduino.h>
#include "usbkbd.h"
USBHIDKeyboard usbkbd;

static byte keytable_8x18[ROWS][COLS] = {
  {HID_KEY_POWER, HID_KEY_VOLUME_UP  },
  {HID_KEY_MUTE,  HID_KEY_VOLUME_DOWN},
  {HID_KEY_POWER, HID_KEY_ESCAPE      , HID_KEY_F1,                HID_KEY_F2,                HID_KEY_F3,    HID_KEY_F4,   HID_KEY_F5, HID_KEY_F6, HID_KEY_F7, HID_KEY_F8,    HID_KEY_F9,     HID_KEY_F10,       HID_KEY_F11,          HID_KEY_F12  },
  {HID_KEY_MUTE,  HID_KEY_GRAVE       , HID_KEY_1,                 HID_KEY_2,                 HID_KEY_3,     HID_KEY_4,    HID_KEY_5,  HID_KEY_6,  HID_KEY_7,  HID_KEY_8,     HID_KEY_9,      HID_KEY_0,         HID_KEY_MINUS,        HID_KEY_EQUAL},
  {HID_KEY_HELP,  HID_KEY_TAB         , HID_KEY_Q,                 HID_KEY_W,                 HID_KEY_E,     HID_KEY_R,    HID_KEY_T,  HID_KEY_Y,  HID_KEY_U,  HID_KEY_I,     HID_KEY_O,      HID_KEY_P,         HID_KEY_BRACKET_LEFT, HID_KEY_BRACKET_RIGHT},
  {HID_KEY_MENU,  HID_KEY_CAPS_LOCK   , HID_KEY_A,                 HID_KEY_S,                 HID_KEY_D,     HID_KEY_F,    HID_KEY_G,  HID_KEY_H,  HID_KEY_J,  HID_KEY_K,     HID_KEY_L,      HID_KEY_SEMICOLON, HID_KEY_APOSTROPHE},
  {HID_KEY_HELP,  HID_KEY_SHIFT_LEFT  , HID_KEY_Z,                 HID_KEY_X,                 HID_KEY_C,     HID_KEY_V,    HID_KEY_B,  HID_KEY_N,  HID_KEY_M,  HID_KEY_COMMA, HID_KEY_PERIOD, HID_KEY_SLASH     },
  {HID_KEY_MENU,  HID_KEY_CONTROL_LEFT, KEYBOARD_MODIFIER_LEFTGUI, KEYBOARD_MODIFIER_LEFTALT, HID_KEY_SPACE, HID_KEY_SPACE}
};
static byte keytable_arrow[4][4] = {
  {                 0,                    0, HID_KEY_PAGE_UP, HID_KEY_END      },
  {                 0,                    0, HID_KEY_HOME   , HID_KEY_PAGE_DOWN},
  {HID_KEY_ARROW_UP  ,  HID_KEY_ARROW_RIGHT,               0,                 0},
  {HID_KEY_ARROW_LEFT,  HID_KEY_ARROW_DOWN ,               0,                 0}
};


void usbkbd_press(int x, int y)
{
  if(mode_chosen == mode_arrow){
    if( (x>=0) && (x<=3) && (y>=0) && (y<=3) ){
      usbkbd.pressRaw(keytable_arrow[y][x]);
    }
  }
  else if(mode_chosen == mode_8x18){
      usbkbd.pressRaw(keytable_8x18[y][x]);
  }
}

void usbkbd_release(int x, int y)
{
  if(mode_chosen == mode_arrow){
    if( (x>=0) && (x<=3) && (y>=0) && (y<=3) ){
      usbkbd.releaseRaw(keytable_arrow[y][x]);
    }
  }
  else if(mode_chosen == mode_8x18){
      usbkbd.releaseRaw(keytable_8x18[y][x]);
  }
}