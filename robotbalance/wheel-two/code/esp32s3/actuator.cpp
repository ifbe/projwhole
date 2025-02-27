#include "config.h"
#include <Arduino.h>




#if MOTORTYPE_SELECT==MOTORTYPE_DRV8833
#define PWM_ACCEL_LIMIT 200
int pwm_want_l = 0;
int pwm_want_r = 0;
int pwm_curr_l = 0;
int pwm_curr_r = 0;
static void ontimer_compute(){
  int err;
  pwm_curr_l = pwm_want_l;
  pwm_curr_r = pwm_want_r;
/*
  err = pwm_want_l-pwm_curr_l;
  if(err < -PWM_ACCEL_LIMIT)pwm_curr_l -= PWM_ACCEL_LIMIT;
  else if(err > PWM_ACCEL_LIMIT)pwm_curr_l += PWM_ACCEL_LIMIT;
  else pwm_curr_l = pwm_want_l;

  err = pwm_want_r-pwm_curr_r;
  if(err < -PWM_ACCEL_LIMIT)pwm_curr_r -= PWM_ACCEL_LIMIT;
  else if(err > PWM_ACCEL_LIMIT)pwm_curr_r += PWM_ACCEL_LIMIT;
  else pwm_curr_r = pwm_want_r;
*/
}
static void ontimer_output(){
  if(abs(pwm_curr_l)<2){   //0.001){
    digitalWrite(PIN_LEFT_EN, 0);
  }
  else{
    int il_p = 0;
    int il_n = 0;
    if(pwm_curr_l<0){
      il_p = 1023;
      il_n = 1023 + pwm_curr_l;
      if(il_n < 0)il_n = 0;
    }
    else{
      il_p = 1023 - pwm_curr_l;
      il_n = 1023;
      if(il_p < 0)il_p = 0;
    }
    ledcWrite(PIN_LEFT_P, il_p);
    ledcWrite(PIN_LEFT_N, il_n);
    digitalWrite(PIN_LEFT_EN, 1);
  }

  if(abs(pwm_curr_r)<2){   //0.001){
    digitalWrite(PIN_RIGHT_EN, 0);
  }
  else{
    int ir_p = 0;
    int ir_n = 0;
    if(pwm_curr_r<0){
      ir_p = 1023;
      ir_n = 1023 + pwm_curr_r;
      if(ir_n < 0)ir_n = 0;
    }
    else{
      ir_p = 1023 - pwm_curr_r;
      ir_n = 1023;
      if(ir_p < 0)ir_p = 0;
    }
    ledcWrite(PIN_RIGHT_P, ir_p);
    ledcWrite(PIN_RIGHT_N, ir_n);
    digitalWrite(PIN_RIGHT_EN, 1);
  }
}
int pingpong = 0;
static void ontimer(void *){
  if(pingpong&1)ontimer_output();
  else ontimer_compute();

  pingpong = (pingpong+1)&0xff;
}
#define PWM_FREQ 1000
#define PWM_RESOLUTION 10
#define TIMER_FREQ 1000000
#define TIMER_SETVAL 5000
hw_timer_t* timer = 0;
void motor_init()
{
  ledcAttach(PIN_LEFT_P, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(PIN_LEFT_N, PWM_FREQ, PWM_RESOLUTION);
  pinMode(PIN_LEFT_EN, OUTPUT);

  ledcAttach(PIN_RIGHT_P, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(PIN_RIGHT_N, PWM_FREQ, PWM_RESOLUTION);
  pinMode(PIN_RIGHT_EN, OUTPUT);

  //timer
  timer = timerBegin(TIMER_FREQ);   //freq=1000000
  timerAlarm(timer, TIMER_SETVAL, true, 0);   //timer, 5ms, isreload, reloadvalue
  timerAttachInterruptArg(timer, ontimer, 0);  //timer, func, arg
}
void motor_output(float fl, float fr)
{
  if(fl<-1023)fl = -1023;
  else if(fl>1023)fl = 1023;

  if(fr<-1023)fr = -1023;
  else if(fr>1023)fr = 1023;

  pwm_want_l = (int)fl;
  pwm_want_r = (int)fr;
  //Serial.printf("l=%d,r=%d\n", pwm_curr_l, pwm_curr_r);
}
void motor_getpwm(float* l, float* r)
{
  *l = (float)pwm_curr_l;
  *r = (float)pwm_curr_r;
}
#endif




#if MOTORTYPE_SELECT==MOTORTYPE_DRV8825
#define PWM_ACCEL_LIMIT 2000
int pwm_want_l = 0;
int pwm_want_r = 0;
int pwm_curr_l = 0;
int pwm_curr_r = 0;
static void ontimer_compute(){
  int err;

  err = pwm_want_l-pwm_curr_l;
  if(err < -PWM_ACCEL_LIMIT)pwm_curr_l -= PWM_ACCEL_LIMIT;
  else if(err > PWM_ACCEL_LIMIT)pwm_curr_l += PWM_ACCEL_LIMIT;
  else pwm_curr_l = pwm_want_l;

  err = pwm_want_r-pwm_curr_r;
  if(err < -PWM_ACCEL_LIMIT)pwm_curr_r -= PWM_ACCEL_LIMIT;
  else if(err > PWM_ACCEL_LIMIT)pwm_curr_r += PWM_ACCEL_LIMIT;
  else pwm_curr_r = pwm_want_r;
}
static void ontimer_output(){
  int al = abs(pwm_curr_l);
  if(al < 2){   //0.001){
    digitalWrite(PIN_LEFT_EN, 1);
  }
  else{
    if(al<160){   //0.001){
      ledcWrite(PIN_LEFT_STEP, 0);
    }
    else{
      ledcChangeFrequency(PIN_LEFT_STEP, al, 8); //resolution=2^8=256
      ledcWrite(PIN_LEFT_STEP, 128);    //duty=50%
    }
    //
    digitalWrite(PIN_LEFT_DIR, (pwm_curr_l>0)?1:0);
    digitalWrite(PIN_LEFT_EN, 0);
  }

  int ar = abs(pwm_curr_r);
  if(ar < 2){
    digitalWrite(PIN_RIGHT_EN, 1);
  }
  else{
    if(ar<160){   //0.001){
      ledcWrite(PIN_RIGHT_STEP, 0);
    }
    else{
      ledcChangeFrequency(PIN_RIGHT_STEP, ar, 8);
      ledcWrite(PIN_RIGHT_STEP, 128);
    }
    //
    digitalWrite(PIN_RIGHT_DIR, (pwm_curr_r>0)?1:0);
    digitalWrite(PIN_RIGHT_EN, 0);
  }
}
int pingpong = 0;
static void ontimer(void *){
  if(pingpong&1)ontimer_output();
  else ontimer_compute();

  pingpong = (pingpong+1)&0xff;
}
#define PWM_FREQ 1024
#define PWM_RESOLUTION 8
#define TIMER_FREQ 1000000
#define TIMER_SETVAL 5000
hw_timer_t* timer = 0;
void motor_init()
{
  pinMode(PIN_LEFT_EN, OUTPUT);
  pinMode(PIN_LEFT_M0, OUTPUT);
  pinMode(PIN_LEFT_M1, OUTPUT);
  pinMode(PIN_LEFT_M2, OUTPUT);
  pinMode(PIN_LEFT_RST, OUTPUT);
  pinMode(PIN_LEFT_SLP, OUTPUT);
  ledcAttach(PIN_LEFT_STEP, PWM_FREQ, PWM_RESOLUTION);
  pinMode(PIN_LEFT_DIR, OUTPUT);
  digitalWrite(PIN_LEFT_EN, 1);   //0=on
  digitalWrite(PIN_LEFT_M0, 1);   //1,1,1 = 32 step
  digitalWrite(PIN_LEFT_M1, 1);
  digitalWrite(PIN_LEFT_M2, 1);
  digitalWrite(PIN_LEFT_RST, 1);   //1=on
  digitalWrite(PIN_LEFT_SLP, 1);   //1=on

  pinMode(PIN_RIGHT_EN, OUTPUT);
  pinMode(PIN_RIGHT_M0, OUTPUT);
  pinMode(PIN_RIGHT_M1, OUTPUT);
  pinMode(PIN_RIGHT_M2, OUTPUT);
  pinMode(PIN_RIGHT_RST, OUTPUT);
  pinMode(PIN_RIGHT_SLP, OUTPUT);
  ledcAttach(PIN_RIGHT_STEP, PWM_FREQ, PWM_RESOLUTION);
  pinMode(PIN_RIGHT_DIR, OUTPUT);
  digitalWrite(PIN_RIGHT_EN, 1);   //0=on
  digitalWrite(PIN_RIGHT_M0, 1);   //1,1,1 = 32 step
  digitalWrite(PIN_RIGHT_M1, 1);
  digitalWrite(PIN_RIGHT_M2, 1);
  digitalWrite(PIN_RIGHT_RST, 1);   //1=on
  digitalWrite(PIN_RIGHT_SLP, 1);   //1=on

  //timer
  timer = timerBegin(TIMER_FREQ);   //freq=1000
  timerAlarm(timer, TIMER_SETVAL, true, 0);   //timer, 20ms, isreload, reloadvalue
  timerAttachInterruptArg(timer, ontimer, 0);  //timer, func, arg
}
void motor_output(float fl, float fr)
{
  //Serial.printf("l=%f,r=%f\n", fl, fr);

  pwm_want_l =-(int)fl;
  pwm_want_r = (int)fr;
}
void motor_getpwm(float* l, float* r)
{
  *l = (float)pwm_curr_l;
  if(abs(*l)<160)*l = 0;

  *r = -(float)pwm_curr_r;
  if(abs(*r)<160)*r = 0;
}
#endif




#if MOTORTYPE_SELECT==MOTORTYPE_DRV8301
void motor_init()
{
}
void motor_output(float fl, float fr)
{
}
void motor_getpwm(float* l, float* r)
{
  *l = 0;
  *r = 0;
}
#endif