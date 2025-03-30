#include "mywifi.h"
#define PWM_FREQ 50   //20 times per sec
#define PWM_RESOLUTION 10   //20us each, 0.5ms=25, 1.5ms=75, 2.5ms=125




static int mode = 0;
static int pwm[12] = {
  0, 0,   //0-1: left-front-top, left-front-bot
  0, 0,   //2-3: left-mid-top, left-mid-bot
  0, 0,   //4-5: left-back-top, left-back-bot
  0, 0,   //6-7: right-front-top, right-front-bot
  0, 0,   //8-9: right-mid-top, right-mid-bot
  0, 0,   //10-11: right-back-top, right-back-bot
};
void setzero()
{
  for(int j=0;j<12;j++)pwm[j] = 0;
}
void motor_disable()
{
  mode = 0;
}




static int val[12] = {
  0,0,
  0,0,
  0,0,
  0,0,
  0,0,
  0,0};
void motor_static_get(int* out)
{
  int j;
  for(int j=0;j<12;j++)out[j] = val[j];
}
void motor_static_set(int* in)
{
  int j;
  for(int j=0;j<12;j++)val[j] = in[j];

  mode = 1;
}
void convertstatic(int* in, int* out)
{
  //upper arm:
  //0,2,4: val=75+front
  //6,8,10: val=75-front
  for(int j=0;j<6;j+=2)out[j] = 75+in[j];
  for(int j=6;j<12;j+=2)out[j] = 75-in[j];

  //lower arm: 
  //1,3,5: val=75-up
  //7,9,11: val=75+up
  for(int j=1;j<6;j+=2)out[j] = 75-in[j];
  for(int j=7;j<12;j+=2)out[j] = 75+in[j];
}




static int type = 0;
void motor_dynamic_set(int tt)
{
  mode = 2;
  type = tt;
}
void convert_dynamic_rotateleft(int inv)
{
  int time = millis()%1000;
  int step = time/200;

  int ANGLEVALUE = 20*inv;

  int in[12];
  for(int j=0;j<12;j++)in[j] = 0;
  for(int j=1;j<12;j+=2)in[j] = -25;
  switch(step){
  case 0:   //stand
    break;
  case 1:
    //a:raise a
    for(int j=1;j<12;j+=4)in[j] = 0;
    //a:rotate_l/2
    in[0] = in[4] = ANGLEVALUE/2;
    in[8] = -ANGLEVALUE/2;
    break;
  case 2:
    //a:down
    for(int j=1;j<12;j+=4)in[j] = -25;
    //a:rotate_l
    in[0] = in[4] = ANGLEVALUE;
    in[8] = -ANGLEVALUE;
    break;
  case 3:
    //a:restore
    //b:rotate_r
    in[2] = -ANGLEVALUE;
    in[6] = in[10] = ANGLEVALUE;
    break;
  case 4:
    //b:raise
    for(int j=3;j<12;j+=4)in[j] = 0;
    //b:rotate_r/2
    in[2] = -ANGLEVALUE/2;
    in[6] = in[10] = ANGLEVALUE/2;
  }

  convertstatic(in, pwm);
}
void convert_dynamic_moveforward(int inv)
{
  int time = millis()%1000;
  int step = time/200;

  int MOVEVALUE = 10*inv;

  int in[12];
  in[0] = in[6] = 20;
  in[2] = in[8] = 0;
  in[4] = in[10]=-20;
  for(int j=1;j<12;j+=2)in[j] = -25;
  switch(step){
  case 0:   //stand
    break;
  case 1:
    //a:raise
    for(int j=1;j<12;j+=4)in[j] = 0;
    //a:forward
    in[0] += MOVEVALUE;
    in[4] += MOVEVALUE;
    in[8] += MOVEVALUE;
    break;
  case 2:
    //a:down
    //...
    //a:forward*2
    in[0] += MOVEVALUE*2;
    in[4] += MOVEVALUE*2;
    in[8] += MOVEVALUE*2;
    break;
  case 3:
    //a:restore
    //b:back
    in[2] -= MOVEVALUE*2;
    in[6] -= MOVEVALUE*2;
    in[10]-= MOVEVALUE*2;
    break;
  case 4:
    //b:raise
    for(int j=3;j<12;j+=4)in[j] = 0;
    //b:forward
    in[2] -= MOVEVALUE;
    in[6] -= MOVEVALUE;
    in[10]-= MOVEVALUE;
  }

  convertstatic(in, pwm);
}




void loop(){
  /*
  Serial.println("----x/1024----");
  for(int j=0;j<6;j++){
  Serial.printf("%-4d****%4d -> %-4d****%4d\n", val[j+0], val[j+6], pwm[j+0], pwm[j+6]);
  }
  */

  //digitalWrite(LED_BUILTIN, (duty/8)&1);

  wifi_poll();

  switch(mode){
  case 0:
    setzero();
    break;
  case 1:
    convertstatic(val, pwm);
    break;
  case 2:
    if('l' == type)convert_dynamic_rotateleft(1);
    else if('r' == type)convert_dynamic_rotateleft(-1);
    else if('f' == type)convert_dynamic_moveforward(1);
    else if('b' == type)convert_dynamic_moveforward(-1);
    break;
  }

  //l
  ledcWrite(2, pwm[0]);
  ledcWrite(4, pwm[1]);
  ledcWrite(17, pwm[2]);
  ledcWrite(18, pwm[3]);
  ledcWrite(19, pwm[4]);
  ledcWrite(21, pwm[5]);
  //r
  ledcWrite(13, pwm[6]);
  ledcWrite(12, pwm[7]);
  ledcWrite(27, pwm[8]);
  ledcWrite(25, pwm[9]);
  ledcWrite(32, pwm[10]);
  ledcWrite(33, pwm[11]);
  //
  delay(100);
}

void setup(){
  Serial.begin(115200);
  //pinMode(LED_BUILTIN, OUTPUT);

  wifi_init();

  //left
  ledcAttach(2, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(4, PWM_FREQ, PWM_RESOLUTION);
  //
  ledcAttach(17, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(18, PWM_FREQ, PWM_RESOLUTION);
  //
  ledcAttach(19, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(21, PWM_FREQ, PWM_RESOLUTION);
  //right
  ledcAttach(13, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(12, PWM_FREQ, PWM_RESOLUTION);
  //
  ledcAttach(27, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(25, PWM_FREQ, PWM_RESOLUTION);
  //
  ledcAttach(32, PWM_FREQ, PWM_RESOLUTION);
  ledcAttach(33, PWM_FREQ, PWM_RESOLUTION);
}
