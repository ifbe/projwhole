#include "mywifi.h"
#include "myble.h"
#include <Wire.h>
#include <MPU6050.h>
#include "mahony.h"
#include "planner.h"
#include "actuator.h"

MPU6050 mpu;
unsigned long oldtime;
float deltaT;




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

  float a1 = analogRead(1) * 3.3 / 4096;
  float a2 = analogRead(2) * 3.3 / 4096;
  //Serial.printf("v1=%f v2=%f\n", a1, a2);

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
/*
  float e[3];
  quaternion2eulerian(q, e);
  printf("%f,%f,%f\n", e[0], e[1], e[2]);
*/
  float vec[4];
  computeforce(q, vec);

  //Serial.printf("%f,%f,%f,%f\n", vec[0], vec[1], vec[2], vec[3]);
  val2led(vec[1]*90*2/PI);

  pollwifi();
  pollble();
}

void setup()
{
  //led.init();   //no need

  Serial.begin(115200);

  initwifi();

  initble();

  pinMode(1, INPUT);
  pinMode(2, INPUT);

  Wire.begin(18, 17);  //SCL = 17, SDA = 18

  mpu.initialize(ACCEL_FS::A2G, GYRO_FS::G1000DPS);

  mahony_init();

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