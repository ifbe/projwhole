
void computeeulerian(float* q, float* v);
void computeangular(float* i, float* o);

void computepid(float* angle, float* angular, float* out, long ms);

void planner_yawring_getpid(float* pid);
void planner_yawring_setpid(float* pid);

void planner_pitchring_getpid(float* pid);
void planner_pitchring_setpid(float* pid);
void planner_pitchring_getbias(float* bias);
void planner_pitchring_setbias(float* bias);

void planner_speedring_getpid(float* pid);
void planner_speedring_setpid(float* pid);
void planner_speedring_getilimit(float* ilimit, float* inte);
void planner_speedring_setilimit(float* ilimit);