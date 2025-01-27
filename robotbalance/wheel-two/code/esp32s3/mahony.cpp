
//origin code: https://github.com/PaulStoffregen/MahonyAHRS
//axis system: east-north-sky, right-front-top
//
#define twoKp 1.0
#define twoKi 0.01
//
static float q[4];
#define qx q[0]
#define qy q[1]
#define qz q[2]
#define qw q[3]
//
static float integralx, integraly, integralz;




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




void mahony_update6(
	float gx, float gy, float gz,
	float ax, float ay, float az,
  float deltaT)
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
		halfvx = (qx * qz - qw * qy);
		halfvy = (qw * qx + qy * qz);
		halfvz = (qw*qw + qz*qz - 0.5);  //=1.0-(x*x+y*y)-0.5=0.5-(x*x+y*y)

		// Error = cross(estimated_grav_dir, measured_grav_dir)
		halfex = (halfvy * az - halfvz * ay);
		halfey = (halfvz * ax - halfvx * az);
		halfez = (halfvx * ay - halfvy * ax);

		// Compute and apply integral feedback if enabled
		if(twoKi > 0.0f) {
			// integral error scaled by Ki
			integralx += twoKi * halfex * deltaT;
			integraly += twoKi * halfey * deltaT;
			integralz += twoKi * halfez * deltaT;
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
void mahony_getq(float* o)
{
  o[0] = qx;
  o[1] = qy;
  o[2] = qz;
  o[3] = qw;
}
void mahony_init()
{
  qx = qy = qz = 0.0;
  qw = 1.0;

  integralx = integraly = integralz = 0.0;
}