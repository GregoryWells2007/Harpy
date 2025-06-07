#include "harpy_window.h"
#include "stdlib.h"
#import <AppKit/AppKit.h>

@interface HarpyWindowDelegate : NSObject <NSWindowDelegate>
@property (nonatomic, assign) struct hpWindow_t* window;
@end

struct hpWindow_t {
    NSWindow* window;
    HarpyWindowDelegate* delegate;
    int open;
}; // window structure

@implementation HarpyWindowDelegate
- (instancetype)init:(struct hpWindow_t *)initWindow
{
    self = [super init];
    _window = initWindow;
    return self;
}
- (void)windowWillClose:(NSNotification *)notification {
    _window->open = 0;
}
@end

hpWindow hpCreateWindow(int width, int height, const char* name) {
    hpWindow window = malloc(sizeof(struct hpWindow_t));

    window->delegate = [[HarpyWindowDelegate alloc] init:window];
    NSRect contentRect = NSMakeRect(100, 100, 640, 360);
    NSUInteger styleMask = NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable;

    window->window = [[NSWindow alloc]
        initWithContentRect:contentRect
        styleMask:styleMask
        backing:NSBackingStoreBuffered
        defer:NO
    ];

    [window->window setTitle:@"This is a test window name"];
    [window->window setDelegate:window->delegate];
    [window->window setAcceptsMouseMovedEvents:YES];
    [window->window setRestorable:NO];
    return window;
}

void hpReadEvents() {

}

int hpWindowIsOpen(hpWindow window) {
    return window->open;
}

void hpDestroyWindow(hpWindow window) {
    [window->window close];
    [window->window release];
}

void hpWindowGetSize(hpWindow window, int* width, int* height) {
    *width = window->window.frame.size.width;
    *height = window->window.frame.size.height;
}

void hpWindowGetFramebufferSize(hpWindow window, int* width, int* height) {
    CGFloat scale = [window->window backingScaleFactor];
    NSRect frame = [window->window frame];
    *width = frame.size.width * scale;
    *height = frame.size.height * scale;
}
