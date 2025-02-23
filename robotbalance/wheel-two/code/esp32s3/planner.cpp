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
void computeangular(float* ain, float* vec)
{
  vec[0] = ain[0];
  vec[1] = ain[1];
  vec[2] = ain[2];
}




#if ROBOT_SELECT==ROBOT_TTMOTOR
static float prevspeed = 0;   //pseudo realtime speed
float pseudospeed()
{
  if(prevspeed<-1000)return prevspeed+1000;
  if(prevspeed< 1000)return prevspeed/100;
  return prevspeed-1000;
}

static float wantspeed = 0;
static float speed_kp = -0.002;
static float speed_ki = 0;
static float speed_kd = 0;
void speedring(float* wantdeg)
{
  float currspeed = pseudospeed();

  float err = wantspeed - currspeed;
  float val = err*speed_kp;
  if(val <-5)val =-5;
  if(val > 5)val = 5;
  //Serial.printf("%f,%f -> %f\n", wantspeed, currspeed, val);

  *wantdeg = val;
}

//static float pitch_inte = 0;
static float pitch_bias = -2;
static float pitch_kp = 80;
static float pitch_ki = 0;
static float pitch_kd = pitch_kp/200;
void pitchring(float wantdeg, float currdeg, float an, float* out, long ms)
{
  float err = wantdeg - currdeg;

  float val = err*pitch_kp;   // + an*pitch_kd;
  out[0] += val;
  out[1] += val;
/*
  pitch_inte += err;
  if(pitch_inte <-10)pitch_inte =-10;
  if(pitch_inte > 10)pitch_inte = 10;
*/
}

static float yaw_kp = 0;
static float yaw_ki = 0;
static float yaw_kd = 0;
void yawring()
{
}

void computepid(float* angle, float* angular, float* out, long ms)
{
  float deg = -angle[0];
  float an = -angular[0];

  out[0] = out[1] = 0;
  if(abs(deg)>60)return;

  //speed -> pitch
  float wantdeg=0;
  speedring(&wantdeg);

  //pitch -> force
  pitchring(pitch_bias+wantdeg, deg, an, out, ms);

  //yaw -> force

  //motor pwm as pseudo speed
  prevspeed = (out[0]+out[1])/2;
}
#endif




#if ROBOT_SELECT==ROBOT_STEPPERMOTOR
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
static float speed_inte_limit = 500000;
static float speed_inte = 0;
static float speed_kp = 6;
static float speed_ki = speed_kp/200;
static float speed_kd = 0;
void speedring(float wantspeed, float currspeed, float* wantdeg)
{
  float err = wantspeed - currspeed;
  float val = err*speed_kp + speed_inte*speed_ki;
  if(val <-15)val =-15;
  if(val > 15)val = 15;
  //Serial.printf("(%f-%f=%f) (%f) (%f)\n", wantspeed, currspeed, err, speed_inte, val);

  speed_inte += err;
  if(speed_inte <-speed_inte_limit)speed_inte =-speed_inte_limit;
  if(speed_inte > speed_inte_limit)speed_inte = speed_inte_limit;

  *wantdeg = val;
}
//
static float pitch_bias = 7;
static float pitch_kp = 450;    //750
static float pitch_ki = 0;
static float pitch_kd = -3000;   //550
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
void computepid(float* angle, float* angular, float* out, long ms)
{
  float deg = -angle[0];
  float an = -angular[0];

  out[0] = out[1] = 0;
  if(abs(deg)>60)return;

  //speed -> pitch
  float wantdeg=0;
  speedring(0, pseudospeed(), &wantdeg);

  //pitch -> force
  pitchring(-pitch_bias+wantdeg, deg, an, out, ms);
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