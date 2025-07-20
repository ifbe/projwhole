#include <Arduino.h>
#include "config.h"
#include "actuator.h"

void quaternion_multiplyfrom(float* o, float* l, float* r)
{
	o[0] = l[0]*r[3] + l[3]*r[0] + l[1]*r[2] - l[2]*r[1];
	o[1] = l[1]*r[3] + l[3]*r[1] + l[2]*r[0] - l[0]*r[2];
	o[2] = l[2]*r[3] + l[3]*r[2] + l[0]*r[1] - l[1]*r[0];
	o[3] = l[3]*r[3] - l[0]*r[0] - l[1]*r[1] - l[2]*r[2];
}

void quaternion2bodyspaceworldaxis(float* q, float* r, float* f, float* t)
{
  if(r){
  r[0] = 1.0 - (q[1]*q[1] + q[2]*q[2]) * 2.0;
  r[1] =       (q[0]*q[1] - q[2]*q[3]) * 2.0;
  r[2] =       (q[0]*q[2] + q[1]*q[3]) * 2.0;
  }
  if(f){
  f[0] =       (q[0]*q[1] + q[2]*q[3]) * 2.0;
  f[1] = 1.0 - (q[0]*q[0] + q[2]*q[2]) * 2.0;
  f[2] =       (q[1]*q[2] - q[0]*q[3]) * 2.0;
  }
  if(t){
  t[0] =       (q[0]*q[2] - q[1]*q[3]) * 2.0;
  t[1] =       (q[1]*q[2] + q[0]*q[3]) * 2.0;
  t[2] = 1.0 - (q[0]*q[0] + q[1]*q[1]) * 2.0;
  }
}

void quaternion2axismulangle(float* q, float* a)
{
	float l,t;

	l = q[0]*q[0] + q[1]*q[1] + q[2]*q[2];
	if(l < 1e-12){
		a[0] = 0.0;
		a[1] = 0.0;
		a[2] = 0.0;
	}
	else{
		l = sqrt(l);
		t = 2.0 * atan2(l, q[3]) / l;
		a[0] = q[0] * t;
		a[1] = q[1] * t;
		a[2] = q[2] * t;
	}
}

void axismulangle2axisandangle(float* a, float* q)
{
  float angle = sqrt(a[0]*a[0]+a[1]*a[1]+a[2]*a[2]);
  float invert = 1/angle;
  q[0] = a[0]*invert;
  q[1] = a[1]*invert;
  q[2] = a[2]*invert;
  q[3] = angle;
}

static float bodyspace_sensorattitude[4] = SENSORINBODYSPACE;
//{0.07465827159691414, -0.04955423236032814, 0, 0.9959771686827665};
void computeeulerian(float* qin, float* vec)
{
  //1.rmat_sensortoworld = worldspace_sensorattitude = q
  //  rmat_worldtosensor = sensorspace_worldattitude = q^
  //2.rmat_sensortobody = bodyspace_sensorattitude = {0.065427, -0.043427, 0.430485, 0.899171};
  //  rmat_bodytosensor = sensorspace_bodyattitude = bodyspace_sensorattitude^
  //3.rmat_bodytoworld * rmat_sensortobody = rmat_sensortoworld
  //  rmat_bodytoworld = rmat_sensortoworld * rmat_sensortobody^
  //  worldspace_bodyattitude = q * bodyspace_sensorattitude^
  float sensorspace_bodyattitude[4] = {-bodyspace_sensorattitude[0], -bodyspace_sensorattitude[1], -bodyspace_sensorattitude[2], bodyspace_sensorattitude[3]};
  float q[4];
  quaternion_multiplyfrom(q, qin, sensorspace_bodyattitude);

  //
  float vr[4];
  float vt[4];
  quaternion2bodyspaceworldaxis(q, vr, 0, vt);
  vec[0] = atan2(vt[1], vt[2]);
  vec[1] =-atan2(vt[0], vt[2]);
  vec[2] =-atan2(vr[1], vr[0]);

/*
  quaternion2axismulangle(qbody, vec);
  vec[2] = 0;
  axismulangle2axisandangle(vec, vec);
  vec[3] *= 180 / MYPI;
*/
}




#if ROBOT_SELECT==ROBOT_TTMOTOR
void computeangular(float* ain, float* vec)
{
  vec[0] =-ain[1];
  vec[1] = ain[0];
  vec[2] = ain[2];
}
static float speedpwm = 0;
float pseudospeed()
{
  float l,r;
  motor_getpwm(&l, &r);
  float pwm = (l+r)/2;
  speedpwm = speedpwm*0.7 + pwm*0.3;
  return speedpwm;
}

