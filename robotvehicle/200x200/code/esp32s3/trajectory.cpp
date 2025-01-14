#include <math.h>
void quaternion_multiplyfrom(float* o, float* l, float* r)
{
	o[0] = l[0]*r[3] + l[3]*r[0] + l[1]*r[2] - l[2]*r[1];
	o[1] = l[1]*r[3] + l[3]*r[1] + l[2]*r[0] - l[0]*r[2];
	o[2] = l[2]*r[3] + l[3]*r[2] + l[0]*r[1] - l[1]*r[0];
	o[3] = l[3]*r[3] - l[0]*r[0] - l[1]*r[1] - l[2]*r[2];
}

void quaternion2axismulangle(float* q, float* a)
{
	float l,t;

	l = q[0]*q[0] + q[1]*q[1] + q[2]*q[2];
	if(l < 1e-12){
		a[0] = 0.0;
		a[1] = 0.0;
		a[2] = 1.0;
	}
	else{
		l = sqrt(l);
		t = 2.0 * atan2(l, q[3]) / l;
		a[0] = q[0] * t;
		a[1] = q[1] * t;
		a[2] = q[2] * t;
	}
}

void computeforce(float* q, float* vec)
{
  //diff*q = want => diff = want*(q^-1)
  float diff[4];
  float want[4] = {0,0,0,1};
  float inv[4] = {-q[0], -q[1], -q[2], q[3]};
  quaternion_multiplyfrom(diff, want, inv);

  quaternion2axismulangle(diff, vec);
}