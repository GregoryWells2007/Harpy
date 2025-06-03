#pragma once
typedef struct hpWindow_t* hpWindow;
hpWindow hpCreateWindow(int width, int height, const char* name);
int hpWindowIsOpen(hpWindow window);
void hpDestroyWindow(hpWindow window);
void hpReadEvents();