static float speed_want = 0;
static float speed_curr = 0;
//
static float speed_ilimit = 2000;
static float speed_inte = 0;
//
static float speed_kp = 0;
static float speed_ki = speed_kp/200;
static float speed_kd = 0;
void speedring(float wantspeed, float currspeed, float* wantdeg)
{
  float err = wantspeed - currspeed;
  float val = err*speed_kp + speed_inte*speed_ki;
  if(val <-10)val =-10;
  if(val > 10)val = 10;
  //Serial.printf("%f,%f -> %f\n", wantspeed, currspeed, val);

  speed_inte += err;
  if(speed_inte <-speed_ilimit)speed_inte =-speed_ilimit;
  if(speed_inte > speed_ilimit)speed_inte = speed_ilimit;

  *wantdeg = val;
}

//static float pitch_inte = 0;
static float pitch_bias = 0;
static float pitch_kp = 30;
static float pitch_ki = 0;
static float pitch_kd = 0;
void pitchring(float wantdeg, float currdeg, float an, float* out, long ms)
{
  float err = wantdeg - currdeg;

  float val = err*pitch_kp + an*pitch_kd;
  out[0] += val;
  out[1] += val;
}

static float yaw_kp = 0;
static float yaw_ki = 0;
static float yaw_kd = 0;
void yawring()
{
}

void computepid(float* angle, float* angular, float* out, long ms)
{
  float bias = -pitch_bias;
  float deg = -angle[0];
  float an = -angular[0];

  out[0] = out[1] = 0;
  if(abs(deg)>60)return deg-bias;

  //speed -> pitch
  float wantdeg=0;
  speedring(0, pseudospeed(), &wantdeg);

  //pitch -> force
  pitchring(bias+wantdeg, deg, an, out, ms);

  //yaw -> force

  //led
  return deg-bias;
}
#endif




#if ROBOT_SELECT==ROBOT_STEPPERMOTOR
void computeangular(float* ain, float* vec)
{
  vec[0] = ain[0];
  vec[1] = ain[1];
  vec[2] = ain[2];
}
static float speed_curr = 0;
float pseudospeed()
{
  //float l = motor_getl();
  //float r = motor_getr();
  float l,r;
  motor_getpwm(&l, &r);
  float pwm = (l+r)/2;

  speed_curr = speed_curr*0.7 + pwm*0.3;
  //Serial.printf("%f %f %f %f\n", l, r, pwm, speed_curr);
  if(abs(speed_curr)<100)return 0;
  return speed_curr;
}
static int speed_timestamp = 0;
static float speed_want = 0;
float checkspeed()
{
  int t = millis();
  if(t > speed_timestamp+1000)speed_want = 0;
  return speed_want;
}
//
static float speed_ilimit = 2000;
static float speed_inte = 0;
//
static float speed_kp = 0.0018;  //1000;
static float speed_ki = 0;  //speed_kp/200;
static float speed_kd = 0;
void speedring(float wantspeed, float currspeed, float* wantdeg)
{
  float err = wantspeed - currspeed;
  float val = err*speed_kp + speed_inte*speed_ki;
  if(val <-12)val =-12;
  if(val > 12)val = 12;
  //Serial.printf("(%f-%f=%f) (%f) (%f)\n", wantspeed, currspeed, err, speed_inte, val);

  speed_inte += err;
  if(speed_inte <-speed_ilimit)speed_inte =-speed_ilimit;
  if(speed_inte > speed_ilimit)speed_inte = speed_ilimit;

  *wantdeg = val;
}
//
static float pitch_bias = 2;
static float pitch_kp = 500;    //750
static float pitch_ki = 0;
static float pitch_kd = -250;    //-120;   //550
void pitchring(float wantdeg, float currdeg, float an, float* out, long ms)
{
  float err = wantdeg - currdeg;

  float val = err*pitch_kp + an*pitch_kd;
  out[0] += val;
  out[1] += val;
}
//
static int yaw_timestamp = 0;
static float yaw_want = 0;
float checkyaw()
{
  int t = millis();
  if(t > yaw_timestamp+1000)yaw_want = 0;
  return yaw_want;
}
static float yaw_kp = 0;
static float yaw_ki = 0;
static float yaw_kd = 0;
void yawring(float delta, float* out)
{
  float val = yaw_want;
  out[0] -= val;
  out[1] += val;
}
int computepid(float* angle, float* angular, float* out, long ms)
{
  float bias = -pitch_bias;
  float deg = -angle[0];
  float an = -angular[0];

  out[0] = out[1] = 0;
  if(abs(deg)>60)return deg-bias;

  //speed -> pitch
  float wantdeg=0;
  float s_want = checkspeed();
  float s_curr = pseudospeed();
  speedring(s_want, s_curr, &wantdeg);

  //pitch -> force
  pitchring(bias+wantdeg, deg, an, out, ms);

  //yaw -> force
  float y_delta = checkyaw();;
  yawring(y_delta, out);

  //led
  return deg-bias;
}
#endif




