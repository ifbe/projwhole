#include "keyled.h"
#include "mod_ble.h"
#include <string.h>

//https://github.com/T-vK/ESP32-BLE-Keyboard
//
// 注意：BleKeyboard 把连接标志放在 private，而它的发报路径是
//     void BleKeyboard::sendReport(...) { if (this->isConnected()) { ...notify... } }
// 也就是**这个标志为假就什么都不发**；而这个标志只在库自己的 onConnect/onDisconnect 里赋值。
// 我们在下面重写了这两个回调（为了躲开 NimBLE 下 0x2902 描述符的空指针崩溃），
// 所以必须自己把库的这个标志置位，否则表现就是"蓝牙连上了但对端收不到任何按键"。
// 这里用 private->public 的小技巧把它暴露出来：只影响本 .cpp，类的布局不变；
// 万一以后库把这个成员改名/改可见性，编译期会直接报错，不会静默失效。
#define private public
#include <BleKeyboard.h>
#undef private
#include <BLEDevice.h>
#define MYKEY_MEDIA_NEXT_TRACK                     0x80000001   //= {1, 0};
#define MYKEY_MEDIA_PREVIOUS_TRACK                 0x80000002   //= {2, 0};
#define MYKEY_MEDIA_STOP                           0x80000004   //= {4, 0};
#define MYKEY_MEDIA_PLAY_PAUSE                     0x80000008   //= {8, 0};
#define MYKEY_MEDIA_MUTE                           0x80000010   //= {16, 0};
#define MYKEY_MEDIA_VOLUME_UP                      0x80000020   //= {32, 0};
#define MYKEY_MEDIA_VOLUME_DOWN                    0x80000040   //= {64, 0};
#define MYKEY_MEDIA_WWW_HOME                       0x80000080   //= {128, 0};
#define MYKEY_MEDIA_LOCAL_MACHINE_BROWSER          0x80000100   //= {0, 1}; // Opens "My Computer" on Windows
#define MYKEY_MEDIA_CALCULATOR                     0x80000200   //= {0, 2};
#define MYKEY_MEDIA_WWW_BOOKMARKS                  0x80000400   //= {0, 4};
#define MYKEY_MEDIA_WWW_SEARCH                     0x80000800   //= {0, 8};
#define MYKEY_MEDIA_WWW_STOP                       0x80001000   //= {0, 16};
#define MYKEY_MEDIA_WWW_BACK                       0x80002000   //= {0, 32};
#define MYKEY_MEDIA_CONSUMER_CONTROL_CONFIGURATION 0x80004000   //{0, 64}; // Media Selection
#define MYKEY_MEDIA_EMAIL_READER                   0x80008000   //= {0, 128};

// ---- 修 NimBLE 下"一连就重启" ----
// core 3.x 的蓝牙主机栈是 NimBLE（CONFIG_BT_NIMBLE_ENABLED=y），而 ESP32_BLE_Keyboard
// 0.3.2 没定义 USE_NIMBLE，走的是 Bluedroid 分支：
//     BLE2902* desc = (BLE2902*)inputKeyboard->getDescriptorByUUID(BLEUUID(0x2902));
//     desc->setNotifications(true);
// 但 NimBLE 下 BLEHIDDevice::inputReport() 不创建 0x2902 描述符（那段被
// #if CONFIG_BLUEDROID_ENABLED 包着），addDescriptor() 对 0x2902 也是直接 return，
// 所以 getDescriptorByUUID() 必然返回 nullptr -> 空指针解引用 -> LoadProhibited -> PANIC。
// 而 BLE2902::setNotifications() 在 NimBLE 下本来就是空实现（CCCD 由协议栈自己管），
// 所以这里派生一层，跳过那两个调用，连接状态自己维护。
class KbdBleKeyboard : public BleKeyboard {
protected:
  void onConnect(BLEServer* pServer) override {
    (void)pServer;
    connected = true;    // 库的 private 标志，sendReport()/isConnected() 依赖它
  }

  void onDisconnect(BLEServer* pServer) override {
    (void)pServer;
    connected = false;

    // 库原来在这里 advertising->start()；core 的 m_advertiseOnDisconnect 默认是 false，
    // 所以必须自己重新开广播，否则断开一次之后就再也搜不到了。
    BLEAdvertising* adv = BLEDevice::getAdvertising();
    if(adv && !adv->isAdvertising())adv->start();
  }
};

KbdBleKeyboard blekbd;
extern int currmode;

