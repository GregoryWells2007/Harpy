#include "harpy_window.h"
#include "harpy_init_x11.h"
#include "stdlib.h"
#include "stdbool.h"

// Thanks to this tutorial: https://alexvia.com/post/001_xlib_opening_window/
// for teaching me the basics of opening windows on X11

struct hpWindow_t {
    bool open;
    Window window;
};

hpWindow hpCreateWindow(int width, int height, const char* name) {
    hpX11Data* data = hpX11GetData();

    hpWindow window = malloc(sizeof(struct hpWindow_t));
    window->window = XCreateSimpleWindow(
	data->display, XDefaultRootWindow(data->display),
	0, 0, width, height,
	0, 0x00000000,	0x00000000);
    XStoreName(data->display, window->window, name);
    XSelectInput(data->display, window->window, KeyPressMask|KeyReleaseMask);
    XMapWindow(data->display, window->window);
    window->open = true;

    if (data->windowCount == 0)
        data->windows = malloc(sizeof(hpWindow));
    else
        data->windows = realloc(data->windows, sizeof(hpWindow) * (data->windowCount + 1));

    data->windows[data->windowCount] = window;
    data->windowCount++;

    return window;
}

int hpWindowIsOpen(hpWindow window) {
    return window->open;
}

void hpDestroyWindow(hpWindow window) {
    hpX11Data* data = hpX11GetData();
    XUnmapWindow(data->display, window->window);
    XDestroyWindow(data->display, window->window);
    window->open = false;
    free(window);
}

void hpWindowGetSize(hpWindow window, int* width, int* height) {

}

void hpWindowGetFramebufferSize(hpWindow window, int* width, int* height) {

}
