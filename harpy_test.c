#include <harpy/harpy.h>
#include "stdio.h"
#include "stdlib.h"

hpWindow window;

int main() {
    hpInit();
    window = hpCreateWindow(640, 360, "Harpy window");

    while (hpWindowIsOpen(window)) {
        hpReadEvents();
        printf("Updating: %i\n", rand());
    }

    hpDestroyWindow(window);
}
