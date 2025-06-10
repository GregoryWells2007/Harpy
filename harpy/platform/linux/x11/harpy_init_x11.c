#include "harpy_init.h"
#include "harpy_init_x11.h"

static hpX11Data data;
hpX11Data* hpX11GetData() { return &data; }

void hpInit() {
    data = (hpX11Data){
        .display = XOpenDisplay(NULL)
    };
}

void hpClose() { XCloseDisplay(data.display); }

void hpReadEvents() {
    XEvent event = {0};
    XNextEvent(data.display, &event);
}
