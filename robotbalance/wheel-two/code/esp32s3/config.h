
#define IMUTYPE_MPU6050 1
#define IMUTYPE_MPU9250 2
#define IMUTYPE_BMI270 3
#define IMUTYPE_ICM42688 4

#define MOTORTYPE_DRV8833 1 //tt motor
#define MOTORTYPE_DRV8825 2 //stepper motor
#define MOTORTYPE_DRV8301 3 //bldc motor

#define BATTTYPE_2S 2
#define BATTTYPE_4S 4

#define ROBOT_TEST 0
#define ROBOT_TTMOTOR 1
#define ROBOT_STEPPERMOTOR 2
#define ROBOT_BLDCMOTOR 3

/*
dont use:
0=boot
19=d-
20=d+
45=io
48=led
*/




//project select
#define ROBOT_SELECT ROBOT_TEST

#if ROBOT_SELECT==ROBOT_TTMOTOR
#define BOARDNAME "esp32s3_muselab"
#define SENSORINBODYSPACE {0, 0, 0.7071067811865476, 0.7071067811865476}
#define IMUTYPE_SELECT IMUTYPE_MPU6050
#define MOTORTYPE_SELECT MOTORTYPE_DRV8833
#define BATTTYPE_SELECT BATTTYPE_2S
#endif
#if ROBOT_SELECT==ROBOT_STEPPERMOTOR
#define BOARDNAME "esp32s3_weact"
#define SENSORINBODYSPACE {0, 0, 0, 1}
#define IMUTYPE_SELECT IMUTYPE_ICM42688
#define MOTORTYPE_SELECT MOTORTYPE_DRV8825
#define BATTTYPE_SELECT BATTTYPE_4S
#endif
#if ROBOT_SELECT==ROBOT_BLDCMOTOR
#define BOARDNAME "esp32s3_vcc-gnd"
#define SENSORINBODYSPACE {0, 0, -0.7071067811865476, 0.7071067811865476}
#define IMUTYPE_SELECT IMUTYPE_BMI270
#define MOTORTYPE_SELECT MOTORTYPE_DRV8301
#define BATTTYPE_SELECT BATTTYPE_4S
#endif
#if ROBOT_SELECT==ROBOT_TEST
#define BOARDNAME "esp32s3_telesky"
#define SENSORINBODYSPACE {0, 0, -0.7071067811865476, 0.7071067811865476}
#define IMUTYPE_SELECT IMUTYPE_MPU9250
#define MOTORTYPE_SELECT MOTORTYPE_DRV8301
#define BATTTYPE_SELECT BATTTYPE_4S
#endif




//select1: imu
#if IMUTYPE_SELECT==IMUTYPE_MPU6050
#define pin_sda 18
#define pin_scl 17
#endif

#if IMUTYPE_SELECT==IMUTYPE_MPU9250
#define pin_sda 36
#define pin_scl 35
#endif

#if IMUTYPE_SELECT==IMUTYPE_ICM42688
#define pin_ad0 15
#define pin_sda 16
#define pin_scl 17
#define pin_cs 18
#define pin_int1 8
#define pin_int2 3
#endif

#if IMUTYPE_SELECT==IMUTYPE_BMI270
#define pin_ad0 35
#define pin_sda 36
#define pin_scl 37
#define pin_cs 38
#define pin_int1 39
#define pin_int2 40
#endif




//select2: motor
#if MOTORTYPE_SELECT==MOTORTYPE_DRV8833
#define PIN_LEFT_P 39
#define PIN_LEFT_N 40
#define PIN_LEFT_EN 41
#define PIN_RIGHT_P 9
#define PIN_RIGHT_N 10
#define PIN_RIGHT_EN 11
#endif

#if MOTORTYPE_SELECT==MOTORTYPE_DRV8825
#define PIN_LEFT_EN 35
#define PIN_LEFT_M0 36
#define PIN_LEFT_M1 37
#define PIN_LEFT_M2 38
#define PIN_LEFT_RST 39
#define PIN_LEFT_SLP 40
#define PIN_LEFT_STEP 41
#define PIN_LEFT_DIR 42
#define PIN_RIGHT_EN 47
#define PIN_RIGHT_M0 21
#define PIN_RIGHT_M1 14
#define PIN_RIGHT_M2 13
#define PIN_RIGHT_RST 12
#define PIN_RIGHT_SLP 11
#define PIN_RIGHT_STEP 10
#define PIN_RIGHT_DIR 9
#endif

#if MOTORTYPE_SELECT==MOTORTYPE_DRV8825
#endif




//select3: battery
#if BATTTYPE_SELECT==BATTTYPE_2S
#define PIN_VOLT1 1
#define PIN_VOLT2 2
#define r1_up  50000  //50k
#define r1_dn 100000  //100k  //4.2*100/150=2.8
#define r2_up 100000  //100k
#define r2_dn  50000  //50k   //8.4*50/150=2.8
#endif

#if BATTTYPE_SELECT==BATTTYPE_4S
#define PIN_VOLT1 7
#define PIN_VOLT2 6
#define PIN_VOLT3 5
#define PIN_VOLT4 4
#define r1_up  50000  //50k
#define r1_dn 100000  //100k  //4.2*100/150=2.8
#define r2_up 100000  //100k
#define r2_dn  50000  //50k   //8.4*50/150=2.8
#define r3_up 100000  //100k
#define r3_dn  25000  //two 50k in parallel //12.6*25/125=2.52
#define r4_up 100000  //100k
#define r4_dn  16666  //three 50k in parallel //16.8*16666/(100+16666)=2.4
#endif