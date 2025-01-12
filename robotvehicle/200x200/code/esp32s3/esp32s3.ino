#include<Wire.h>
#include<MPU6050.h>
MPU6050 mpu;

void setup()
{
  Serial.begin(115200);
  Wire.begin(18, 17);  //SCL = 17, SDA = 18
  mpu.initialize();
}

void loop()
{
  int16_t ax, ay, az, gx, gy, gz;
  mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
  ax = -ax;
  ay = -ay;
  az = -az;

  Serial.printf("a=(%d,%d,%d) g=(%d,%d,%d)\n", ax,ay,az, gx,gy,gz);
}
