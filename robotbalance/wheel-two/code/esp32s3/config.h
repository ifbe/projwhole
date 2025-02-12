
#define IMUTYPE_MPU6050 1
#define IMUTYPE_ICM42688 2
#define IMUTYPE_BMI270 3

#define MOTORTYPE_DRV8833 1 //tt motor
#define MOTORTYPE_DRV8825 2 //stepper motor
#define MOTORTYPE_DRV8301 3 //bldc motor

#define BATTTYPE_2S 2
#define BATTTYPE_4S 4

#define ROBOT_TTMOTOR 1
#define ROBOT_STEPPERMOTOR 2
#define ROBOT_BLDCMOTOR 3




//project select
#define ROBOT_SELECT ROBOT_TTMOTOR

#if ROBOT_SELECT==ROBOT_TTMOTOR
#define BOARDNAME "esp32s3_muselab"
#define IMUTYPE_SELECT IMUTYPE_MPU6050
#define MOTORTYPE_SELECT MOTORTYPE_DRV8833
#define BATTTYPE_SELECT BATTTYPE_2S
#endif
#if ROBOT_SELECT==ROBOT_STEPPERMOTOR
#define BOARDNAME "esp32s3_weact"
#define IMUTYPE_SELECT IMUTYPE_ICM42688
#define MOTORTYPE_SELECT MOTORTYPE_DRV8825
#define BATTTYPE_SELECT BATTTYPE_4S
#endif
#if ROBOT_SELECT==ROBOT_BLDCMOTOR
#define BOARDNAME "esp32s3_?????"
#define IMUTYPE_SELECT IMUTYPE_BMI270
#define MOTORTYPE_SELECT MOTORTYPE_DRV8301
#define BATTTYPE_SELECT BATTTYPE_2S
#endif




//select1: imu
#if IMUTYPE_SELECT==IMUTYPE_MPU6050
#define pin_sda 18
#define pin_scl 17
#endif

#if IMUTYPE_SELECT==IMUTYPE_ICM42688
#define pin_ad0 15
#define pin_sda 16
#define pin_scl 17
#define pin_cs 18
#define pin_int1 8
#define pin_int2 3
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
#define PIN_LEFT_0 35
#define PIN_LEFT_1 36
#define PIN_LEFT_2 37
#define PIN_LEFT_3 38
#define PIN_LEFT_4 39
#define PIN_LEFT_5 40
#define PIN_LEFT_6 41
#define PIN_LEFT_7 42
#define PIN_RIGHT_0 9
#define PIN_RIGHT_1 10
#define PIN_RIGHT_2 11
#define PIN_RIGHT_3 12
#define PIN_RIGHT_4 13
#define PIN_RIGHT_5 14
#define PIN_RIGHT_6 19
#define PIN_RIGHT_7 20
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
#define PIN_VOLT1 4
#define PIN_VOLT2 5
#define PIN_VOLT3 6
#define PIN_VOLT4 7
#define r1_up  50000  //50k
#define r1_dn 100000  //100k  //4.2*100/150=2.8
#define r2_up 100000  //100k
#define r2_dn  50000  //50k   //8.4*50/150=2.8
#define r3_up 100000  //100k
#define r3_dn  25000  //two 50k in parallel //12.6*25/125=2.52
#define r4_up 100000  //100k
#define r4_dn  16666  //three 50k in parallel //16.8*16666/(100+16666)=2.4
#endif