#include <ESP32-TWAI-CAN.hpp>

// Simple sketch that querries OBD2 over CAN for coolant temperature
// Showcasing simple use of ESP32-TWAI-CAN library driver.

// Default for ESP32
#define CAN_TX 1    //5
#define CAN_RX 2    //4
static uint32_t lastStamp = 0;
static int enable = 1;
static int runmode = 0;


void print_canid_and_data(uint32_t canid, uint8_t* data)
{
  Serial.printf("%08x:%02x %02x %02x %02x %02x %02x %02x %02x\n", canid,
    data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7]
  );
}



uint8_t oneframe_data[8] = {};
uint32_t oneframe_canid = 0;
char oneframe_en = 0;
void special(){
  if(oneframe_en==0)return;
  Serial.println(__FUNCTION__);

  CanFrame pkt;
  for(int j=0;j<8;j++)pkt.data[j] = oneframe_data[j];
	pkt.data_length_code = 8;
	pkt.extd = 1;
	pkt.identifier = oneframe_canid;
  ESP32Can.writeFrame(pkt);

  print_canid_and_data(pkt.identifier, pkt.data);
  oneframe_en = 0;
}


char test66_type = 3;
char testreq_en = 0;
char testres_en = 0;
void testreq(){
  if(testreq_en==0)return;
  Serial.println(__FUNCTION__);

  CanFrame pkt;
  switch(test66_type){
  case 0:
    pkt.data[0] = 0x10;
    pkt.data[1] = 0x1b;
    pkt.data[2] = 0x2e;
    pkt.data[3] = 0xf1;
    pkt.data[4] = 0xa1;
    break;
  case 1:
    pkt.data[0] = 0x04;
    pkt.data[1] = 0x31;
    pkt.data[2] = 0x01;
    pkt.data[3] = 0x61;
    pkt.data[4] = 0x40;
    break;
  case 2:
    pkt.data[0] = 0x10;
    pkt.data[1] = 0x15;
    pkt.data[2] = 0x2e;
    pkt.data[3] = 0x35;
    pkt.data[4] = 0x01;
    break;
  case 3:
    pkt.data[0] = 0x06;
    pkt.data[1] = 0x31;
    pkt.data[2] = 0x01;
    pkt.data[3] = 0x61;
    pkt.data[4] = 0x41;
    break;
  }
	pkt.data_length_code = 8;
	pkt.extd = 1;
	pkt.identifier = 0x18da21f9;
  ESP32Can.writeFrame(pkt);

  print_canid_and_data(pkt.identifier, pkt.data);
  testreq_en = 0;
}
void testres(){
  if(testres_en==0)return;
  Serial.println(__FUNCTION__);

  CanFrame pkt;
  switch(test66_type){
  case 0:
    pkt.data[0] = 0x03;
    pkt.data[1] = 0x6e;
    pkt.data[2] = 0xf1;
    pkt.data[3] = 0xa1;
    break;
  case 1:
    pkt.data[0] = 0x04;
    pkt.data[1] = 0x71;
    pkt.data[2] = 0x01;
    pkt.data[3] = 0x61;
    pkt.data[4] = 0x40;
    break;
  case 2:
    pkt.data[0] = 0x03;
    pkt.data[1] = 0x6e;
    pkt.data[2] = 0x35;
    pkt.data[3] = 0x01;
    break;
  case 3:
    pkt.data[0] = 0x05;
    pkt.data[1] = 0x71;
    pkt.data[2] = 0x01;
    pkt.data[3] = 0x61;
    pkt.data[4] = 0x41;
    break;
  }
	pkt.data_length_code = 8;
	pkt.extd = 1;
	pkt.identifier = 0x18daf921;
  ESP32Can.writeFrame(pkt);

  print_canid_and_data(pkt.identifier, pkt.data);
  testres_en = 0;
}


uint32_t canid_tacspeed = 0x0cfe6cee;
float m_tacspeed = 0;
static int d_tacspeed = 0;
void builddata_tacspeed(uint8_t* buf, float speed){
  uint16_t val = speed * 256;
  buf[0] = 0;
  buf[1] = 0;
  buf[2] = 0;
  buf[3] = 0;
  buf[4] = 0;
  buf[5] = 0;
  buf[6] = val&0xff;
  buf[7] = val>>8;
}
void buildframe_tacspeed(CanFrame* pkt, float speed){
  builddata_tacspeed(pkt->data, speed);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_tacspeed;
  ESP32Can.writeFrame(pkt);
}
void sendframe_tacspeed(float speed){
  CanFrame pkt;
  buildframe_tacspeed(&pkt, speed+d_tacspeed*0.01);
  //d_tacspeed = (d_tacspeed+1)%3;
  ESP32Can.writeFrame(pkt);
}




