#include <Wire.h>
#include <ICM42688.h>

#define pin_ad0 15
#define pin_sda 16
#define pin_scl 17
#define pin_cs 18
#define pin_int1 8
#define pin_int2 3
ICM42688* imu = 0;


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

  if(0 == imu)return;

  imu->getAGT();

  float temp = imu->temp();

  float gyr[3];
  gyr[0] = imu->gyrX();
  gyr[1] = imu->gyrY();
  gyr[2] = imu->gyrZ();

  float acc[3];
  acc[0] = - imu->accX();
  acc[1] = - imu->accY();
  acc[2] = - imu->accZ();

  Serial.printf("ms=%d temp=%f g=(%f,%f,%f) a=(%f,%f,%f)\n", ms, temp, gyr[0], gyr[1], gyr[2], acc[0], acc[1], acc[2]);
  delay(100);
}

void setup()
{
  //led.init();   //no need
  delay(1000);

  Serial.begin(115200);

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
