#include "config.h"

//https://github.com/T-vK/ESP32-BLE-Keyboard
#include <BleKeyboard.h>
BleKeyboard blekbd;


#define MYKEY_MEDIA_NEXT_TRACK                     0x80000001   //= {1, 0};
#define MYKEY_MEDIA_PREVIOUS_TRACK                 0x80000002   //= {2, 0};
#define MYKEY_MEDIA_STOP                           0x80000004   //= {4, 0};
#define MYKEY_MEDIA_PLAY_PAUSE                     0x80000008   //= {8, 0};
#define MYKEY_MEDIA_MUTE                           0x80000010   //= {16, 0};
#define MYKEY_MEDIA_VOLUME_UP                      0x80000020   //= {32, 0};
#define MYKEY_MEDIA_VOLUME_DOWN                    0x80000040   //= {64, 0};
#define MYKEY_MEDIA_WWW_HOME                       0x80000080   //= {128, 0};
#define MYKEY_MEDIA_LOCAL_MACHINE_BROWSER          0x80000100   //= {0, 1}; // Opens "My Computer" on Windows
#define MYKEY_MEDIA_CALCULATOR                     0x80000200   //= {0, 2};
#define MYKEY_MEDIA_WWW_BOOKMARKS                  0x80000400   //= {0, 4};
#define MYKEY_MEDIA_WWW_SEARCH                     0x80000800   //= {0, 8};
#define MYKEY_MEDIA_WWW_STOP                       0x80001000   //= {0, 16};
#define MYKEY_MEDIA_WWW_BACK                       0x80002000   //= {0, 32};
#define MYKEY_MEDIA_CONSUMER_CONTROL_CONFIGURATION 0x80004000   //{0, 64}; // Media Selection
#define MYKEY_MEDIA_EMAIL_READER                   0x80008000   //= {0, 128};



static uint32_t keytable_8x18[ROWS][COLS] = {
  {MYKEY_MEDIA_PLAY_PAUSE,  KEY_ESC        },
  {MYKEY_MEDIA_STOP,        '`'            },
  {MYKEY_MEDIA_PLAY_PAUSE,  KEY_ESC        },
  {MYKEY_MEDIA_STOP,        '`'            },
  {MYKEY_MEDIA_VOLUME_UP,   KEY_TAB        },
  {MYKEY_MEDIA_VOLUME_DOWN, KEY_CAPS_LOCK  },
  {MYKEY_MEDIA_PLAY_PAUSE,  KEY_LEFT_SHIFT },
  {MYKEY_MEDIA_STOP,        KEY_LEFT_CTRL  }
};

static byte keytable_arrow[4][4] = {
  {             0,               0, KEY_PAGE_UP, KEY_END      },
  {             0,               0, KEY_HOME   , KEY_PAGE_DOWN},
  {KEY_UP_ARROW  , KEY_RIGHT_ARROW,           0,             0},
  {KEY_LEFT_ARROW, KEY_DOWN_ARROW ,           0,             0}
};




void blekbd_init()
{
  blekbd.begin();
}
void blekbd_exit()
{
}




void blekbd_press_u32(uint32_t val){
  if(val <= 0xffff){
    blekbd.press(val);
  }
  else{
    uint8_t* ptr = (uint8_t*)&val;
    blekbd.press(ptr);
  }
}

void blekbd_press(int x, int y)
{
  //if(y>1)return;
  if(!blekbd.isConnected())return;

  if(mode_chosen == mode_arrow){
    if( (x>=0) && (x<=3) && (y>=0) && (y<=3) ){
      blekbd_press_u32(keytable_arrow[y][x]);
    }
  }
  else if(mode_chosen == mode_8x18){
    blekbd_press_u32(keytable_8x18[y][x]);
  }
  //blekbd.write('a');
  //blekbd.print("haha");
}




void blekbd_release_u32(uint32_t val){
  if(val <= 0xffff){
    blekbd.release(val);
  }
  else{
    uint8_t* ptr = (uint8_t*)&val;
    blekbd.release(ptr);
  }
}

void blekbd_release(int x, int y)
{
  //if(y>1)return;
  if(!blekbd.isConnected())return;

  if(mode_chosen == mode_arrow){
    if( (x>=0) && (x<=3) && (y>=0) && (y<=3) ){
      blekbd_release_u32(keytable_arrow[y][x]);
    }
  }
  else if(mode_chosen == mode_8x18){
    blekbd_release_u32(keytable_8x18[y][x]);
  }
}