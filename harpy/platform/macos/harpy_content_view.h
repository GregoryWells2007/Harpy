#pragma once
#import <AppKit/AppKit.h>

@interface HarpyContentView : NSView
@end

@implementation HarpyContentView
- (BOOL)acceptsFirstResponder {
    return YES;
}
@end
