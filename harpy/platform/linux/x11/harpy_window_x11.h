#include "stdbool.h"
#include <X11/Xlib.h>

struct hpWindow_t {
    bool open;
    Window window;
    XIC inputContext;
    const char* name;
};
