#pragma once
#include "harpy_types.h"
typedef struct hpWindow_t* hpWindow;

typedef struct hpWindowProperties {
    hpBool resizable;
} hpWindowProperties;

hpWindow hpCreateWindowWithProperties(int width, int height, const char* name, hpWindowProperties properties);
static inline hpWindow hpCreateWindow(int width, int height, const char* name) { return hpCreateWindowWithProperties(width, height, name, (hpWindowProperties){HP_TRUE}); }

int hpWindowIsOpen(hpWindow window);
void hpDestroyWindow(hpWindow window);
void hpCloseWindow(hpWindow window);
void hpReadEvents();
void hpWindowGetSize(hpWindow window, int* width, int* height);
void hpWindowGetFramebufferSize(hpWindow window, int* width, int* height);
