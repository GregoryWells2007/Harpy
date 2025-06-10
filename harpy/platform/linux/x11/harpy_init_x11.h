#pragma once
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include "harpy_window.h"

typedef struct hpX11Data {
    Display* display;
    int windowCount;
    hpWindow* windows;
    Atom deleteMessage;
    XIM inputManager;
    XContext context;
} hpX11Data;

hpX11Data* hpX11GetData();