uint32_t canid_idleinfo = 0x18FEDC00;
float m_idleliter = 0;
float m_idlesec = 0;
void builddata_idleinfo(uint8_t* buf, float liter, float sec){
  uint32_t lo4 = liter * 2;
  uint32_t hi4 = sec*20/3600;
  buf[0] = lo4 & 0xff;
  buf[1] = (lo4>>8) & 0xff;
  buf[2] = (lo4>>16) & 0xff;
  buf[3] = (lo4>>24) & 0xff;
  buf[4] = hi4 & 0xff;
  buf[5] = (hi4>>8)&0xff;
  buf[6] = (hi4>>16) & 0xff;
  buf[7] = (hi4>>24) & 0xff;
}
void buildframe_idleinfo(CanFrame* pkt, float liter, float sec){
  builddata_idleinfo(pkt->data, liter, sec);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_idleinfo;
  ESP32Can.writeFrame(pkt);
}
void sendframe_idleinfo(float liter, float sec){
  CanFrame pkt;
  buildframe_idleinfo(&pkt, liter, sec);
  ESP32Can.writeFrame(pkt);
}


uint32_t canid_speedclutchbrake = 0x18FEF100;
float m_speed = 0;
int m_handbrake = 0;
int m_brake = 0;    //0=no,1=down,2=err,3=invalid
int m_clutch = 0;
void builddata_speed_brake_clutch(uint8_t* buf, uint8_t hb, float speed, uint8_t brake, uint8_t clutch) {
  uint16_t spd = (uint16_t)(speed*256);
  //Serial.printf("%f, %d\n",speed, spd);
  brake &= 3;
  clutch &= 3;
  hb &= 3;
	buf[0] = hb<<2;
	buf[1] = spd & 0xff;
	buf[2] = spd >> 8;
	buf[3] = (brake<<4) | (clutch<<6);
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_speed_brake_clutch(CanFrame* pkt, uint8_t hb, float speed, uint8_t brake, uint8_t clutch) {
  //Serial.println(speed);
  builddata_speed_brake_clutch(pkt->data, hb, speed, brake, clutch);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_speedclutchbrake;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_speed_brake_clutch(uint8_t hb, float speed, uint8_t brake, uint8_t clutch){
  CanFrame pkt;
  //Serial.println(speed);
  buildframe_speed_brake_clutch(&pkt, hb, speed, brake, clutch);
  ESP32Can.writeFrame(pkt);
}


//
uint32_t canid_oiling = 0x18FEF200;
float m_oil_lh = 0;
float m_oil_kml = 0;
void builddata_oiling(uint8_t* buf, uint32_t oillh, uint32_t oilkml) {
  oillh = oillh*20;
  oilkml = oilkml+125;
	buf[0] = oillh&0xff;
	buf[1] = oillh>>8;
	buf[2] = 0;
	buf[3] = oilkml;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_oiling(CanFrame* pkt, uint32_t oillh, uint32_t oilkml) {
	builddata_oiling(pkt->data, oillh, oilkml);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_oiling;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_oiling(uint32_t oillh, uint32_t oilkml){
  CanFrame pkt;
  buildframe_oiling(&pkt, oillh, oilkml);
  ESP32Can.writeFrame(pkt);
}


//
uint32_t canid_oilsum = 0x18FEE900;
int m_oilsum = 0;
void builddata_oilsum(uint8_t* buf, uint32_t oilsum) {
  oilsum = oilsum*2;
	buf[0] = 0;
	buf[1] = 0;
	buf[2] = 0;
	buf[3] = 0;
	buf[4] = oilsum&0xff;
	buf[5] = oilsum>>8;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_oilsum(CanFrame* pkt, uint32_t oilsum) {
  builddata_oilsum(pkt->data, oilsum);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_oilsum;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_oilsum(uint32_t oilsum){
  CanFrame pkt;
  buildframe_oilsum(&pkt, oilsum);
  ESP32Can.writeFrame(pkt);
}


//
uint32_t canid_mileage = 0x18FEC1EE;
int m_mileage = 0;
void builddata_mileage(uint8_t* buf, uint32_t mileage){
  mileage = mileage*200;
	buf[0] = mileage&0xff;
	buf[1] = mileage>>8;
	buf[2] = mileage>>16;
	buf[3] = mileage>>32;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_mileage(CanFrame* pkt, uint32_t mileage) {
  builddata_mileage(pkt->data, mileage);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_mileage;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_mileage(uint32_t mileage){
  CanFrame pkt;
  buildframe_mileage(&pkt, mileage);
  ESP32Can.writeFrame(pkt);
}


//
uint32_t canid_gear = 0x18F00503;
int m_gear = 0;
void builddata_gear(uint8_t* buf, uint16_t gear) {
  gear = gear+125;
	buf[0] = 0;
	buf[1] = 0;
	buf[2] = 0;
	buf[3] = gear;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_gear(CanFrame* pkt, uint16_t gear) {
  builddata_gear(pkt->data, gear);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_gear;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_gear(uint16_t gear){
  CanFrame pkt;
  buildframe_gear(&pkt, gear);
  ESP32Can.writeFrame(pkt);
}


//
uint32_t canid_nox = 0x18F00f00;
float m_nox = 0;
void builddata_nox(uint8_t* buf, uint32_t nox) {
  nox = (nox+200)*20;
	buf[0] = nox & 0xff;
	buf[1] = nox >> 8;
	buf[2] = 0;
	buf[3] = 0;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_nox(CanFrame* pkt, uint32_t nox) {
  builddata_nox(pkt->data, nox);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_nox;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_nox(uint32_t nox){
  CanFrame pkt;
  buildframe_nox(&pkt, nox);
  ESP32Can.writeFrame(pkt);
}


//
uint32_t canid_coolant = 0x18FEEE00;
float m_coolant = 0;
void builddata_coolant(uint8_t* buf, uint32_t temp) {
  temp = temp+40;
	buf[0] = temp;
	buf[1] = 0;
	buf[2] = 0;
	buf[3] = 0;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_coolant(CanFrame* pkt, uint32_t temp) {
  builddata_coolant(pkt->data, temp);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_coolant;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_coolant(uint32_t temp){
  CanFrame pkt;
  buildframe_coolant(&pkt, temp);
  ESP32Can.writeFrame(pkt);
}


//
uint32_t canid_slope = 0x0CF01303;
float m_slope = 0;
void builddata_slope(uint8_t* buf, float slope) {
  uint32_t val = (slope+64)*500;
	buf[0] = val&0xff;
	buf[1] = val>>8;
	buf[2] = 0;
	buf[3] = 0;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_slope(CanFrame* pkt, float slope) {
  builddata_slope(pkt->data, slope);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_slope;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_slope(float slope){
  CanFrame pkt;
  buildframe_slope(&pkt, slope);
  ESP32Can.writeFrame(pkt);
}


//
uint32_t canid_turn = 0x18F0090B;
float m_turn = 0;
void builddata_turn(uint8_t* buf, float turn) {
  turn = turn*3.141592653/180;
  uint32_t val = (turn+31.374)/0.0009765625;
	buf[0] = val&0xff;
	buf[1] = val>>8;
	buf[2] = 0;
	buf[3] = 0;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_turn(CanFrame* pkt, float turn) {
  builddata_turn(pkt->data, turn);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_turn;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_turn(float turn){
  CanFrame pkt;
  buildframe_turn(&pkt, turn);
  ESP32Can.writeFrame(pkt);
}


//0x18FD6800
uint32_t canid_loadkg = 0x18FE7003;
float m_loadkg = 0;
void builddata_load(uint8_t* buf, uint32_t loadkg) {
  loadkg = loadkg / 250;
	buf[0] = 0;
	buf[1] = 0;
	buf[2] = loadkg&0xff;
	buf[3] = loadkg>>8;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_load(CanFrame* pkt, uint32_t loadkg) {
  builddata_load(pkt->data, loadkg);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_loadkg;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_load(uint32_t load){
  CanFrame pkt;
  buildframe_load(&pkt, load);
  ESP32Can.writeFrame(pkt);
}


//
uint32_t canid_accpedalloadrate = 0x0CF00300;
float m_accpedal = 0;
float m_loadrate = 0;
void builddata_accpedal_loadrate(uint8_t* buf, uint16_t accpedal, uint16_t loadrate) {
  accpedal = accpedal * 2.5;
	buf[0] = 0;
	buf[1] = accpedal;
	buf[2] = loadrate;
	buf[3] = 0;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_accpedal_loadrate(CanFrame* pkt, uint16_t accpedal, uint16_t loadrate) {
  builddata_accpedal_loadrate(pkt->data, accpedal, loadrate);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_accpedalloadrate;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_accpedal_loadrate(uint16_t accpedal, uint16_t loadrate){
  CanFrame pkt;
  buildframe_accpedal_loadrate(&pkt, accpedal, loadrate);
  ESP32Can.writeFrame(pkt);
}


//
uint32_t canid_torquerpm = 0x0CF00400;
float m_torquemode = 0;
float m_torquepercent = 0;
float m_rpm = 0;
void builddata_torquemode_torquepercent_rpm(uint8_t* buf, uint8_t torquemode, uint8_t torquepercent, uint32_t rpm)
{
  torquepercent = torquepercent+125;
  rpm = rpm*8;
	buf[0] = torquemode;
	buf[1] = 0;
	buf[2] = torquepercent;
	buf[3] = rpm & 0xff;
	buf[4] = rpm >> 8;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_torquemode_torquepercent_rpm(CanFrame* pkt, uint8_t torquemode, uint8_t torquepercent, uint32_t rpm) {
  builddata_torquemode_torquepercent_rpm(pkt->data, torquemode, torquepercent, rpm);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_torquerpm;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_torquemode_torquepercent_rpm(uint8_t torquemode, uint8_t torquepercent, uint32_t rpm){
  CanFrame pkt;
  buildframe_torquemode_torquepercent_rpm(&pkt, torquemode, torquepercent, rpm);
  ESP32Can.writeFrame(pkt);
}




uint32_t canid_frictionpercent = 0x18fedf00;
float m_frictionpercent = 0;
void builddata_frictionpercent(uint8_t* buf, uint8_t frictionpercent) {
  frictionpercent = frictionpercent+125;
	buf[0] = frictionpercent;
	buf[1] = 0;
	buf[2] = 0;
	buf[3] = 0;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_frictionpercent(CanFrame* pkt, uint8_t frictionpercent) {
  builddata_frictionpercent(pkt->data, frictionpercent);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_frictionpercent;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_frictionpercent(uint8_t torquepercent){
  CanFrame pkt;
  buildframe_frictionpercent(&pkt, m_frictionpercent);
  ESP32Can.writeFrame(pkt);
}




uint32_t canid_belt = 0x0CFF0817;
int m_belt = 0;
void builddata_belt(uint8_t* buf, uint8_t belt) {
  belt &= 3;
	buf[0] = 0;
	buf[1] = 0;
	buf[2] = belt<<6;
	buf[3] = 0;
	buf[4] = 0;
	buf[5] = 0;
	buf[6] = 0;
	buf[7] = 0;
}
void buildframe_belt(CanFrame* pkt, uint8_t belt) {
  builddata_belt(pkt->data, belt);
	pkt->data_length_code = 8;
	pkt->extd = 1;
	pkt->identifier = canid_belt;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void sendframe_belt(uint8_t belt){
  CanFrame pkt;
  buildframe_belt(&pkt, belt);
  ESP32Can.writeFrame(pkt);
}


void send_inputcmd()
{
  uint32_t currentStamp = millis();
  if(currentStamp < lastStamp + 100)return;
  lastStamp = currentStamp;

  if(0 == enable)return;

  special();
}

void send_forever()
{
  uint32_t currentStamp = millis();
  if(currentStamp < lastStamp + 100)return;
  lastStamp = currentStamp;

  if(0 == enable)return;

  //
  sendframe_belt(m_belt);
  //
  sendframe_mileage(m_mileage);
  //
  sendframe_oilsum(m_oilsum);
  //
  sendframe_gear(m_gear);
  //
  sendframe_tacspeed(m_tacspeed);
  //
  //Serial.println(m_speed);
  sendframe_speed_brake_clutch(m_handbrake, m_speed, m_brake, m_clutch);
  //sendframe_clutch(m_clutch);
  //
  sendframe_nox(m_nox);
  //
  sendframe_coolant(m_coolant);
  //
  sendframe_slope(m_slope);
  //
  sendframe_turn(m_turn);
  //
  sendframe_load(m_loadkg);
  //
  sendframe_oiling(m_oil_lh, m_oil_kml);
  //
  sendframe_accpedal_loadrate(m_accpedal, m_loadrate);
  //
  sendframe_torquemode_torquepercent_rpm(m_torquemode, m_torquepercent, m_rpm);
  //
  sendframe_frictionpercent(m_frictionpercent);
  //
  sendframe_idleinfo(m_idleliter, m_idlesec);
  //
  testreq();
  testres();
  //
  special();
}


int loopcount = 0;
float accel = 1.0;
void send_accelerate()
{
  uint32_t currentStamp = millis();
  if(currentStamp < lastStamp + 100)return;
  lastStamp = currentStamp;

  if(0 == enable)return;

  sendframe_torquemode_torquepercent_rpm(m_torquemode, m_torquepercent, m_rpm);
  //
  sendframe_speed_brake_clutch(m_handbrake, m_speed, m_brake, m_clutch);
  //
  sendframe_accpedal_loadrate(m_accpedal, m_loadrate);

  float ms2 = accel / 10.0;
  float kmh = ms2 * 3.6;
  float sum = m_tacspeed + kmh;
  if( (sum>=0) && (sum < 90) ){
    m_tacspeed = sum;
    Serial.printf("%f, %f, %f\n", ms2, kmh, m_tacspeed);
  }
  sendframe_tacspeed(m_tacspeed);

  if(loopcount<60)loopcount++;
}


void readcan()
{
  CanFrame pkt;
  if(ESP32Can.readFrame(pkt, 0)) {
    char str[64] = {0};
    int tmp = 0;
    for(int j=0;j<pkt.data_length_code;j++)tmp += snprintf(str+tmp, 32-tmp, "%02x%c", pkt.data[j], (j+1<pkt.data_length_code) ? ' ' : '\0');
    //Serial.printf("recv %08x : %s\n", pkt.identifier, str);
  }
}


void parsecmd(char* key, float val)
{
  uint8_t buf[8];
  if(strncmp(key, "mode", 4)==0){
    loopcount = 0;
    runmode = int(val+0.1);
  }
  else if(strncmp(key, "accel", 5)==0){
    accel = val;
  }
  else if(strncmp(key, "tacspeed", 8)==0){
    m_tacspeed = val;

    builddata_tacspeed(buf, m_tacspeed);
    print_canid_and_data(canid_tacspeed, buf);
  }
  else if(strncmp(key, "speed", 5)==0){
    Serial.printf("(cmd)speed = %f\n", val);
    m_speed = val;

    builddata_speed_brake_clutch(buf, m_handbrake, m_speed, m_brake, m_clutch);
    print_canid_and_data(canid_speedclutchbrake, buf);
  }
  else if(strncmp(key, "handbrake", 6)==0){
    m_handbrake = int(val+0.1);
    Serial.printf("(cmd)handbrake = %d\n", m_handbrake);

    builddata_speed_brake_clutch(buf, m_handbrake, m_speed, m_brake, m_clutch);
    print_canid_and_data(canid_speedclutchbrake, buf);
  }
  else if(strncmp(key, "clutch", 6)==0){
    m_clutch = int(val+0.1);
    Serial.printf("(cmd)clutch = %d\n", m_clutch);

    builddata_speed_brake_clutch(buf, m_handbrake, m_speed, m_brake, m_clutch);
    print_canid_and_data(canid_speedclutchbrake, buf);
  }
  else if(strncmp(key, "brake", 5)==0){
    m_brake = int(val+0.1);
    Serial.printf("(cmd)brake = %d\n", m_brake);

    builddata_speed_brake_clutch(buf, m_handbrake, m_speed, m_brake, m_clutch);
    print_canid_and_data(canid_speedclutchbrake, buf);
  }
  else if(strncmp(key, "accpedal", 8)==0){
    m_accpedal = val;
    Serial.printf("(cmd)accpedal = %f\n", val);

    builddata_accpedal_loadrate(buf, m_accpedal, m_loadrate);
    print_canid_and_data(canid_accpedalloadrate, buf);
  }
  else if(strncmp(key, "mileage", 7)==0){
    m_mileage = val;
    Serial.printf("(cmd)mileage = %f\n", val);

    builddata_mileage(buf, m_mileage);
    print_canid_and_data(canid_mileage, buf);
  }
  else if(strncmp(key, "oilsum", 6)==0){
    m_oilsum = val;
    Serial.printf("(cmd)oilsum = %f\n", val);

    builddata_oilsum(buf, m_oilsum);
    print_canid_and_data(canid_oilsum, buf);
  }
  else if(strncmp(key, "gear", 4)==0){
    m_gear = int(val+0.1);
    Serial.printf("(cmd)gear = %f\n", val);

    builddata_gear(buf, m_oilsum);
    print_canid_and_data(canid_gear, buf);
  }
  else if(strncmp(key, "nox", 3)==0){
    m_nox = val;
    Serial.printf("(cmd)nox = %f\n", val);

    builddata_nox(buf, m_nox);
    print_canid_and_data(canid_nox, buf);
  }
  else if(strncmp(key, "coolant", 7)==0){
    m_coolant = val;
    Serial.printf("(cmd)coolant = %f\n", val);

    builddata_coolant(buf, m_coolant);
    print_canid_and_data(canid_coolant, buf);
  }
  else if(strncmp(key, "slope", 5)==0){
    m_slope = val;
    Serial.printf("(cmd)slope = %f\n", val);

    builddata_coolant(buf, m_slope);
    print_canid_and_data(canid_slope, buf);
  }
  else if(strncmp(key, "turn", 4)==0){
    m_turn = val;
    Serial.printf("(cmd)turn = %f\n", val);

    builddata_turn(buf, m_turn);
    print_canid_and_data(canid_turn, buf);
  }
  else if(strncmp(key, "loadkg", 6)==0){
    m_loadkg = val;
    Serial.printf("(cmd)loadkg = %f\n", val);

    builddata_load(buf, m_loadkg);
    print_canid_and_data(canid_loadkg, buf);
  }
  else if(strncmp(key, "loadrate", 8)==0){
    m_loadrate = val;
    Serial.printf("(cmd)loadrate = %f\n", val);

    builddata_accpedal_loadrate(buf, m_accpedal, m_loadrate);
    print_canid_and_data(canid_accpedalloadrate, buf);
  }
  else if(strncmp(key, "torquemode", 10)==0){
    m_torquemode = int(val+0.1);
    Serial.printf("(cmd)torquemode = %f\n", val);

    builddata_torquemode_torquepercent_rpm(buf, m_torquemode, m_torquepercent, m_rpm);
    print_canid_and_data(canid_torquerpm, buf);
  }
  else if(strncmp(key, "torque", 6)==0){
    m_torquepercent = val;
    Serial.printf("(cmd)torquepercent = %f\n", val);

    builddata_torquemode_torquepercent_rpm(buf, m_torquemode, m_torquepercent, m_rpm);
    print_canid_and_data(canid_torquerpm, buf);
  }
  else if(strncmp(key, "rpm", 3)==0){
    Serial.printf("(cmd)rpm = %f\n", val);
    m_rpm = val;

    builddata_torquemode_torquepercent_rpm(buf, m_torquemode, m_torquepercent, m_rpm);
    print_canid_and_data(canid_torquerpm, buf);
  }
  else if(strncmp(key, "friction", 8)==0){
    m_frictionpercent = val;
    Serial.printf("(cmd)frictionpercent = %f\n", val);

    builddata_frictionpercent(buf, m_frictionpercent);
    print_canid_and_data(canid_frictionpercent, buf);
  }
  else if(strncmp(key, "oillh", 5)==0){
    m_oil_lh = val;
    Serial.printf("(cmd)oillh = %f\n", val);

    builddata_oiling(buf, m_oil_lh, m_oil_kml);
    print_canid_and_data(canid_oiling, buf);
  }
  else if(strncmp(key, "oilkml", 6)==0){
    Serial.printf("(cmd)oilkml = %f\n", val);
    m_oil_kml = val;

    builddata_oiling(buf, m_oil_lh, m_oil_kml);
    print_canid_and_data(canid_oiling, buf);
  }
  else if(strncmp(key, "belt", 4)==0){
    m_belt = int(val+0.1);
    Serial.printf("(cmd)belt = %d\n", m_belt);

    builddata_belt(buf, m_belt);
    print_canid_and_data(canid_belt, buf);
  }
  else if(strncmp(key, "idleliter", 6)==0){
    m_idleliter = val;
    Serial.printf("(cmd)idleliter = %d\n", m_idleliter);

    builddata_idleinfo(buf, m_idleliter, m_idlesec);
    print_canid_and_data(canid_idleinfo, buf);
  }
  else if(strncmp(key, "idlesec", 7)==0){
    m_idlesec = val;
    Serial.printf("(cmd)idlesec = %d\n", m_idlesec);

    builddata_idleinfo(buf, m_idleliter, m_idlesec);
    print_canid_and_data(canid_idleinfo, buf);
  }
}
int str2float(char* str, float* f){
  if( ((str[0]>='0') && (str[0]<='9')) || (str[0]=='-') ){
    *f = atof(str);
    return 1;
  }
  return 0;
}
int str2canid(char *str, uint32_t *result) {
    char *endptr;
    unsigned long temp;

    if (str == NULL || *str == '\0') {
        return -1;
    }

    while (isspace((unsigned char)*str)) {
        str++;
    }

    temp = strtoul(str, &endptr, 16);
    if (endptr == str) {
        return -2;
    }
    //Serial.println(str);
    //Serial.printf("===%x\n",temp);

    *result = (uint32_t)temp;
    return 0;
}
int str2candata(char *str, uint8_t *data) {
  while(*str == ' ')str++;

  int cnt = 0;
  int k = 0;
  for(int j=0;j<64;j++){
    //Serial.printf("aaaaaa %d %x\n", j, str[j]);
    if(str[j] <= 0x20){
      data[cnt] = strtol(str+k, nullptr, 16);
      //Serial.printf("%d %x", cnt, data[cnt]);

      cnt++;
      if(cnt >= 8)break;

      if(str[j] != 0x20)break;
      else{
        while(str[j+1] == ' ')j++;
        k = j+1;
      }
    }
  }
  return cnt;
}
void parsestr(char* str){
  int j,ret;
  float val;
  for(j=0;j<64;j++){
    if(str[j]==':'){
      bool ret1 = str2canid(str, &oneframe_canid);
      bool ret2 = str2candata(str+j+1, oneframe_data);

      if((ret1>=0) && (ret2>0)){
        print_canid_and_data(oneframe_canid, oneframe_data);
        oneframe_en = 1;
      }
      break;
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
void parseraw(char* str){
  if(strncmp(str, "reset", 5)==0){
    m_speed = 0;
    m_brake = 0;
    m_clutch = 0;
    m_oil_lh = 0;
    m_oil_kml = 0;
    m_oilsum = 0;
    m_mileage = 0;
    m_gear = 0;
    m_nox = 0;
    m_coolant = 0;
    m_slope = 0;
    m_turn = 0;
    m_loadkg = 0;
    m_accpedal = 0;
    m_loadrate = 0;
    m_torquemode = 0;
    m_torquepercent = 0;
    m_rpm = 0;
    m_frictionpercent = 0;
    Serial.println("reseted");
    return;
  }
  else if(strncmp(str, "enable", 6)==0){
    enable = 1;
    Serial.println("enabled");
    return;
  }
  else if(strncmp(str, "disable", 7)==0){
    enable = 0;
    Serial.println("disabled");
    return;
  }
  else if(strncmp(str, "req", 3)==0){
    Serial.println("req");
    testreq_en = 1;
    return;
  }
  else if(strncmp(str, "res", 3)==0){
    Serial.println("res");
    testres_en = 1;
    return;
  }

  parsestr(str);
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
  parseraw(str);
}




void loop() {
  readserial();

  readcan();

  switch(runmode){
  case 0:
    send_inputcmd();
    break;
  case 1:
    send_forever();
    break;
  case 2:
    send_accelerate();
    break;
  }
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
  ESP32Can.setSpeed(ESP32Can.convertSpeed(250));

  // You can also just use .begin()..
  if(ESP32Can.begin()) {
    Serial.println("CAN bus started!");
  } else {
    Serial.println("CAN bus failed!");
  }
}
