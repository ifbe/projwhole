#include "keyled.h"
#include "mod_ws2812b.h"
#include <Adafruit_NeoPixel.h>
#include <string.h>
Adafruit_NeoPixel* pixels_stsled = 0;
Adafruit_NeoPixel* pixels_perkey = 0;

extern int currmode;
static uint32_t rgbtable[ROWS][COLS] = {};

// ---- 开机灯效 ----
// 上电先全灯很暗的白（WS2812B_DIM_RGB，1/255），setup 末尾跑一遍流水灯，跑完全灭。
#define WS2812B_FLOW_RGB   0x302010   // 流水那颗的亮度（0x40 = 64/255）
#define WS2812B_FLOW_MS    10         // 每颗亮多久；加上整条 show 大约 15ms/颗

void initled()
{
  //delay(1000);

  pixels_perkey = new Adafruit_NeoPixel(ROWS*COLS, PIN_LED_Y0, NEO_GRB + NEO_KHZ800);
  pixels_perkey->begin();
}


void ws2812b_clear()
{
  if(pixels_perkey)pixels_perkey->clear();
  //if(pixels_y2y3)pixels_y2y3->clear();
  //if(pixels_y4y5)pixels_y4y5->clear();
  //if(pixels_y6y7)pixels_y6y7->clear();
}

void ws2812b_show()
{
  if(pixels_perkey)pixels_perkey->show();
}

// 全灯一个颜色：只 show 一次（别一颗一颗 show，144 颗那样要 600ms）
void ws2812b_fill(uint32_t rgb)
{
  if(0 == pixels_perkey)return;

  uint32_t r = (rgb >> 16) & 0xff;
  uint32_t g = (rgb >> 8) & 0xff;
  uint32_t b = rgb & 0xff;

  pixels_perkey->fill(pixels_perkey->Color(r, g, b));
  pixels_perkey->show();

  // rgbtable 是 /ws2812bstat 和按键上色的依据，这里也同步，免得页面显示和实际不一致
  for(int y=0;y<ROWS;y++){
    for(int x=0;x<COLS;x++)rgbtable[y][x] = rgb;
  }
}

// 开机流水灯：按灯带物理顺序 0 → ROWS*COLS-1 走一遍，最后全灭。
// 同一时刻只亮一颗（下一步 show 的时候把上一颗关掉），所以每步只有一次 show。
void ws2812b_flow()
{
  if(0 == pixels_perkey)return;

  uint32_t r = (WS2812B_FLOW_RGB >> 16) & 0xff;
  uint32_t g = (WS2812B_FLOW_RGB >> 8) & 0xff;
  uint32_t b = WS2812B_FLOW_RGB & 0xff;

  for(int i=0;i<ROWS*COLS;i++){
    if(i > 0)pixels_perkey->setPixelColor(i-1, 0);   // 关掉上一颗
    pixels_perkey->setPixelColor(i, pixels_perkey->Color(r, g, b));
    pixels_perkey->show();
    delay(WS2812B_FLOW_MS);
  }

  pixels_perkey->clear();       // 最后一颗也关掉
  pixels_perkey->show();
  memset(rgbtable, 0, sizeof(rgbtable));
}

uint32_t ws2812b_getpixel(int x, int y)
{
  return rgbtable[y][x];
}

void ws2812b_setpixel(int x, int y, uint32_t rgb)
{
  rgbtable[y][x] = rgb;

  uint32_t r = (rgb >>16) & 0xff;
  uint32_t g = (rgb >> 8) & 0xff;
  uint32_t b = rgb & 0xff;

  int where = (y & 0xfe) * COLS + x;
  if(y&1)where += 2*COLS-1 - 2*x;

  pixels_perkey->setPixelColor(where, pixels_perkey->Color(r, g, b));
  pixels_perkey->show();
}

void ws2812b_press(int x, int y)
{
  if(0 == pixels_perkey)return;

  uint32_t r=4;
  uint32_t g=4;
  uint32_t b=4;
  /*
  switch(currmode){
  case 0:
    r=0;
    g=0;
    b=1;
    break;
  case 1:
    r=0;
    g=1;
    b=0;
    break;
  case 2:
    r=1;
    g=0;
    b=0;
    break;
  case 3:
    r=1;
    g=1;
    b=0;
    break;
  }
  */
  
  int where = (y & 0xfe) * COLS + x;
  if(y&1)where += 2*COLS-1 - 2*x;

  pixels_perkey->setPixelColor(where, pixels_perkey->Color(r, g, b));
  pixels_perkey->show();
}

void ws2812b_release(int x, int y)
{
  if(0 == pixels_perkey)return;

  int where = (y & 0xfe) * COLS + x;
  if(y&1)where += 2*COLS-1 - 2*x;

  pixels_perkey->setPixelColor(where, 0);
  pixels_perkey->show();
}
