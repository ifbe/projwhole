
void mahony_init();

void mahony_getq(float* q);

void mahony_update6(
	float gx, float gy, float gz,
	float ax, float ay, float az,
  float deltaT);