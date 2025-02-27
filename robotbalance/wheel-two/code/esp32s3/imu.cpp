
#include <Arduino.h>
#include <Wire.h>
#include "config.h"



#if IMUTYPE_SELECT==IMUTYPE_MPU6050
#include <MPU6050.h>
MPU6050 mpu;
float bias_gx = 0;
float bias_gy = 0;
float bias_gz = 0;
void imu_read(float* gyr, float* acc)
{
  int16_t ax, ay, az, gx, gy, gz;
  mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
  //Serial.printf("raw: a=(%d,%d,%d) g=(%d,%d,%d) t=%d\n", ax,ay,az, gx,gy,gz, ms);

  gyr[0] = (gx-bias_gx) * (1000.0 / 32768) * PI / 180;   //bug_to_raw * raw_to_deg * deg_to_rad
  gyr[1] = (gy-bias_gy) * (1000.0 / 32768) * PI / 180;
  gyr[2] = (gz-bias_gz) * (1000.0 / 32768) * PI / 180;

  acc[0] = (-2*ax) * 2.0 / 32768;    //bug_to_raw * raw_to_howmanyg
  acc[1] = (-2*ay) * 2.0 / 32768;
  acc[2] = (-2*az) * 2.0 / 32768;
  //Serial.printf("std: a=(%f,%f,%f) g=(%f,%f,%f) t=%d\n", fax,fay,faz, fgx,fgy,fgz, ms);
}
void imu_init()
{
  Wire.begin(pin_sda, pin_scl);  //SCL = 17, SDA = 18

  mpu.initialize(ACCEL_FS::A2G, GYRO_FS::G1000DPS);

  if(mpu.testConnection() ==  false){
    Serial.println("MPU6050 connection failed");
    while(true);
  }

#if 0
  while(true){
    bias_gx = bias_gy = bias_gz = 0;
    int j;
    for(j=0;j<1000;j++){
      int16_t ax, ay, az, gx, gy, gz;
      mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
      bias_gx += gx;
      bias_gy += gy;
      bias_gz += gz;
    }
    Serial.printf("%d,%d,%d\n", bias_gx, bias_gy, bias_gz);
  }
#else
  bias_gx = 56.5;
  bias_gy = -66.5;
  bias_gz = 14.3;
#endif
}
#endif




#if IMUTYPE_SELECT==IMUTYPE_MPU9250
#include <MPU9250.h>
MPU9250 mpu;
void imu_read(float* gyr, float* acc){
  if (mpu.available()){
    mpu.update_accel_gyro();
    mpu.update_mag();
  }

  float mag[3];
  gyr[0] = mpu.getGyroX() * PI / 180;
  gyr[1] = mpu.getGyroY() * PI / 180;
  gyr[2] = mpu.getGyroZ() * PI / 180;
  acc[0] =-mpu.getAccX();
  acc[1] =-mpu.getAccY();
  acc[2] =-mpu.getAccZ();
  mag[0] = mpu.getMagX();
  mag[1] = mpu.getMagY();
  mag[2] = mpu.getMagZ();
  //Serial.printf("%f,%f,%f : %f,%f,%f : %f,%f,%f\n", gyr[0], gyr[1], gyr[2], acc[0], acc[1], acc[2], mag[0], mag[1], mag[2]);
}
void imu_init() {
  Wire.begin(pin_sda, pin_scl);

  if (!mpu.setup(0x68)) {
      while (1) {
          Serial.println("MPU connection failed. Please check your connection with `connection_check` example.");
          delay(5000);
      }
  }
}
/*
#include <MPU6050.h>
MPU6050 mpu;
float bias_gx = 0;
float bias_gy = 0;
float bias_gz = 0;
void imu_read(float* gyr, float* acc)
{
  int16_t ax, ay, az, gx, gy, gz;
  mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
  //Serial.printf("raw: a=(%d,%d,%d) g=(%d,%d,%d) t=%d\n", ax,ay,az, gx,gy,gz, ms);

  gyr[0] = (gx-bias_gx) * (1000.0 / 32768) * PI / 180;   //bug_to_raw * raw_to_deg * deg_to_rad
  gyr[1] = (gy-bias_gy) * (1000.0 / 32768) * PI / 180;
  gyr[2] = (gz-bias_gz) * (1000.0 / 32768) * PI / 180;

  acc[0] = (-2*ax) * 2.0 / 32768;    //bug_to_raw * raw_to_howmanyg
  acc[1] = (-2*ay) * 2.0 / 32768;
  acc[2] = (-2*az) * 2.0 / 32768;
  //Serial.printf("std: a=(%f,%f,%f) g=(%f,%f,%f) t=%d\n", fax,fay,faz, fgx,fgy,fgz, ms);
}
void imu_init()
{
  Wire.begin(pin_sda, pin_scl);  //SCL = 17, SDA = 18

  mpu.initialize(ACCEL_FS::A2G, GYRO_FS::G1000DPS);

  bias_gx = 0;
  bias_gy = 0;
  bias_gz = 0;
}
*/
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
    while(true);
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
#include "SparkFun_BMI270_Arduino_Library.h"
BMI270 imu;
uint8_t i2cAddress = BMI2_I2C_PRIM_ADDR; // 0x68
//uint8_t i2cAddress = BMI2_I2C_SEC_ADDR; // 0x69
void imu_init()
{
  pinMode(pin_ad0, OUTPUT);
  digitalWrite(pin_ad0, 0);

  Wire.begin(pin_sda, pin_scl);

  while(imu.beginI2C(i2cAddress) != BMI2_OK)
  {
      // Not connected, inform user
      Serial.println("Error: BMI270 not connected, check wiring and I2C address!");

      // Wait a bit to see if connection is established
      delay(1000);
  }

  Serial.println("BMI270 connected!");
}
void imu_read(float* gyr, float* acc)
{
  imu.getSensorData();

  gyr[0] = imu.data.gyroX * PI / 180;
  gyr[1] = imu.data.gyroY * PI / 180;
  gyr[2] = imu.data.gyroZ * PI / 180;

  acc[0] = - imu.data.accelX;
  acc[1] = - imu.data.accelY;
  acc[2] = - imu.data.accelZ;
}
#endif
