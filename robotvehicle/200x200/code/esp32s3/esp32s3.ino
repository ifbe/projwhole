#include<Wire.h>
#include<MPU6050.h>

MPU6050 mpu;
unsigned long oldtime;
//
float deltaT;
#define twoKp 1.0
#define twoKi 0.0001
//
static float q[4];
#define qx q[0]
#define qy q[1]
#define qz q[2]
#define qw q[3]
//
static float integralx, integraly, integralz;




//origin code: https://github.com/PaulStoffregen/MahonyAHRS
//axis system: east-north-sky
//compute in: local space, not world space




static float invSqrt(float x) {
	float halfx = 0.5f * x;
	float y = x;
	long i = *(long*)&y;
	i = 0x5f3759df - (i>>1);
	y = *(float*)&i;
	y = y * (1.5f - (halfx * y * y));
	y = y * (1.5f - (halfx * y * y));
	return y;
}
void mahonyupdate6(
	float gx, float gy, float gz,
	float ax, float ay, float az)
{
	float recipNorm;
	float halfvx, halfvy, halfvz;
	float halfex, halfey, halfez;

	// Compute feedback only if accelerometer measurement valid
	// (avoids NaN in accelerometer normalisation)
	if(!((ax == 0.0f) && (ay == 0.0f) && (az == 0.0f))) {

		// Normalise accelerometer measurement
		recipNorm = invSqrt(ax * ax + ay * ay + az * az);
		ax *= recipNorm;
		ay *= recipNorm;
		az *= recipNorm;

		// Estimated direction of gravity
		halfvx = qx * qz - qw * qy;
		halfvy = qw * qx + qy * qz;
		halfvz = qw*qw + qz*qz - 0.5f;  //=1.0-(x*x+y*y)-0.5=0.5-(x*x+y*y)

		// Error is sum of cross product between estimated
		// and measured direction of gravity
		halfex = (ay * halfvz - az * halfvy);
		halfey = (az * halfvx - ax * halfvz);
		halfez = (ax * halfvy - ay * halfvx);

		// Compute and apply integral feedback if enabled
		if(twoKi > 0.0f) {
			// integral error scaled by Ki
			integralx += twoKi * halfex * deltaT;;
			integraly += twoKi * halfey * deltaT;;
			integralz += twoKi * halfez * deltaT;;
			gx += integralx;	// apply integral feedback
			gy += integraly;
			gz += integralz;
		} else {
			integralx = 0.0f;	// prevent integral windup
			integraly = 0.0f;
			integralz = 0.0f;
		}

		// Apply proportional feedback
		gx += twoKp * halfex;
		gy += twoKp * halfey;
		gz += twoKp * halfez;
	}

	// Integrate rate of change of quaternion
	gx *= (0.5f * deltaT);		// pre-multiply common factors
	gy *= (0.5f * deltaT);
	gz *= (0.5f * deltaT);

	float pw = qw;
	float px = qx;
	float py = qy;
	float pz = qz;
	qx += (  0 * px +gz * py -gy * pz +gx * pw);
	qy += (-gz * px + 0 * py +gx * pz +gy * pw);
	qz += ( gy * px -gx * py + 0 * px +gz * pw);
	qw += (-gx * px -gy * py -gz * pz + 0 * pw);

	// Normalise quaternion
	recipNorm = invSqrt(qw * qw + qx * qx + qy * qy + qz * qz);
	qw *= recipNorm;
	qx *= recipNorm;
	qy *= recipNorm;
	qz *= recipNorm;
}
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




void setup()
{
  Serial.begin(115200);
  Wire.begin(18, 17);  //SCL = 17, SDA = 18
  mpu.initialize(ACCEL_FS::A2G, GYRO_FS::G1000DPS);

  qx = qy = qz = 0.0;
  qw = 1.0;
  integralx = integraly = integralz = 0.0;
  oldtime = millis();
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
  mahonyupdate6(fgx, fgy, fgz, fax, fay, faz);
  printf("q=(%f,%f,%f,%f)\n", qx, qy, qz, qw);
/*
  float rq[4];
  float e[3];
  rq[0] = qx;
  rq[1] = qy;
  rq[2] = qz;
  rq[3] = qw;
  quaternion2eulerian(rq, e);
  printf("e=(%f,%f,%f)\n", e[0], e[1], e[2]);
*/
  //printf("a=(%f,%f,%f) x=(%f,%f,%f)\n", fax, fay, faz, qx * qz - qw * qy, qw * qx + qy * qz, qw*qw + qz*qz - 0.5f);
}
