#include <harpy/harpy.h>
#include "stdio.h"

hpWindow window;

int main() {
    window = hpCreateWindow(640, 360, "Harpy window");

    while (hpWindowIsOpen(window)) {
        hpReadEvents();
        int width, height;
        hpWindowGetSize(window, &width, &height);

        printf("Window Size: {%i, %i}\n", width, height);

        hpWindowGetFramebufferSize(window, &width, &height);
        printf("Framebuffer size: {%i, %i}\n", width, height);
    }

    hpDestroyWindow(window);
}
