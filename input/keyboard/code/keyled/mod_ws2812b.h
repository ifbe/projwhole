#pragma once

#include <Arduino.h>

void initled();

void ws2812b_clear();

void ws2812b_show();

// 全灯一个颜色（只 show 一次），顺手把 rgbtable 也同步成这个颜色
void ws2812b_fill(uint32_t rgb);

// 上电时的底色：1/255 的白，很暗（setup 里 initled() 之后用）
#define WS2812B_DIM_RGB 0x010101

// 开机流水灯：按**灯带顺序** 0 → ROWS*COLS-1 逐个亮很短时间，跑完全灭。
// 在 setup() 末尾调用（会阻塞大约 2 秒）。
void ws2812b_flow();

void ws2812b_press(int x, int y);

void ws2812b_release(int x, int y);

void ws2812b_setpixel(int x, int y, uint32_t rgb);

uint32_t ws2812b_getpixel(int x, int y);