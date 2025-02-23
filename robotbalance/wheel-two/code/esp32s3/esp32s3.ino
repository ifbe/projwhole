#include "imu.h"
#include "mahony.h"
#include "planner.h"
#include "actuator.h"
#include "battery.h"
#include "mywifi.h"
#include "myble.h"

static unsigned long oldtime;
static unsigned long fusioncount;




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

void radian2degree(float* vec)
{
  vec[0] *= 180/PI;
  vec[1] *= 180/PI;
  vec[2] *= 180/PI;
}

void loop()
{
  unsigned long ms = millis();
  float deltaT = (ms-oldtime)*0.001;
  //Serial.printf("%f,%f\n", mpu.get_acce_resolution(), mpu.get_gyro_resolution() );
  oldtime = ms;

  float gyr[3];
  float acc[3];
  imu_read(gyr, acc);

  float angular[3];
  computeangular(gyr, angular);

  //{
  mahony_update6(gyr[0], gyr[1], gyr[2], acc[0], acc[1], acc[2], deltaT);
  if(fusioncount <= 200)fusioncount++;

  float q[4];
  mahony_getq(q);
  //printf("%f,%f,%f,%f\n", q[0], q[1], q[2], q[3]);

  float angle[4];
  computeeulerian(q, angle);
  //Serial.printf("%f,%f,%f\n", angle[0], angle[1], angle[2]);

  radian2degree(angle);
  //}

  val2led(angle[0]);  //pitch

  if(fusioncount >= 200){   //&&battery>3.5v
    float val[2];
    computepid(angle, angular, val, ms);
    //Serial.printf("%f -> %f,%f\n", angle[0], val[0], val[1]);

    motor_output(val[0], val[1]);

    Serial.printf("%d : %f,%f,%f : %f,%f,%f : %f,%f\n", ms, angle[0], angle[1], angle[2], angular[0], angular[1], angular[2], val[0], val[1]);
  }
  else{
    Serial.printf("%d : %f,%f,%f : %f,%f,%f\n", ms, angle[0], angle[1], angle[2], angular[0], angular[1], angular[2]);
  }

  battery_poll();
  wifi_poll();
  btble_poll();
}

void setup()
{
  //let power stable ?
  delay(1000);

  //led.init();   //no need

  Serial.begin(115200);

  wifi_init();

  btble_init();

  battery_init();

  motor_init();

  mahony_init();

  imu_init();

  //delay(3000);

  fusioncount = 0;
  oldtime = millis();
}




/*
// 主任务函数（运行在核心0）
void mainTask(void* parameter) {
  // 初始化逻辑（原setup内容）
  Serial.begin(115200);
  Serial.println("Main task running on core " + String(xPortGetCoreID()));

  while (1) {
    // 主循环逻辑（原loop内容）
    Serial.println("Main task loop");
    delay(1000);
  }
}

void otherTask(void* parameter) {
}

void setup() {
  // 创建主任务，绑定到核心0
  xTaskCreatePinnedToCore(
    mainTask,   // 任务函数
    "mainTask", // 任务名称
    10000,      // 堆栈大小
    NULL,       // 任务参数
    1,          // 任务优先级
    NULL,       // 任务句柄
    0           // 核心编号（0或1）
  );

  // 创建WiFi任务，绑定到核心1
  xTaskCreatePinnedToCore(
    otherTask,   // 任务函数
    "otherTask", // 任务名称
    10000,      // 堆栈大小
    NULL,       // 任务参数
    1,          // 任务优先级
    NULL,       // 任务句柄
    1           // 核心编号（0或1）
  );
}

void loop() {
  // 空实现，因为任务逻辑已经在mainTask中
}
*/