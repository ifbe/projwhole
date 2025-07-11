#include "blekbd.h"



int xxx = 0;
void setled()
{
  int b = !!(xxx&1);
  int g = !!(xxx&2);
  int r = !!(xxx&4);
  b *= RGB_BRIGHTNESS/16;
  g *= RGB_BRIGHTNESS/16;
  r *= RGB_BRIGHTNESS/16;
  rgbLedWrite(RGB_BUILTIN, r, g, b);
}


#include <Adafruit_NeoPixel.h>
#define PIN       4
#define NUMPIXELS 8
Adafruit_NeoPixel pixels(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);
void setpixel()
{
  pixels.clear();

  for(int i=0; i<NUMPIXELS; i++) {
    int tmp = (xxx+i)%8;
    int r = (tmp&1)*16;
    int g = ((tmp>>1)&1)*16;
    int b = ((tmp>>2)&1)*16;
    pixels.setPixelColor(i, pixels.Color(r, g, b));
  }

  pixels.show();
}




#include "USB.h"
#include "USBHIDKeyboard.h"
USBCDC USBSerial;
USBHIDKeyboard usbkbd;



int cycle = 0;
const byte ROWS = 4; //four rows
const byte COLS = 2; //four columns
static byte rowPins[ROWS] = {14, 13, 12, 11}; //connect to the row pinouts of the keypad
static byte colPins[COLS] = {1, 2};
static byte keytable[ROWS][COLS] = {
  {HID_KEY_POWER, HID_KEY_ESCAPE    },
  {HID_KEY_MUTE,  HID_KEY_GRAVE     },
  {HID_KEY_HELP,  HID_KEY_KEYPAD_TAB},
  {HID_KEY_MENU,  HID_KEY_CAPS_LOCK }
  //{HID_KEY_SHIFT_LEFT}
  //{HID_KEY_CONTROL_LEFT}
};
struct _state{
  byte val;
  byte old;
  byte cnt;
  byte changed;
};
struct _state state[ROWS][COLS];


#define PWM_FREQ 1000
#define PWM_RESOLUTION 10
#define TIMER_FREQ 1000000
#define TIMER_SETVAL 5000
hw_timer_t* timer = 0;
void IRAM_ATTR ontimer(void* ptr)
{
  //read
  for(int j=0;j<COLS;j++){
    state[cycle][j].old = state[cycle][j].val;
    state[cycle][j].val = (digitalRead(colPins[j]) == HIGH);

    if(state[cycle][j].old == state[cycle][j].val){
      if(state[cycle][j].cnt < 10)state[cycle][j].cnt++;
    }
    else{
      state[cycle][j].cnt = 1;
      state[cycle][j].changed = 1;
      if(state[cycle][j].val == HIGH){
        xxx = cycle*COLS + j;
        USBSerial.printf("%d,%d: %d->%d\n", cycle, j, state[cycle][j].old, state[cycle][j].val);
        //usbkbd.pressRaw(HID_KEY_A);
      }
      else{
        USBSerial.printf("%d,%d: %d->%d\n", cycle, j, state[cycle][j].old, state[cycle][j].val);
        //usbkbd.releaseRaw(HID_KEY_A);
      }
    }
  }

  //clear
  digitalWrite(rowPins[cycle], LOW);

  //next
  cycle = (cycle+1) % ROWS;
  digitalWrite(rowPins[cycle], HIGH);
}


void setup()
{
  //Serial.begin(115200);
  USBSerial.begin(115200);
  usbkbd.begin();
  USB.begin();

  blekbd_init();

  //pinMode(LED_BUILTIN, OUTPUT);

  pixels.begin();

  //col input
  for(int j=0;j<COLS;j++){
    pinMode(colPins[j], INPUT_PULLDOWN);
  }

  //row output
  for(int j=0;j<ROWS;j++){
    pinMode(rowPins[j], OUTPUT);
    digitalWrite(rowPins[j], 0);
  }

  //cycle 0
  cycle = 0;
  digitalWrite(rowPins[cycle], HIGH);

  //timer
  timer = timerBegin(TIMER_FREQ);   //freq=1000000
  timerAlarm(timer, TIMER_SETVAL, true, 0);   //timer, 5ms, isreload, reloadvalue
  timerAttachInterruptArg(timer, ontimer, 0);  //timer, func, arg
}

void loop()
{
  //Serial.println(xxx);
  setled();
  setpixel();

  for(int y=0;y<ROWS;y++){
    for(int x=0;x<COLS;x++){
      if(0 == state[y][x].changed)continue;
      state[y][x].changed = 0;

      if(state[y][x].val == 1){
        USBSerial.printf("%d press\n", keytable[y][x]);

        usbkbd.pressRaw(keytable[y][x]);

        blekbd_press(x, y);
      }
      else{
        USBSerial.printf("%d release\n", keytable[y][x]);

        usbkbd.releaseRaw(keytable[y][x]);

        blekbd_release(x, y);
      }
    }
  }
}