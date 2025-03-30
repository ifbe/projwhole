#include <ESP32-TWAI-CAN.hpp>
#define CAN_TX 1    //5
#define CAN_RX 2    //4
static uint32_t lastStamp = 0;




#define masterid 0
#define motorid 0x7f

#define CTRL_MODE       0
#define POS_MODE        1
#define SPEED_MODE      2
#define CUR_MODE        3
#define RUN_MODE        0x7005    // 运行模式, uint8, 1字节, 0运控模式,1位置模式，2速度模式，3电流模式
#define IQ_REF          0x7006    // 电流模式 Iq 指令, float, 4字节, -23~23A
#define SPD_REF         0x700A    // 转速模式转速指令, float, 4字节, -30~30rad/s
#define LIMIT_TORQUE    0x700B    // 转矩限制, float, 4字节, 0~12Nm
#define CUR_KP          0x7010    // 电流的 Kp, float, 4字节, 默认值 0.125
#define CUR_KI          0x7011    // 电流的 Ki, float, 4字节, 默认值 0.0158
#define CUR_FILT_GAIN   0x7014    // 电流滤波系数 filt_gain, float, 4字节, 0~1.0，默认值 0.1
#define LOC_REF         0x7016    // 位置模式角度指令, float, 4字节, rad
#define LIMIT_SPD       0x7017    // 位置模式速度限制, float, 4字节, 0~30rad/s
#define LIMIT_CUR       0x7018    // 速度位置模式电流限制, float, 4字节, 0~23A
#define MECH_POS        0x7019    // 负载端计圈机械角度, float, 4字节, rad, 只读
#define IQF             0x701A    // iq 滤波值, float, 4字节, -23~23A, 只读
#define MECH_VEL        0x701B    // 负载端转速, float, 4字节, -30~30rad/s, 只读
#define VBUS            0x701C    // 母线电压, float, 4字节, V, 只读
#define ROTATION        0x701D    // 圈数, int16, 2字节, 圈数, 可读写
#define LOC_KP          0x701E    // 位置的 kp, float, 4字节, 默认值 30, 可读写
#define SPD_KP          0x701F    // 速度的 kp, float, 4字节, 默认值 1, 可读写
#define SPD_KI          0x7020    // 速度的 ki, float, 4字节, 默认值 0.002, 可读写

//控制命令宏定义，与说明书对应
#define Communication_Type_GetID 0x00               //获取设备的ID和64位MCU唯一标识符
#define Communication_Type_MotionControl 0x01 	    //用来向主机发送控制指令
#define Communication_Type_MotorRequest 0x02	      //用来向主机反馈电机运行状态
#define Communication_Type_MotorEnable 0x03	        //电机使能运行
#define Communication_Type_MotorStop 0x04	          //电机停止运行
#define Communication_Type_SetPosZero 0x06	        //设置电机机械零位
#define Communication_Type_CanID 0x07	              //更改当前电机CAN_ID
#define Communication_Type_GetSingleParameter 0x11	//读取单个参数
#define Communication_Type_Control_Mode 0x12
#define Communication_Type_SetSingleParameter 0x12	//设定单个参数
#define Communication_Type_ErrorFeedback 0x15	      //故障反馈帧

void getid() {
  CanFrame pkt;
	for(int j=0;j<8;j++)pkt.data[8] = 0;
	pkt.data_length_code = 8;
	pkt.identifier = (Communication_Type_GetID<<24) | (masterid<<8) | motorid;
	pkt.extd = 1;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}

void zeropoint() {
  CanFrame pkt;
	for(int j=0;j<8;j++)pkt.data[8] = 0;
	pkt.data_length_code = 8;
	pkt.identifier = (Communication_Type_SetPosZero<<24) | (masterid<<8) | motorid;
	pkt.extd = 1;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}

void start() {
  CanFrame pkt;
	for(int j=0;j<8;j++)pkt.data[8] = 0;
	pkt.data_length_code = 8;
	pkt.identifier = (Communication_Type_MotorEnable<<24) | (masterid<<8) | motorid;
	pkt.extd = 1;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}

void stop() {
  CanFrame pkt;
	for(int j=0;j<8;j++)pkt.data[8] = 0;
	pkt.data_length_code = 8;
	pkt.identifier = (Communication_Type_MotorStop<<24) | (masterid<<8) | motorid;
	pkt.extd = 1;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}


