#include <harpy/harpy.h>
// #include "stdio.h"
// #include "stdlib.h"

hpWindow window;

int main() {
    hpInit();

    hpWindowProperties props = {
        .resizable = HP_FALSE
    };
    window = hpCreateWindowWithProperties(640, 360, "Harpy window", props);

    while (hpWindowIsOpen(window))
        hpReadEvents();

    hpDestroyWindow(window);
    hpClose();
}
