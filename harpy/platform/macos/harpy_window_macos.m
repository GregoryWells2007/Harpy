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

    // window->ns.view = [[GLFWContentView alloc] initWithGlfwWindow:window];
    // window->ns.scaleFramebuffer = wndconfig->scaleFramebuffer;

    // if (fbconfig->transparent)
    // {
    //     [window->ns.object setOpaque:NO];
    //     [window->ns.object setHasShadow:NO];
    //     [window->ns.object setBackgroundColor:[NSColor clearColor]];
    // }

    // [window->ns.object setContentView:window->ns.view];
    // [window->ns.object makeFirstResponder:window->ns.view];

    [window->window setTitle:@"This is a test window name"];
    [window->window setDelegate:window->delegate];
    [window->window setAcceptsMouseMovedEvents:YES];
    [window->window setRestorable:NO];

    @autoreleasepool {
    [window->window orderFront:nil];
    } // autoreleasepool

    window->open = YES;
    return window;
}

void hpReadEvents() {
    @autoreleasepool {
    for (;;)
    {
        NSEvent* event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                            untilDate:[NSDate distantPast]
                                               inMode:NSEventTrackingRunLoopMode
                                              dequeue:YES];
        if (event == nil)
            break;

        [NSApp sendEvent:event];
    }
    NSEvent* event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                        untilDate:[NSDate distantPast]
                                           inMode:NSDefaultRunLoopMode
                                          dequeue:YES];
    if (event)
        [NSApp sendEvent:event];

    [NSApp updateWindows];

    } // autoreleasepool
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