void setmode(int mode)
{
	CanFrame pkt;
	for(int j=0;j<8;j++)pkt.data[8] = 0;
	pkt.data[0] = RUN_MODE&0xff;
	pkt.data[1] = RUN_MODE>>8;
	pkt.data[4] = mode;
	pkt.identifier = (Communication_Type_SetSingleParameter<<24) | (masterid<<8) | motorid;
	pkt.extd = 1;
  ESP32Can.writeFrame(pkt);
}
void Set_Motor_Parameter(uint16_t Index,float Ref)
{
	CanFrame pkt;
	for(int j=0;j<8;j++)pkt.data[8] = 0;
	memcpy(&pkt.data[0],&Index, 2);
	memcpy(&pkt.data[4],&Ref,4);
	pkt.identifier = (Communication_Type_SetSingleParameter<<24) | (masterid<<8) | motorid;
	pkt.extd = 1;
  ESP32Can.writeFrame(pkt);
}

void testsend()
{
  uint32_t currentStamp = millis();
  if(currentStamp < lastStamp + 1000)return;
  lastStamp = currentStamp;

}
void readcan()
{
  CanFrame pkt;
  if(ESP32Can.readFrame(pkt, 0)) {
    char str[64] = {0};
    int tmp = 0;
    for(int j=0;j<pkt.data_length_code;j++)tmp += snprintf(str+tmp, 32-tmp, "%02x%c", pkt.data[j], (j+1<pkt.data_length_code) ? ' ' : '\0');
    Serial.printf("recv %08x : %s\n", pkt.identifier, str);
  }
}



int str2float(char* str, float* f){
  if( ((str[0]>='0') && (str[0]<='9')) || (str[0]=='-') ){
    *f = atof(str);
    return 1;
  }
  return 0;
}
void parsecmd(char* key, float val)
{
  if(strncmp(key, "mode", 4)==0){
    int mode = int(val+0.1);
    setmode(mode);
  }
  else if(strncmp(key, "zero", 4)==0){
    zeropoint();
  }
  else if(strncmp(key, "position", 4)==0){
    Serial.printf("(cmd)position = %f\n", val);

    setmode(POS_MODE);
    start();

    Set_Motor_Parameter(LIMIT_SPD, PI*2);

	  Set_Motor_Parameter(LOC_REF, val);
  }
  else if(strncmp(key, "speed", 5)==0){
    Serial.printf("(cmd)speed = %f\n", val);

    setmode(SPEED_MODE);
    start();

    Set_Motor_Parameter(LIMIT_CUR, 1);

	  Set_Motor_Parameter(SPD_REF, val);
  }
}
void parsestr(char* str){
  int j,ret;
  float val;
  for(j=0;j<64;j++){
    if(str[j]==':'){
    }
    if(str[j]==' '){
      ret = str2float(str+j+1, &val);
      if(ret <=0 )continue;

      Serial.printf("(parse)%.*s : %f\n", j,str, val);
      parsecmd(str, val);
      break;
    }
  }
}
void readserial(){
  int remain = Serial.available();
  if(remain <= 0)return;

  char dat;
  char str[64] = {0};
  int j;
  for(j=0;j<remain;j++){
    dat = Serial.read();
    if(j>=63)continue;
    str[j] = dat;
  }
  if(j<63)str[j] = 0;
  else str[63] = 0;

  Serial.printf("(read)%s",str);
  if(strncmp(str, "getid", 5)==0){
    getid();
  }
  else if(strncmp(str, "start", 5)==0){
    start();
  }
  else if(strncmp(str, "stop", 4)==0){
    stop();
  }

  parsestr(str);
}


void loop() {
  readserial();

  readcan();

  testsend();
}
void setup() {
  // Setup serial for debbuging.
  Serial.begin(115200);

  // Set pins
	ESP32Can.setPins(CAN_TX, CAN_RX);

  // You can set custom size for the queues - those are default
  ESP32Can.setRxQueueSize(50);
	ESP32Can.setTxQueueSize(50);

  // .setSpeed() and .begin() functions require to use TwaiSpeed enum,
  // but you can easily convert it from numerical value using .convertSpeed()
  ESP32Can.setSpeed(ESP32Can.convertSpeed(1000));

  // You can also just use .begin()..
  if(ESP32Can.begin()) {
    Serial.println("CAN bus started!");
  } else {
    Serial.println("CAN bus failed!");
  }

  getid();

  zeropoint();

  int mode = POS_MODE;
  switch(mode){
  case CTRL_MODE:       //0
    setmode(CTRL_MODE);
    start();
    break;
  case POS_MODE:        //1
    setmode(POS_MODE);
    start();
    Set_Motor_Parameter(LIMIT_SPD, PI*2);
	  Set_Motor_Parameter(LOC_REF, PI*2);
    break;
  case SPEED_MODE:      //2
    setmode(SPEED_MODE);
    start();
    Set_Motor_Parameter(LIMIT_CUR, 1);
    Set_Motor_Parameter(SPD_REF, PI);
    break;
  case CUR_MODE:        //3
    setmode(CUR_MODE);
    start();
    Set_Motor_Parameter(IQ_REF, PI);
    break;
  }
}
