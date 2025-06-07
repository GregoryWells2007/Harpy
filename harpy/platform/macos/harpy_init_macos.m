#include "harpy_init.h"
#import "AppKit/AppKit.h"

@interface HarpyApplicationDelegate : NSObject <NSApplicationDelegate>
@end

@implementation HarpyApplicationDelegate
@end


typedef struct hpInstance {
    HarpyApplicationDelegate* delegate;
    CGEventSourceRef event_source;
} hpInstance_t;
hpInstance_t* instance;


void hpInit() {
    if (instance != NULL) return;
    instance = malloc(sizeof(hpInstance_t));

    @autoreleasepool {
    [NSApplication sharedApplication];

    instance->delegate = [[HarpyApplicationDelegate alloc] init];
    [NSApp setDelegate:instance->delegate];

    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [NSApp finishLaunching];
    [NSApp activateIgnoringOtherApps:YES];

    NSEvent* (^block)(NSEvent*) = ^ NSEvent* (NSEvent* event) {
        if ([event modifierFlags] & NSEventModifierFlagCommand)
            [[NSApp keyWindow] sendEvent:event];
        return event;
    };

    instance->event_source = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    CGEventSourceSetLocalEventsSuppressionInterval(instance->event_source, 0.0);
    }
}
