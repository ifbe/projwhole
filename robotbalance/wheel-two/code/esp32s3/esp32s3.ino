#include <Wire.h>
#include <MPU6050.h>
#include "mahony.h"
#include "planner.h"
#include "actuator.h"
#include "battery.h"
#include "mywifi.h"
#include "myble.h"

MPU6050 mpu;
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

  float deltaT = (ms-oldtime)*0.001;
  oldtime = ms;

  mahony_update6(fgx, fgy, fgz, fax, fay, faz, deltaT);
  if(fusioncount <= 200)fusioncount++;

  float q[4];
  mahony_getq(q);
  //printf("%f,%f,%f,%f\n", q[0], q[1], q[2], q[3]);

  float vec[4];
  computeeulerian(q, vec);
  //Serial.printf("%f,%f,%f\n", vec[0], vec[1], vec[2]);

  radian2degree(vec);
  Serial.printf("%d: %f,%f,%f\n", ms, vec[0], vec[1], vec[2]);

  val2led(vec[1]);

  if(fusioncount >= 200){
    float val[2];
    computepid(vec, val, ms);
    //Serial.printf("%f -> %f,%f\n", vec[1], val[0], val[1]);

    drv8833_output(val[0], val[1]);
  }

  pollbattery();
  pollwifi();
  pollble();
}

void setup()
{
  //let power stable ?
  delay(1000);

  //led.init();   //no need

  Serial.begin(115200);

  initwifi();

  initble();

  initbattery();

  initmotor();

  Wire.begin(18, 17);  //SCL = 17, SDA = 18

  mpu.initialize(ACCEL_FS::A2G, GYRO_FS::G1000DPS);

  mahony_init();

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