#include "keyled.h"
#include <Arduino.h>
#include <string.h>
#include "mod_usb.h"
USBHIDKeyboard usbkbd;
extern int currmode;

// ---------------- 键值表（都放在这里）----------------
// 表编号 = 模式号：0 = default(常规键位)，1 = abcdef，2 = ascii，3 = periodic(元素周期表)
// 值是**原始 HID usage**（pressRaw 直接发），所以写 HID_KEY_*；BLE 那边是另一套写法
// （'a' 这类 ASCII 交给库里的 _asciimap，KEY_* 是非打印键）。**改表时两张表要一起改**。
#if mode_chosen==mode_arrow
// arrow 模式只有一张表
static byte keytable_arrow[ROWS][COLS] = {
  {                 0,                    0, HID_KEY_PAGE_UP, HID_KEY_END      },
  {                 0,                    0, HID_KEY_HOME   , HID_KEY_PAGE_DOWN},
  {HID_KEY_ARROW_UP  ,  HID_KEY_ARROW_RIGHT,               0,                 0},
  {HID_KEY_ARROW_LEFT,  HID_KEY_ARROW_DOWN ,               0,                 0}
};
#else
static byte keytable_default[ROWS][COLS] = {
  {0, HID_KEY_VOLUME_UP  },
  {0, HID_KEY_VOLUME_DOWN},
  {0, HID_KEY_ESCAPE      , HID_KEY_F1      , HID_KEY_F2      , HID_KEY_F3   , HID_KEY_F4   , HID_KEY_F5   , HID_KEY_F6   , HID_KEY_F7, HID_KEY_F8,    HID_KEY_F9,     HID_KEY_F10,       HID_KEY_F11,          HID_KEY_F12  },
  {0, HID_KEY_GRAVE       , HID_KEY_1       , HID_KEY_2       , HID_KEY_3    , HID_KEY_4    , HID_KEY_5    , HID_KEY_6    , HID_KEY_7,  HID_KEY_8,     HID_KEY_9,      HID_KEY_0,         HID_KEY_MINUS,        HID_KEY_EQUAL},
  {0, HID_KEY_TAB         , HID_KEY_Q       , HID_KEY_W       , HID_KEY_E    , HID_KEY_R    , HID_KEY_T    , HID_KEY_Y    , HID_KEY_U,  HID_KEY_I,     HID_KEY_O,      HID_KEY_P,         HID_KEY_BRACKET_LEFT, HID_KEY_BRACKET_RIGHT},
  {0, HID_KEY_CAPS_LOCK   , HID_KEY_A       , HID_KEY_S       , HID_KEY_D    , HID_KEY_F    , HID_KEY_G    , HID_KEY_H    , HID_KEY_J,  HID_KEY_K,     HID_KEY_L,      HID_KEY_SEMICOLON, HID_KEY_APOSTROPHE},
  {0, HID_KEY_SHIFT_LEFT  , HID_KEY_Z       , HID_KEY_X       , HID_KEY_C    , HID_KEY_V    , HID_KEY_B    , HID_KEY_N    , HID_KEY_M,  HID_KEY_COMMA, HID_KEY_PERIOD, HID_KEY_SLASH     },
  {0, HID_KEY_CONTROL_LEFT, HID_KEY_GUI_LEFT, HID_KEY_ALT_LEFT, HID_KEY_SPACE, HID_KEY_SPACE, HID_KEY_SPACE, HID_KEY_SPACE              }
};
static byte keytable_abcdef[ROWS][COLS] = {
{0, HID_KEY_VOLUME_UP},
{0, HID_KEY_VOLUME_DOWN},
{0, HID_KEY_ESCAPE      , HID_KEY_F1      , HID_KEY_F2      , HID_KEY_F3   , HID_KEY_F4   , HID_KEY_F5   , HID_KEY_F6   , HID_KEY_F7,    HID_KEY_F8,     HID_KEY_F9,        HID_KEY_F10, HID_KEY_F11,          HID_KEY_F12},
{0, HID_KEY_GRAVE       , HID_KEY_1       ,  HID_KEY_2      , HID_KEY_3    , HID_KEY_4    , HID_KEY_5    , HID_KEY_6    , HID_KEY_7,     HID_KEY_8,      HID_KEY_9,         HID_KEY_0,   HID_KEY_MINUS,        HID_KEY_EQUAL},
{0, HID_KEY_TAB         , HID_KEY_A       ,  HID_KEY_B      , HID_KEY_C    , HID_KEY_D    , HID_KEY_E    , HID_KEY_F    , HID_KEY_G,     HID_KEY_H,      HID_KEY_I,         HID_KEY_J,   HID_KEY_BRACKET_LEFT, HID_KEY_BRACKET_RIGHT},
{0, HID_KEY_CAPS_LOCK   , HID_KEY_K       ,  HID_KEY_L      , HID_KEY_M    , HID_KEY_N    , HID_KEY_O    , HID_KEY_P    , HID_KEY_Q,     HID_KEY_R,      HID_KEY_S,         HID_KEY_T,   HID_KEY_SEMICOLON,    HID_KEY_APOSTROPHE},
{0, HID_KEY_SHIFT_LEFT  , HID_KEY_U       ,  HID_KEY_V      , HID_KEY_W    , HID_KEY_X    , HID_KEY_Y    , HID_KEY_Z    , HID_KEY_COMMA, HID_KEY_PERIOD, HID_KEY_BACKSLASH, HID_KEY_SLASH},
{0, HID_KEY_CONTROL_LEFT, HID_KEY_GUI_LEFT, HID_KEY_ALT_LEFT, HID_KEY_SPACE, HID_KEY_SPACE, HID_KEY_SPACE, HID_KEY_SPACE              }
};
static byte keytable_ascii[ROWS][COLS] = {
  {0, HID_KEY_VOLUME_UP    },
  {0, HID_KEY_VOLUME_DOWN  },
  {0, HID_KEY_ESCAPE       },
  {0, HID_KEY_GRAVE        },
  {0, HID_KEY_TAB          },
  {0, HID_KEY_CAPS_LOCK    },
  {0, HID_KEY_SHIFT_LEFT   },
  {0, HID_KEY_SPACE        }
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




#if mode_chosen==mode_arrow

void usbkbd_press(int x, int y)
{
  if( (x<0) || (x>=4) )return;
  if( (y<0) || (y>=4) )return;
  usbkbd.pressRaw(keytable_arrow[y][x]);
}
void usbkbd_release(int x, int y)
{
  if( (x<0) || (x>=4) )return;
  if( (y<0) || (y>=4) )return;
  usbkbd.releaseRaw(keytable_arrow[y][x]);
}

#else

// 8x18 下的模式：0=default(常规键位)，1=abcdef，2=ascii，3=periodic(元素周期表)，
// 4 及以上按常规键位处理。周期表模式在这里自己把字符串入队，由 usbkbd_type_poll() 慢慢发。
// 模式切换目前只能在网页里做（/kbdstat 的 set mode）。
//
// ascii 模式：第 0/1 列查 keytable_ascii（16 个特殊键），其余 16x8 格按位置直接对应 ASCII：
//     ascii = y*16 + (x-2)        // 0x00 .. 0x7f
// 不需要自己写 ASCII->键值表：USBHIDKeyboard::press(uint8_t) 内部查 KeyboardLayout_en_US，
// 大写/符号会自动带上 Shift；映射为 0 的码（0x00-0x07、0x0B-0x1F 含 ESC、0x7F）库会直接忽略。
static uint8_t usbkbd_ascii_of(int x, int y){
  return (uint8_t)(y*16 + (x-2));
}
void usbkbd_press(int x, int y)
{
  switch(currmode){
  case kbdmode_abcdef:
    usbkbd.pressRaw(keytable_abcdef[y][x]);
    break;
  case kbdmode_ascii:
    if(x < 2)usbkbd.pressRaw(keytable_ascii[y][x]);          // 前两列：特殊键
    else usbkbd_press_ascii((char)usbkbd_ascii_of(x, y));    // 其余：ASCII 0x00-0x7f
    break;
  case kbdmode_periodic:
    usbkbd_type(usbkbd_getstr(x, y));
    break;
  default:
    usbkbd.pressRaw(keytable_default[y][x]);
    break;
  }
}
void usbkbd_release(int x, int y)
{
  switch(currmode){
  case kbdmode_abcdef:
    usbkbd.releaseRaw(keytable_abcdef[y][x]);
    break;
  case kbdmode_ascii:
    if(x < 2)usbkbd.releaseRaw(keytable_ascii[y][x]);
    else usbkbd_release_ascii((char)usbkbd_ascii_of(x, y));
    break;
  case kbdmode_periodic:
    break;   //字符串是异步打出去的，没有对应的按下状态要松开
  default:
    usbkbd.releaseRaw(keytable_default[y][x]);
    break;
  }
}

#endif


// 周期表模式用：按 ASCII 字符发送。核心的 USBHIDKeyboard::press(uint8_t) 内部有 _asciimap，
// 大写等需要 Shift 的字符会自动带上修饰键，所以这里不用自己查表。
void usbkbd_press_ascii(char c){
  usbkbd.press((uint8_t)c);
}
void usbkbd_release_ascii(char c){
  usbkbd.release((uint8_t)c);
}


// ---- 键值表读写（Web 改键用） ----
// 表编号 = 模式号：0 = normal(常规键位)，1 = abcdef，2 = ascii，3 = periodic(元素周期表)。
// 周期表是字符串表（见本文件末尾），所以 t=3 时这里没有 byte 表（返回 nullptr）。
// arrow 模式下只有一张表，编号固定为 0。
static byte* usbkbd_table(int t){
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
    return 0;   // 3 = 周期表，键值不在 byte 表里
  }
#endif
}

