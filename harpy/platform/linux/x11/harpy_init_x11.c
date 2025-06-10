#include "harpy_init.h"
#include "harpy_init_x11.h"
#include "harpy_window_x11.h"
#include "stdio.h"

static hpX11Data data;
hpX11Data* hpX11GetData() { return &data; }

void hpInit() {
    data = (hpX11Data){
        .display = XOpenDisplay(NULL),
    };
    data.deleteMessage = XInternAtom(data.display, "WM_DELETE_WINDOW", False);
    data.inputManager = XOpenIM(data.display, NULL, NULL, NULL);
}

void hpClose() { XCloseDisplay(data.display); }

void hpX11ProcessEvent(XEvent event) {
    hpWindow window = NULL;
    if (XFindContext(data.display,
        event.xany.window,
        data.context,
        (XPointer*) &window) != 0)return;

    switch(event.type) {
        default:break;
        case ClientMessage:
            if (event.xclient.data.l[0] == data.deleteMessage) {
                hpCloseWindow(window);
            }
            break;
    }
}

void hpReadEvents() {
    // drainEmptyEvents();
    XPending(data.display);

    while (QLength(data.display)) {
        XEvent event;
        XNextEvent(data.display, &event);
        hpX11ProcessEvent(event);
    }

    XFlush(data.display);
}
