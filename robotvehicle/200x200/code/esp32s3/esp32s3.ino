#include <Wire.h>
#include <MPU6050.h>
#include "mahony.h"
#include "trajectory.h"
#include "actuator.h"

MPU6050 mpu;
unsigned long oldtime;
float deltaT;




void quaternion2eulerian(float* rq, float* e)
{
	//atan2(2(xw+yz), 1-2(xx+yy))
	e[0] = atan2( (rq[0]*rq[3]+rq[1]*rq[2])*2 , 1-(rq[0]*rq[0]+rq[1]*rq[1])*2 );
	e[0] *= 180.0/PI;

	//asin(2(yw-xz))
	e[1] = asin(  (rq[1]*rq[3]-rq[0]*rq[2])*2 );
	e[1] *= 180.0/PI;

	//atan2(2(zw+xy), 1-2(yy+zz))
	e[2] = atan2( (rq[2]*rq[3]+rq[0]*rq[1])*2 , 1-(rq[1]*rq[1]+rq[2]*rq[2])*2 );
	e[2] *= 180.0/PI;
}

void setled(int r, int g, int b)
{
  int lim = RGB_BRIGHTNESS>>1;
  if(r > lim)r = lim;
  if(g > lim)g = lim;
  if(b > lim)b = lim;
  rgbLedWrite(RGB_BUILTIN, r, g, b);
}

void val2led(float val)
{
  if(val>0)setled(val, 0, 0);
  else setled(0, 0, -val);
}

void loop()
{
  unsigned long ms = millis();
  //Serial.printf("%f,%f\n", mpu.get_acce_resolution(), mpu.get_gyro_resolution() );

  int16_t ax, ay, az, gx, gy, gz;
  mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
  //Serial.printf("raw: a=(%d,%d,%d) g=(%d,%d,%d) t=%d\n", ax,ay,az, gx,gy,gz, ms);

  float fax, fay, faz, fgx, fgy, fgz;
  fax = (-2*ax) * 9.8*2 / 32768;    //bug_to_raw * raw_to_metersec2
  fay = (-2*ay) * 9.8*2 / 32768;
  faz = (-2*az) * 9.8*2 / 32768;
  fgx = (gx) * (1000.0 / 32768) * PI / 180;   //bug_to_raw * raw_to_deg * deg_to_rad
  fgy = (gy) * (1000.0 / 32768) * PI / 180;
  fgz = (gz) * (1000.0 / 32768) * PI / 180;
  //Serial.printf("std: a=(%f,%f,%f) g=(%f,%f,%f) t=%d\n", fax,fay,faz, fgx,fgy,fgz, ms);

  deltaT = (ms-oldtime)*0.001;
  oldtime = ms;
  mahony_update6(fgx, fgy, fgz, fax, fay, faz, deltaT);

  float q[4];
  mahony_getq(q);
  //printf("%f,%f,%f,%f\n", q[0], q[1], q[2], q[3]);

  float e[3];
  quaternion2eulerian(q, e);
  printf("%f,%f,%f\n", e[0], e[1], e[2]);
/*
  float vec[3];
  computeforce(q, vec);
  float len = sqrt(vec[0]*vec[0]+vec[1]*vec[1]);
  Serial.printf("%f,%f,%f,%f\n", vec[0], vec[1], vec[2], len);
  val2led(vec[1]*90*2/PI);
*/
}

void setup()
{
  //led.init();   //no need

  Serial.begin(115200);

  Wire.begin(18, 17);  //SCL = 17, SDA = 18

  mpu.initialize(ACCEL_FS::A2G, GYRO_FS::G1000DPS);

  mahony_init();

  oldtime = millis();
}