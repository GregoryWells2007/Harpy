#pragma once
typedef struct hpWindow_t* hpWindow;
hpWindow hpCreateWindow(int width, int height, const char* name);
int hpWindowIsOpen(hpWindow window);
void hpDestroyWindow(hpWindow window);
void hpReadEvents();
void hpWindowGetSize(hpWindow window, int* width, int* height);
void hpWindowGetFramebufferSize(hpWindow window, int* width, int* height);
