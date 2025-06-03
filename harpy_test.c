#include <harpy/harpy.h>
#include "stdio.h"

hpWindow window;

int main() {
    window = hpCreateWindow(640, 360, "Harpy window");

    while (hpWindowIsOpen(window)) {
        hpReadEvents();
    }

    hpDestroyWindow(window);
}
