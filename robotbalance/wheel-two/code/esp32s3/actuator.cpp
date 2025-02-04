#include <Arduino.h>
#define PIN_LEFT_P 9
#define PIN_LEFT_N 10
#define PIN_LEFT_EN 11

#define PIN_RIGHT_P 9
#define PIN_RIGHT_N 10
#define PIN_RIGHT_EN 11

#define PWM_FREQ 1000
#define PWM_RESOLUTION 8

void initmotor()
{
  ledcAttach(PIN_LEFT_P, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(PIN_LEFT_N, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(PIN_RIGHT_P, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(PIN_RIGHT_N, PWM_FREQ, PWM_RESOLUTION);
}
void motor_output(float fl, float fr)
{
  int il_p = (int)(fl*255/100);
  int il_n = il_p;
  if(fl<0){
    il_p = 255;
  }
  else{
    il_n = 255;
  }
  ledcWrite(PIN_LEFT_P, il_p);
  ledcWrite(PIN_LEFT_N, il_n);

  int ir_p = (int)(fr*255/100);
  int ir_n = ir_p;
  if(fr<0){
    ir_p = 255;
  }
  else{
    ir_n = 255;
  }
  ledcWrite(PIN_RIGHT_P, ir_p);
  ledcWrite(PIN_RIGHT_N, ir_n);
}