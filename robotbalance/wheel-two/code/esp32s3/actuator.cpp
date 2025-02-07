#include <Arduino.h>
#define PIN_LEFT_P 39
#define PIN_LEFT_N 40
#define PIN_LEFT_EN 41

#define PIN_RIGHT_P 9
#define PIN_RIGHT_N 10
#define PIN_RIGHT_EN 11

#define PWM_FREQ 1000
#define PWM_RESOLUTION 8

void initmotor()
{
  ledcAttach(PIN_LEFT_P, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(PIN_LEFT_N, PWM_FREQ, PWM_RESOLUTION);
  pinMode(PIN_LEFT_EN, OUTPUT);

  ledcAttach(PIN_RIGHT_P, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(PIN_RIGHT_N, PWM_FREQ, PWM_RESOLUTION);
  pinMode(PIN_RIGHT_EN, OUTPUT);
}

void drv8833_output(float fl, float fr)
{
  if(abs(fl)<0.001){
    digitalWrite(PIN_LEFT_EN, 0);
  }
  else{
    int il_p = 0;
    int il_n = 0;
    if(fl<0){
      il_p = 255;
      il_n = 255 + (int)(fl*255/1000);
      if(il_n < 0)il_n = 0;
    }
    else{
      il_p = 255 - (int)(fl*255/1000);
      il_n = 255;
      if(il_p < 0)il_p = 0;
    }
    ledcWrite(PIN_LEFT_P, il_p);
    ledcWrite(PIN_LEFT_N, il_n);
    digitalWrite(PIN_LEFT_EN, 1);
  }

  if(abs(fl)<0.001){
    digitalWrite(PIN_RIGHT_EN, 0);
  }
  else{
    int ir_p = 0;
    int ir_n = 0;
    if(fr<0){
      ir_p = 255;
      ir_n = 255 + (int)(fr*255/1000);
      if(ir_n < 0)ir_n = 0;
    }
    else{
      ir_p = 255 - (int)(fr*255/1000);
      ir_n = 255;
      if(ir_p < 0)ir_p = 0;
    }
    ledcWrite(PIN_RIGHT_P, ir_p);
    ledcWrite(PIN_RIGHT_N, ir_n);
    digitalWrite(PIN_RIGHT_EN, 1);
  }
}