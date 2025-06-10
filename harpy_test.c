#include <harpy/harpy.h>
#include "stdio.h"
#include "stdlib.h"

hpWindow window, otherWindow;

int main() {
    hpInit();
    window = hpCreateWindow(640, 360, "Harpy window");
    otherWindow = hpCreateWindow(100, 100, "Other window");

    while (hpWindowIsOpen(window)) {
        hpReadEvents();
        // printf("Updating: %i\n", rand());
    }

    hpDestroyWindow(window);
    hpClose();
}
