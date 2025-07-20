
#include <Adafruit_NeoPixel.h>
#define PIN       4
#define NUMPIXELS 8
Adafruit_NeoPixel pixels(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

void initled()
{
  //pinMode(LED_BUILTIN, OUTPUT);
  pixels.begin();
}


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


void setpixel(int x, int y)
{
  xxx = 2*y + x;

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