int usbkbd_table_count(){
#if mode_chosen==mode_arrow
  return 1;
#else
  return 4;
#endif
}

const char* usbkbd_table_name(int t){
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

// USB HID usage：00 空位，04-A4 普通键，E0-E7 修饰键，其余视为非法
bool usbkbd_key_valid(uint32_t val){
  if(0 == val)return true;
  if(val > 0xff)return false;
  if( (val>=0x04) && (val<=0xa4) )return true;
  if( (val>=0xe0) && (val<=0xe7) )return true;
  return false;
}

uint32_t usbkbd_getkey(int t, int x, int y){
  if( (t<0) || (t>=usbkbd_table_count()) )return 0;
  byte* tbl = usbkbd_table(t);
  if(!tbl)return 0;
  if( (x<0) || (x>=COLS) )return 0;
  if( (y<0) || (y>=ROWS) )return 0;
  return tbl[y*COLS + x];
}

bool usbkbd_setkey(int t, int x, int y, uint32_t val){
  if( (t<0) || (t>=usbkbd_table_count()) )return false;
  byte* tbl = usbkbd_table(t);
  if(!tbl)return false;
  if( (x<0) || (x>=COLS) )return false;
  if( (y<0) || (y>=ROWS) )return false;
  if(!usbkbd_key_valid(val))return false;

  tbl[y*COLS + x] = (byte)val;
  return true;
}

#if kbd_periodic_enabled

// ---- 元素周期表模式（8x18 的模式 3）----
// 每格一个字符串（元素符号），按下时逐字符发给主机。
// 表固定按 8x18 存，arrow 模式下用不到但也编得过。
// 不需要自己写 ASCII->键值表：库里的 press(uint8_t) 自带 _asciimap 并会处理 Shift。

int usbkbd_str_maxlen(){
  return KBDSTR_MAXLEN;
}

bool usbkbd_str_valid(const char* s){
  if(!s)return false;

  size_t len = strlen(s);
  if(len >= KBDSTR_MAXLEN)return false;

  for(size_t i=0;i<len;i++){
    if( (s[i] < 0x20) || (s[i] > 0x7e) )return false;   // 只允许可打印 ASCII
  }
  return true;
}

const char* usbkbd_getstr(int x, int y){
  if( (x<0) || (x>=KBDSTR_COLS) )return "";
  if( (y<0) || (y>=KBDSTR_ROWS) )return "";
  return keytable_periodic[y][x];
}

bool usbkbd_setstr(int x, int y, const char* s){
  if( (x<0) || (x>=KBDSTR_COLS) )return false;
  if( (y<0) || (y>=KBDSTR_ROWS) )return false;
  if(!usbkbd_str_valid(s))return false;

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

size_t usbkbd_type_len(){
  size_t len;

  portENTER_CRITICAL(&q_mux);
  len = (q_head + KBDSTR_QSIZE - q_tail) % KBDSTR_QSIZE;
  portEXIT_CRITICAL(&q_mux);

  return len;
}

void usbkbd_type_clear(){
  portENTER_CRITICAL(&q_mux);
  q_head = 0;
  q_tail = 0;
  portEXIT_CRITICAL(&q_mux);
}

void usbkbd_type(const char* s){
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
void usbkbd_type_poll(){
  char c;

  while(kbdstr_q_pop(&c)){
    usbkbd_press_ascii(c);
    delay(KBDSTR_HOLD_MS);
    usbkbd_release_ascii(c);
    delay(KBDSTR_GAP_MS);
  }
}

#else

// arrow 模式（4x4）没有元素周期表：这里只留一组空实现，
// 让 keyled.ino / mod_web.cpp 不用到处加条件编译。
int usbkbd_str_maxlen(){ return 0; }
bool usbkbd_str_valid(const char* s){ (void)s; return false; }
const char* usbkbd_getstr(int x, int y){ (void)x; (void)y; return ""; }
bool usbkbd_setstr(int x, int y, const char* s){ (void)x; (void)y; (void)s; return false; }
void usbkbd_type(const char* s){ (void)s; }
void usbkbd_type_poll(){}
size_t usbkbd_type_len(){ return 0; }
void usbkbd_type_clear(){}

#endif
