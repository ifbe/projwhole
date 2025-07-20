#include "ledkbd.h"

#include "blekbd.h"

#include "USB.h"
#include "usbkbd.h"
USBCDC USBSerial;
extern USBHIDKeyboard usbkbd;




int cycle = 0;
const byte ROWS = 8; //four rows
const byte COLS = 2; //four columns
static byte rowPins[ROWS] = {4, 5, 6, 7, 15, 16, 17, 18}; //connect to the row pinouts of the keypad
static byte colPins[COLS] = {2, 1};
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
        //xxx = cycle*COLS + j;
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
  //ws2812b
  initled();

  //cdc+hid
  USBSerial.begin(115200);
  usbkbd.begin();
  USB.begin();

  //bt
  blekbd_init();

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
  //USBSerial.println(999);
  //setled();

  for(int y=0;y<ROWS;y++){
    for(int x=0;x<COLS;x++){
      if(0 == state[y][x].changed)continue;
      state[y][x].changed = 0;

      if(state[y][x].val == 1){
        USBSerial.printf("press: %d %d\n", x, y);

        //setpixel(x, y);

        usbkbd_press(x, y);

        blekbd_press(x, y);
      }
      else{
        USBSerial.printf("released: %d %d\n", x, y);

        usbkbd_release(x, y);

        blekbd_release(x, y);
      }
    }
  }

  while(USBSerial.available() > 0) {
    String incomingMessage = USBSerial.readStringUntil('\n');
    USBSerial.println(incomingMessage.c_str());
  }
}