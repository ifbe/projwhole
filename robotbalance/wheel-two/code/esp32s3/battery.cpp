#include <Arduino.h>

static float a1 = 0.0;
static float a2 = 0.0;
void initbattery()
{
  pinMode(1, INPUT);
  pinMode(2, INPUT);
}
void pollbattery()
{
  a1 = analogRead(1) * 3.3 / 4096;
  a2 = analogRead(2) * 3.3 / 4096;
  //Serial.printf("v1=%f v2=%f\n", a1, a2);
}
void getvolt(float* v1, float* v2)
{
  *v1 = a1;
  *v2 = a2;
}