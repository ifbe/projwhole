#include "config.h"
#include <Arduino.h>




#if BATTTYPE_SELECT==BATTTYPE_2S
static float a1 = 0.0;
static float a2 = 0.0;
void battery_init()
{
  pinMode(PIN_VOLT1, INPUT);
  pinMode(PIN_VOLT2, INPUT);
}
void battery_poll()
{
  a1 = analogRead(PIN_VOLT1) * 3.3 / 4096;
  a2 = analogRead(PIN_VOLT2) * 3.3 / 4096;
  //Serial.printf("v1=%f v2=%f\n", a1, a2);
}
void getvolt(float* volt)
{
  volt[0] = a1 * (r1_up+r1_dn) / r1_dn;
  volt[1] = a2 * (r2_up+r2_dn) / r2_dn;
  volt[2] = 0;
  volt[3] = 0;
}
#endif




#if BATTTYPE_SELECT==BATTTYPE_4S
static float a1 = 0.0;
static float a2 = 0.0;
static float a3 = 0.0;
static float a4 = 0.0;
void battery_init()
{
  pinMode(PIN_VOLT1, INPUT);
  pinMode(PIN_VOLT2, INPUT);
  pinMode(PIN_VOLT3, INPUT);
  pinMode(PIN_VOLT4, INPUT);
}
void battery_poll()
{
  a1 = analogRead(PIN_VOLT1) * 3.3 / 4096;
  a2 = analogRead(PIN_VOLT2) * 3.3 / 4096;
  a3 = analogRead(PIN_VOLT3) * 3.3 / 4096;
  a4 = analogRead(PIN_VOLT4) * 3.3 / 4096;
  //Serial.printf("v1=%f v2=%f\n", a1, a2);
}
void getvolt(float* volt)
{
  volt[0] = a1 * (r1_up+r1_dn) / r1_dn;
  volt[1] = a2 * (r2_up+r2_dn) / r2_dn;
  volt[2] = a3 * (r3_up+r3_dn) / r3_dn;
  volt[3] = a4 * (r4_up+r4_dn) / r4_dn;
}
#endif