#if (ROBOT_SELECT==ROBOT_BLDCMOTOR)||(ROBOT_SELECT==ROBOT_TEST)
void computeangular(float* ain, float* vec)
{
  vec[0] = ain[0];
  vec[1] = ain[1];
  vec[2] = ain[2];
}
static float speedpwm = 0;
float pseudospeed()
{
  //float l = motor_getl();
  //float r = motor_getr();
  float l,r;
  motor_getpwm(&l, &r);
  float pwm = (l+r)/2;

  speedpwm = speedpwm*0.7 + pwm*0.3;
  //Serial.printf("%f %f %f %f\n", l, r, pwm, speedpwm);
  return speedpwm;
}
static float speed_want = 0;
static float speed_curr = 0;
//
static float speed_ilimit = 2000;
static float speed_inte = 0;
//
static float speed_kp = 1000;
static float speed_ki = speed_kp/200;
static float speed_kd = 0;
void speedring(float wantspeed, float currspeed, float* wantdeg)
{
  float err = wantspeed - currspeed;
  float val = err*speed_kp + speed_inte*speed_ki;
  if(val <-12)val =-12;
  if(val > 12)val = 12;
  //Serial.printf("(%f-%f=%f) (%f) (%f)\n", wantspeed, currspeed, err, speed_inte, val);

  speed_inte += err;
  if(speed_inte <-speed_ilimit)speed_inte =-speed_ilimit;
  if(speed_inte > speed_ilimit)speed_inte = speed_ilimit;

  *wantdeg = val;
}
//
static float pitch_bias = 0;
static float pitch_kp = 500;    //750
static float pitch_ki = 0;
static float pitch_kd = -120;   //550
void pitchring(float wantdeg, float currdeg, float an, float* out, long ms)
{
  float err = wantdeg - currdeg;

  float val = err*pitch_kp + an*pitch_kd;
  out[0] += val;
  out[1] += val;
}
//
static float yaw_kp = 0;
static float yaw_ki = 0;
static float yaw_kd = 0;
void yawring()
{
}
int computepid(float* angle, float* angular, float* out, long ms)
{
  float bias = -pitch_bias;
  float deg = -angle[0];
  float an = -angular[0];

  out[0] = out[1] = 0;
  if(abs(deg)>60)return deg-bias;

  //speed -> pitch
  float wantdeg=0;
  float currspeed = pseudospeed();
  if(abs(deg-bias) < 10){
  }
  else{
  }
  return deg-bias;
}
#endif




//--------
void planner_speedring_getpid(float* pid)
{
  pid[0] = speed_kp;
  pid[1] = speed_ki;
  pid[2] = speed_kd;
}
void planner_speedring_setpid(float* pid)
{
  speed_kp = pid[0];
  speed_ki = pid[1];
  speed_kd = pid[2];
}
void planner_speedring_getilimit(float* ilimit, float* inte)
{
  *ilimit = speed_ilimit;
  *inte = speed_inte;
}
void planner_speedring_setilimit(float* ilimit)
{
  speed_ilimit = *ilimit;
}
void planner_speedring_getspeed(float* want, float* curr)
{
  *want = speed_want;
  *curr = speed_curr;
}
void planner_speedring_setspeed(float* want)
{
  speed_want = *want;
  speed_timestamp = millis();
}
//--------
void planner_pitchring_getpid(float* pid)
{
  pid[0] = pitch_kp;
  pid[1] = pitch_ki;
  pid[2] = pitch_kd;
}
void planner_pitchring_setpid(float* pid)
{
  pitch_kp = pid[0];
  pitch_ki = pid[1];
  pitch_kd = pid[2];
}
void planner_pitchring_getbias(float* bias)
{
  *bias = pitch_bias;
}
void planner_pitchring_setbias(float* bias)
{
  pitch_bias = *bias;
}
//--------
void planner_yawring_getpid(float* pid)
{
  pid[0] = yaw_kp;
  pid[1] = yaw_ki;
  pid[2] = yaw_kd;
}
void planner_yawring_setpid(float* pid)
{
  yaw_kp = pid[0];
  yaw_ki = pid[1];
  yaw_kd = pid[2];
}
void planner_yawring_getyaw(float* y)
{
  y[0] = yaw_want;
}
void planner_yawring_setyaw(float* y)
{
  yaw_want = *y;
  yaw_timestamp = millis();
}