// ---------------- 键值表（都放在这里）----------------
// 表编号 = 模式号：0 = default(常规键位)，1 = abcdef，2 = ascii，3 = periodic(元素周期表)
// 值是 T-vK 库的写法：'a' 这类 ASCII 交给库里的 _asciimap（大写/符号自动带 Shift），
// KEY_* 是非打印键（KEY_ESC=0xB1 这种）。USB 那边写的是 HID_KEY_*，**改表时两张表要一起改**。
#if mode_chosen==mode_arrow
// arrow 模式只有一张表
static uint32_t keytable_arrow[ROWS][COLS] = {
  {             0,               0, KEY_PAGE_UP, KEY_END      },
  {             0,               0, KEY_HOME   , KEY_PAGE_DOWN},
  {KEY_UP_ARROW  , KEY_RIGHT_ARROW,           0,             0},
  {KEY_LEFT_ARROW, KEY_DOWN_ARROW ,           0,             0}
};
#else
static uint32_t keytable_default[ROWS][COLS] = {
  {0, MYKEY_MEDIA_VOLUME_UP  },
  {0, MYKEY_MEDIA_VOLUME_DOWN},
  {0, KEY_ESC       ,       KEY_F1,       KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7, KEY_F8, KEY_F9, KEY_F10, KEY_F11, KEY_F12    },
  {0, '`'           ,          '1',          '2',    '3',    '4',    '5',    '6',    '7',    '8',    '9',     '0',     '-',     '='    },
  {0, KEY_TAB       ,          'q',          'w',    'e',    'r',    't',    'y',    'u',    'i',    'o',     'p',     '[',     ']'    },
  {0, KEY_CAPS_LOCK ,          'a',          's',    'd',    'f',    'g',    'h',    'j',    'k',    'l',     ';',    '\'',            },
  {0, KEY_LEFT_SHIFT,          'z',          'x',    'c',    'v',    'b',    'n',    'm',    ',',    '.',     '/',                     },
  {0, KEY_LEFT_CTRL , KEY_LEFT_GUI, KEY_LEFT_ALT,    ' ',    ' ',    ' ',     ' '      }
};
static uint32_t keytable_abcdef[ROWS][COLS] = {
  {0, MYKEY_MEDIA_VOLUME_UP  },
  {0, MYKEY_MEDIA_VOLUME_DOWN},
  {0, KEY_ESC,              KEY_F1,       KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7, KEY_F8, KEY_F9, KEY_F10, KEY_F11, KEY_F12    },
  {0, '`'           ,          '1',          '2',    '3',    '4',    '5',    '6',    '7',    '8',    '9',     '0',     '-',     '='    },
  {0, KEY_TAB       ,          'a',          'b',    'c',    'd',    'e',    'f',    'g',    'h',    'i',     'j',     '[',     ']'    },
  {0, KEY_CAPS_LOCK ,          'k',          'l',    'm',    'n',    'o',    'p',    'q',    'r',    's',     't',     ';',    '\''    },
  {0, KEY_LEFT_SHIFT,          'u',          'v',    'w',    'x',    'y',    'z',    ',',    '.',   '\\',     '/',                     },
  {0, KEY_LEFT_CTRL , KEY_LEFT_GUI, KEY_LEFT_ALT,    ' ',    ' ',    ' ',     ' '      }
};
static uint32_t keytable_ascii[ROWS][COLS] = {
  {0, MYKEY_MEDIA_VOLUME_UP  },
  {0, MYKEY_MEDIA_VOLUME_DOWN},
  {0, KEY_ESC       , ' '},
  {0, '`'           , '0'},
  {0, KEY_TAB       , '@'},
  {0, KEY_CAPS_LOCK , 'P'},
  {0, KEY_LEFT_SHIFT, '@'},
  {0, KEY_LEFT_CTRL , 'p'}
};

// 元素周期表模式（8x18 的模式 3）：每格一个字符串，按下时逐字符发给主机。
// 表固定按 8x18 存；只有 8x18 模式（模式 3）才有它。
// 不需要自己写 ASCII->键值表：库里的 press(uint8_t) 自带 _asciimap 并会处理 Shift。
#define KBDSTR_MAXLEN 8      // 含结尾 '\0'，"La-Lu" 这种最长 5 字符
#define KBDSTR_ROWS 8
#define KBDSTR_COLS 18

