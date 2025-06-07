#include "harpy_init.h"
#import "AppKit/AppKit.h"

@interface HarpyHelper : NSObject
@end

@implementation HarpyHelper

- (void)doNothing:(id)object
{
}

@end // GLFWHelper

void hpInit() {

    HarpyHelper* harpy = [[HarpyHelper alloc] init];

@autoreleasepool {

    [NSApplication sharedApplication];
    // if (![[NSRunningApplication currentApplication] isFinishedLaunching])
    //     [NSApp run];

    NSEvent* (^block)(NSEvent*) = ^ NSEvent* (NSEvent* event)
    {
        if ([event modifierFlags] & NSEventModifierFlagCommand)
            [[NSApp keyWindow] sendEvent:event];

        return event;
    };
}
}
