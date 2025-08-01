#include "config.h"
#include <Adafruit_NeoPixel.h>
Adafruit_NeoPixel* pixels_y0y1 = 0;
Adafruit_NeoPixel* pixels_y2y3 = 0;
Adafruit_NeoPixel* pixels_y4y5 = 0;
Adafruit_NeoPixel* pixels_y6y7 = 0;

static uint32_t rgbtable_8x18[ROWS][COLS] = {};

void initled()
{
  pixels_y0y1 = new Adafruit_NeoPixel(COLS, PIN_LED_Y0, NEO_GRB + NEO_KHZ800);
  pixels_y0y1->begin();

  pixels_y2y3 = new Adafruit_NeoPixel(COLS, PIN_LED_Y2, NEO_GRB + NEO_KHZ800);
  pixels_y2y3->begin();

  pixels_y4y5 = new Adafruit_NeoPixel(COLS, PIN_LED_Y4, NEO_GRB + NEO_KHZ800);
  pixels_y4y5->begin();

  pixels_y6y7 = new Adafruit_NeoPixel(COLS, PIN_LED_Y6, NEO_GRB + NEO_KHZ800);
  pixels_y6y7->begin();
}


int xxx = 0;
/*
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
*/

void ws2812b_clear()
{
  if(pixels_y0y1)pixels_y0y1->clear();
  if(pixels_y2y3)pixels_y2y3->clear();
  if(pixels_y4y5)pixels_y4y5->clear();
  if(pixels_y6y7)pixels_y6y7->clear();
}

void ws2812b_show()
{
  if(pixels_y0y1)pixels_y0y1->show();
  if(pixels_y2y3)pixels_y2y3->show();
  if(pixels_y4y5)pixels_y4y5->show();
  if(pixels_y6y7)pixels_y6y7->show();
}


void ws2812b_press(int x, int y)
{
  //int r = (x&1)*16;
  //int g = ((x>>1)&1)*16;
  //int b = ((x>>2)&1)*16;
  int r=4;
  int g=4;
  int b=4;

  switch(y){
  case 0:
    if(0 == pixels_y0y1)return;
    pixels_y0y1->setPixelColor(x, pixels_y0y1->Color(r, g, b));
    pixels_y0y1->show();
    break;
  case 1:
    if(0 == pixels_y0y1)return;
    pixels_y0y1->setPixelColor(2*COLS-1-x, pixels_y0y1->Color(r, g, b));
    pixels_y0y1->show();
    break;
  case 2:
    if(0 == pixels_y2y3)return;
    pixels_y2y3->setPixelColor(x, pixels_y2y3->Color(r, g, b));
    pixels_y2y3->show();
    break;
  case 3:
    if(0 == pixels_y2y3)return;
    pixels_y2y3->setPixelColor(2*COLS-1-x, pixels_y2y3->Color(r, g, b));
    pixels_y2y3->show();
    break;
  case 4:
    if(0 == pixels_y4y5)return;
    pixels_y4y5->setPixelColor(x, pixels_y4y5->Color(r, g, b));
    pixels_y4y5->show();
    break;
  case 5:
    if(0 == pixels_y4y5)return;
    pixels_y4y5->setPixelColor(2*COLS-1-x, pixels_y4y5->Color(r, g, b));
    pixels_y4y5->show();
    break;
  case 6:
    if(0 == pixels_y6y7)return;
    pixels_y6y7->setPixelColor(x, pixels_y6y7->Color(r, g, b));
    pixels_y6y7->show();
    break;
  case 7:
    if(0 == pixels_y6y7)return;
    pixels_y6y7->setPixelColor(2*COLS-1-x, pixels_y6y7->Color(r, g, b));
    pixels_y6y7->show();
    break;
  }
}

void ws2812b_release(int x, int y)
{
  switch(y){
  case 0:
    if(0 == pixels_y0y1)return;
    pixels_y0y1->setPixelColor(x, 0);
    pixels_y0y1->show();
    break;
  case 1:
    if(0 == pixels_y0y1)return;
    pixels_y0y1->setPixelColor(x, 0);
    pixels_y0y1->show();
    break;
  case 2:
    if(0 == pixels_y2y3)return;
    pixels_y2y3->setPixelColor(x, 0);
    pixels_y2y3->show();
    break;
  case 3:
    if(0 == pixels_y2y3)return;
    pixels_y2y3->setPixelColor(x, 0);
    pixels_y2y3->show();
    break;
  case 4:
    if(0 == pixels_y4y5)return;
    pixels_y4y5->setPixelColor(x, 0);
    pixels_y4y5->show();
    break;
  case 5:
    if(0 == pixels_y4y5)return;
    pixels_y4y5->setPixelColor(x, 0);
    pixels_y4y5->show();
    break;
  case 6:
    if(0 == pixels_y6y7)return;
    pixels_y6y7->setPixelColor(x, 0);
    pixels_y6y7->show();
    break;
  case 7:
    if(0 == pixels_y6y7)return;
    pixels_y6y7->setPixelColor(x, 0);
    pixels_y6y7->show();
    break;
  }
}
