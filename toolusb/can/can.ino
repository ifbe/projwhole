#include <ESP32-TWAI-CAN.hpp>

// Simple sketch that querries OBD2 over CAN for coolant temperature
// Showcasing simple use of ESP32-TWAI-CAN library driver.

// Default for ESP32
#define CAN_TX 1    //5
#define CAN_RX 2    //4
static uint32_t lastStamp = 0;

void buildframe(CanFrame* pkt, uint8_t obdId) {
	pkt->identifier = 0x7DF; // Default OBD2 address;
	pkt->extd = 0;
	pkt->data_length_code = 8;
	pkt->data[0] = 2;
	pkt->data[1] = 1;
	pkt->data[2] = obdId;
	pkt->data[3] = 0xAA;    // Best to use 0xAA (0b10101010) instead of 0
	pkt->data[4] = 0xAA;    // CAN works better this way as it needs
	pkt->data[5] = 0xAA;    // to avoid bit-stuffing
	pkt->data[6] = 0xAA;
	pkt->data[7] = 0xAA;
  ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
}
void testsend()
{
  uint32_t currentStamp = millis();
  if(currentStamp > lastStamp + 1000) {   // sends OBD2 request every second
    lastStamp = currentStamp;
    CanFrame pkt;
    buildframe(&pkt, 5);
    ESP32Can.writeFrame(pkt);  // timeout defaults to 1 ms
  }
}
void testrecv()
{
  CanFrame pkt;
  if(ESP32Can.readFrame(pkt, 1000)) {
    char str[64] = {0};
    int tmp = 0;
    for(int j=0;j<pkt.data_length_code;j++)tmp += snprintf(str+tmp, 32-tmp, "%02x%c", pkt.data[j], (j+1<pkt.data_length_code) ? ' ' : '\0');
    Serial.printf("recv %08x : %s\n", pkt.identifier, str);
  }
}

void loop() {
  //testsend();
  testrecv();
}
void setup() {
  // Setup serial for debbuging.
  Serial.begin(115200);

  // Set pins
	ESP32Can.setPins(CAN_TX, CAN_RX);

  // You can set custom size for the queues - those are default
  ESP32Can.setRxQueueSize(5);
	ESP32Can.setTxQueueSize(5);

  // .setSpeed() and .begin() functions require to use TwaiSpeed enum,
  // but you can easily convert it from numerical value using .convertSpeed()
  ESP32Can.setSpeed(ESP32Can.convertSpeed(250));

  // You can also just use .begin()..
  if(ESP32Can.begin()) {
    Serial.println("CAN bus started!");
  } else {
    Serial.println("CAN bus failed!");
  }
/*
  // or override everything in one command;
  // It is also safe to use .begin() without .end() as it calls it internally
  if(ESP32Can.begin(ESP32Can.convertSpeed(500), CAN_TX, CAN_RX, 10, 10)) {
      Serial.println("CAN bus started!");
  } else {
      Serial.println("CAN bus failed!");
  }*/
}
