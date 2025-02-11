#include "config.h"
#include <Wire.h>




#if IMUTYPE_SELECT==IMUTYPE_MPU6050
#include <MPU6050.h>
MPU6050 mpu;
void imu_init()
{
  Wire.begin(pin_sda, pin_scl);  //SCL = 17, SDA = 18

  mpu.initialize(ACCEL_FS::A2G, GYRO_FS::G1000DPS);
}
void imu_read(float* gyr, float* acc)
{
  int16_t ax, ay, az, gx, gy, gz;
  mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
  //Serial.printf("raw: a=(%d,%d,%d) g=(%d,%d,%d) t=%d\n", ax,ay,az, gx,gy,gz, ms);

  gyr[0] = (gx) * (1000.0 / 32768) * PI / 180;   //bug_to_raw * raw_to_deg * deg_to_rad
  gyr[1] = (gy) * (1000.0 / 32768) * PI / 180;
  gyr[2] = (gz) * (1000.0 / 32768) * PI / 180;

  acc[0] = (-2*ax) * 2.0 / 32768;    //bug_to_raw * raw_to_howmanyg
  acc[1] = (-2*ay) * 2.0 / 32768;
  acc[2] = (-2*az) * 2.0 / 32768;
  //Serial.printf("std: a=(%f,%f,%f) g=(%f,%f,%f) t=%d\n", fax,fay,faz, fgx,fgy,fgz, ms);
}
#endif




#if IMUTYPE_SELECT==IMUTYPE_ICM42688
#include <ICM42688.h>
ICM42688* imu = 0;
void imu_init()
{
  pinMode(pin_ad0, OUTPUT);
  digitalWrite(pin_ad0, 0);

  Wire.begin(pin_sda, pin_scl);

  imu = new ICM42688(Wire, 0x68);

  int status = imu->begin();
  if (status < 0) {
    Serial.println("IMU initialization unsuccessful");
  }

  // setting the accelerometer full scale range to +/-8G
  imu->setAccelFS(ICM42688::gpm8);
  // setting the gyroscope full scale range to +/-500 deg/s
  imu->setGyroFS(ICM42688::dps500);
}
void imu_read(float* gyr, float* acc)
{
  if(0 == imu)return;

  imu->getAGT();

  float temp = imu->temp();

  gyr[0] = imu->gyrX() * PI / 180;
  gyr[1] = imu->gyrY() * PI / 180;
  gyr[2] = imu->gyrZ() * PI / 180;

  acc[0] = - imu->accX();
  acc[1] = - imu->accY();
  acc[2] = - imu->accZ();

  //Serial.printf("ms=%d temp=%f g=(%f,%f,%f) a=(%f,%f,%f)\n", ms, temp, gyr[0], gyr[1], gyr[2], acc[0], acc[1], acc[2]);
}
#endif




#if IMUTYPE_SELECT==IMUTYPE_BMI270
#endif