static char keytable_periodic[KBDSTR_ROWS][KBDSTR_COLS][KBDSTR_MAXLEN] = {
  {  "H",   "",      "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "", "He" },   // 第1行
  { "Li", "Be",      "",   "",   "",   "",   "",   "",   "",   "",   "",   "",  "B",  "C",  "N",  "O",  "F", "Ne" },   // 第2行
  { "Na", "Mg",      "",   "",   "",   "",   "",   "",   "",   "",   "",   "", "Al", "Si",  "P",  "S", "Cl", "Ar" },   // 第3行
  {  "K", "Ca",    "Sc", "Ti",  "V", "Cr", "Mn", "Fe", "Co", "Ni", "Cu", "Zn", "Ga", "Ge", "As", "Se", "Br", "Kr" },   // 第4行
  { "Rb", "Sr",     "Y", "Zr", "Nb", "Mo", "Tc", "Ru", "Rh", "Pd", "Ag", "Cd", "In", "Sn", "Sb", "Te",  "I", "Xe" },   // 第5行
  { "Cs", "Ba", "La-Lu", "Hf", "Ta",  "W", "Re", "Os", "Ir", "Pt", "Au", "Hg", "Tl", "Pb", "Bi", "Po", "At", "Rn" },   // 第6行
  { "Fr", "Ra", "Ac-Lr", "Rf", "Db", "Sg", "Bh", "Hs", "Mt", "Ds", "Rg", "Cn", "Nh", "Fl", "Mc", "Lv", "Ts", "Og" },   // 第7行
  {   "",   "",      "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "",   "" },   // 第8行（模式行）
};

#endif




void blekbd_init()
{
  blekbd.begin();
}
void blekbd_exit()
{
}
void blekbd_press_u32(uint32_t val){
  if(val <= 0xffff){
    blekbd.press(val);
  }
  else{
    uint8_t* ptr = (uint8_t*)&val;
    blekbd.press(ptr);
  }
}
void blekbd_release_u32(uint32_t val){
  if(val <= 0xffff){
    blekbd.release(val);
  }
  else{
    uint8_t* ptr = (uint8_t*)&val;
    blekbd.release(ptr);
  }
}


#if mode_chosen==mode_arrow

void blekbd_press(int x, int y)
{
  //if(y>1)return;
  if(!blekbd_is_connected())return;

  if( (x<0) || (x>=4) )return;
  if( (y<0) || (y>=4) )return;
  blekbd_press_u32(keytable_arrow[y][x]);
  //blekbd.write('a');
  //blekbd.print("haha");
}
void blekbd_release(int x, int y)
{
  //if(y>1)return;
  if(!blekbd_is_connected())return;

  if( (x<0) || (x>=4) )return;
  if( (y<0) || (y>=4) )return;
  blekbd_release_u32(keytable_arrow[y][x]);
}

#else

// 8x18 下的模式：0=default(常规键位)，1=abcdef，2=ascii，3=periodic(元素周期表)。
// 4 及以上按常规键位处理。周期表模式在这里自己把字符串入队，由 blekbd_type_poll() 慢慢发。
// 模式切换目前只能在网页里做（/kbdstat 的 set mode）。
//
// ascii 模式：第 0/1 列查 keytable_ascii（16 个特殊键），其余 16x8 格按位置直接对应 ASCII：
//     ascii = y*16 + (x-2)        // 0x00 .. 0x7f
// 不需要自己写 ASCII->键值表：BleKeyboard::press(uint8_t) 内部查 _asciimap，会自动处理 Shift；
// 映射为 0 的码（0x00-0x07、0x0B-0x1F 含 ESC、0x7F）库会直接忽略。
static uint8_t blekbd_ascii_of(int x, int y){
  return (uint8_t)(y*16 + (x-2));
}
void blekbd_press(int x, int y)
{
  //if(y>1)return;
  if(!blekbd_is_connected())return;

  switch(currmode){
  case kbdmode_abcdef:
    blekbd_press_u32(keytable_abcdef[y][x]);
    break;
  case kbdmode_ascii:
    if(x < 2)blekbd_press_u32(keytable_ascii[y][x]);         // 前两列：特殊键
    else blekbd_press_ascii((char)blekbd_ascii_of(x, y));    // 其余：ASCII 0x00-0x7f
    break;
  case kbdmode_periodic:
    blekbd_type(blekbd_getstr(x, y));
    break;
  default:
    blekbd_press_u32(keytable_default[y][x]);
    break;
  }
}
void blekbd_release(int x, int y)
{
  //if(y>1)return;
  if(!blekbd_is_connected())return;

  switch(currmode){
  case kbdmode_abcdef:
    blekbd_release_u32(keytable_abcdef[y][x]);
    break;
  case kbdmode_ascii:
    if(x < 2)blekbd_release_u32(keytable_ascii[y][x]);
    else blekbd_release_ascii((char)blekbd_ascii_of(x, y));
    break;
  case kbdmode_periodic:
    break;   //字符串是异步打出去的，没有对应的按下状态要松开
  default:
    blekbd_release_u32(keytable_default[y][x]);
    break;
  }
}

#endif


// ---- 键值表读写（Web 改键用） ----
// 表编号 = 模式号：0 = normal(常规键位)，1 = abcdef，2 = ascii，3 = periodic(元素周期表)。
// 周期表是字符串表（见本文件末尾），所以 t=3 时这里没有 uint32_t 表（返回 nullptr）。
// arrow 模式下只有一张表，编号固定为 0。
static uint32_t* blekbd_table(int t){
#if mode_chosen==mode_arrow
  (void)t;
  return &keytable_arrow[0][0];
#else
  switch(t){
  case 0:
    return &keytable_default[0][0];
  case 1:
    return &keytable_abcdef[0][0];
  case 2:
    return &keytable_ascii[0][0];
  default:
    return 0;   // 3 = 周期表，键值不在 uint32_t 表里
  }
#endif
}

int blekbd_table_count(){
#if mode_chosen==mode_arrow
  return 1;
#else
  return 4;
#endif
}

const char* blekbd_table_name(int t){
#if mode_chosen==mode_arrow
  (void)t;
  return "arrow";
#else
  switch(t){
  case 0: return "normal";
  case 1: return "abcdef";
  case 2: return "ascii";
  case 3: return "periodic";
  default: return "?";
  }
#endif
}

// BleKeyboard 的键值编码（见 BleKeyboard::press(uint8_t)）：
//   00          空位
//   20-7E       可打印 ASCII（库内部查 _asciimap）
//   80-87       修饰键
//   88-FF       非打印键（库内部 k-136 就是 HID usage），如 KEY_ESC=0xB1
//   80000000|m  媒体键，m 的低 16 位就是 MediaKeyReport 的两个字节
bool blekbd_key_valid(uint32_t val){
  if(0 == val)return true;

  if(val & 0x80000000){
    uint32_t m = val & 0x7fffffff;
    return (m != 0) && (m <= 0xffff);
  }

  if( (val>=0x20) && (val<=0x7e) )return true;
  if( (val>=0x80) && (val<=0xff) )return true;
  return false;
}

uint32_t blekbd_getkey(int t, int x, int y){
  if( (t<0) || (t>=blekbd_table_count()) )return 0;
  uint32_t* tbl = blekbd_table(t);
  if(!tbl)return 0;
  if( (x<0) || (x>=COLS) )return 0;
  if( (y<0) || (y>=ROWS) )return 0;
  return tbl[y*COLS + x];
}

bool blekbd_setkey(int t, int x, int y, uint32_t val){
  if( (t<0) || (t>=blekbd_table_count()) )return false;
  uint32_t* tbl = blekbd_table(t);
  if(!tbl)return false;
  if( (x<0) || (x>=COLS) )return false;
  if( (y<0) || (y>=ROWS) )return false;
  if(!blekbd_key_valid(val))return false;

  tbl[y*COLS + x] = val;
  return true;
}


// ---- 蓝牙状态（/bt 页面用） ----
// 连不上时这三个值最有用：
//   connected=0 advertising=1 peers=0  -> 设备在广播，等主机来连
//   connected=0 advertising=0 peers=0  -> 广播停了（手机列表里看到的可能只是系统缓存的已配设备）
//   peers>0                            -> 已经有别的主机占着连接（这个库同时只服务一个主机）
bool blekbd_is_connected(){
  return blekbd.isConnected();   // 库的标志，由上面的 onConnect/onDisconnect 维护
}

bool blekbd_is_advertising(){
  BLEAdvertising* adv = BLEDevice::getAdvertising();
  return adv ? adv->isAdvertising() : false;
}

int blekbd_connected_count(){
  BLEServer* srv = BLEDevice::getServer();
  return srv ? (int)srv->getConnectedCount() : 0;
}

// 库没给 getter，靠本文件开头的 private->public 直接读（名字不对会编译期报错）
const char* blekbd_name(){
  return blekbd.deviceName.c_str();
}

// BLEDevice::getAddress() 在没 init() 时会记一条 log 并返回空地址，不会崩
String blekbd_address(){
  return BLEDevice::getAddress().toString();
}


// 周期表模式用：按 ASCII 字符发送。BleKeyboard::press(uint8_t) 内部有 _asciimap，
// 大写等需要 Shift 的字符会自动带上修饰键，所以这里不用自己查表。
void blekbd_press_ascii(char c){
  if(!blekbd_is_connected())return;
  blekbd.press((uint8_t)c);
}
void blekbd_release_ascii(char c){
  if(!blekbd_is_connected())return;
  blekbd.release((uint8_t)c);
}


#if kbd_periodic_enabled

// ---- 元素周期表模式（8x18 的模式 3）----
// 每格一个字符串（元素符号），按下时逐字符发给主机。
// 表固定按 8x18 存，arrow 模式下用不到但也编得过。
// 不需要自己写 ASCII->键值表：库里的 press(uint8_t) 自带 _asciimap 并会处理 Shift。

int blekbd_str_maxlen(){
  return KBDSTR_MAXLEN;
}

bool blekbd_str_valid(const char* s){
  if(!s)return false;

  size_t len = strlen(s);
  if(len >= KBDSTR_MAXLEN)return false;

  for(size_t i=0;i<len;i++){
    if( (s[i] < 0x20) || (s[i] > 0x7e) )return false;   // 只允许可打印 ASCII
  }
  return true;
}

const char* blekbd_getstr(int x, int y){
  if( (x<0) || (x>=KBDSTR_COLS) )return "";
  if( (y<0) || (y>=KBDSTR_ROWS) )return "";
  return keytable_periodic[y][x];
}

bool blekbd_setstr(int x, int y, const char* s){
  if( (x<0) || (x>=KBDSTR_COLS) )return false;
  if( (y<0) || (y>=KBDSTR_ROWS) )return false;
  if(!blekbd_str_valid(s))return false;

  strncpy(keytable_periodic[y][x], s, KBDSTR_MAXLEN-1);
  keytable_periodic[y][x][KBDSTR_MAXLEN-1] = '\0';
  return true;
}

// ---- 待发字符队列（onpress 在 core1 入队，type_poll 在 core0 出队）----
#define KBDSTR_QSIZE 64
#define KBDSTR_HOLD_MS 8     // 每个字符按住多久
#define KBDSTR_GAP_MS  8     // 字符之间再等多久

static char qbuf[KBDSTR_QSIZE];
static volatile size_t q_head = 0;
static volatile size_t q_tail = 0;
static portMUX_TYPE q_mux = portMUX_INITIALIZER_UNLOCKED;

size_t blekbd_type_len(){
  size_t len;

  portENTER_CRITICAL(&q_mux);
  len = (q_head + KBDSTR_QSIZE - q_tail) % KBDSTR_QSIZE;
  portEXIT_CRITICAL(&q_mux);

  return len;
}

void blekbd_type_clear(){
  portENTER_CRITICAL(&q_mux);
  q_head = 0;
  q_tail = 0;
  portEXIT_CRITICAL(&q_mux);
}

void blekbd_type(const char* s){
  if(!s || !*s)return;

  portENTER_CRITICAL(&q_mux);
  for(const char* p=s; '\0'!=*p; p++){
    size_t next = (q_head + 1) % KBDSTR_QSIZE;
    if(next == q_tail)break;                 // 队列满就丢后面的字符
    qbuf[q_head] = *p;
    q_head = next;
  }
  portEXIT_CRITICAL(&q_mux);
}

static bool kbdstr_q_pop(char* c){
  bool ok = false;

  portENTER_CRITICAL(&q_mux);
  if(q_head != q_tail){
    *c = qbuf[q_tail];
    q_tail = (q_tail + 1) % KBDSTR_QSIZE;
    ok = true;
  }
  portEXIT_CRITICAL(&q_mux);

  return ok;
}

// 逐字符发送：按下 -> 等一会儿 -> 松开 -> 再等一会儿
void blekbd_type_poll(){
  char c;

  while(kbdstr_q_pop(&c)){
    blekbd_press_ascii(c);
    delay(KBDSTR_HOLD_MS);
    blekbd_release_ascii(c);
    delay(KBDSTR_GAP_MS);
  }
}

#else

// arrow 模式（4x4）没有元素周期表：这里只留一组空实现，
// 让 keyled.ino / mod_web.cpp 不用到处加条件编译。
int blekbd_str_maxlen(){ return 0; }
bool blekbd_str_valid(const char* s){ (void)s; return false; }
const char* blekbd_getstr(int x, int y){ (void)x; (void)y; return ""; }
bool blekbd_setstr(int x, int y, const char* s){ (void)x; (void)y; (void)s; return false; }
void blekbd_type(const char* s){ (void)s; }
void blekbd_type_poll(){}
size_t blekbd_type_len(){ return 0; }
void blekbd_type_clear(){}

#endif
