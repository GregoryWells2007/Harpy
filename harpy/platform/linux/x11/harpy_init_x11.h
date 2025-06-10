#pragma once
#include <X11/Xlib.h>
#include "harpy_window.h"

typedef struct hpX11Data {
    Display* display;
    int windowCount;
    hpWindow* windows;
} hpX11Data;

hpX11Data* hpX11GetData();
