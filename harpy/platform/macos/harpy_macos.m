#include "harpy_window.h"
#include "stdlib.h"
#import <AppKit/AppKit.h>

struct hpWindow_t {
    NSWindow* window;
    int open;
}; // window structure

@interface WindowWillCloseDelegate : NSObject <NSWindowDelegate>
@property (nonatomic, assign) struct hpWindow_t* window;
@end

@implementation WindowWillCloseDelegate
- (void)windowWillClose:(NSNotification *)notification {
    _window->open = 0;
}
@end

hpWindow hpCreateWindow(int width, int height, const char* name) {
    hpWindow window = malloc(sizeof(struct hpWindow_t));

    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

    NSScreen *mainScreen = [NSScreen mainScreen];
    NSRect screenRect = [mainScreen frame];

    NSRect frame = NSMakeRect(
        (screenRect.size.width / 2) - (width / 2.0f),
        (screenRect.size.height / 2) - (height / 2.0f),
        width, height);
    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable;

    window->window = [[NSWindow alloc] initWithContentRect:frame
                                                   styleMask:style
                                                     backing:NSBackingStoreBuffered
                                                       defer:NO];
    NSString* window_title = [NSString stringWithUTF8String:name];
    [window->window setTitle:window_title];
    [window->window makeKeyAndOrderFront:nil];
    WindowWillCloseDelegate *delegate = [[WindowWillCloseDelegate alloc] init];
    delegate.window = window;
    [window->window setDelegate:delegate];

    [NSApp activateIgnoringOtherApps:YES];
    window->open = 1;

    return window;
}

void hpReadEvents() {
    NSEvent *event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                          untilDate:[NSDate distantPast]
                                             inMode:NSDefaultRunLoopMode
                                            dequeue:YES];
    if (event) {
        [NSApp sendEvent:event];
        [NSApp updateWindows];
    }
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
