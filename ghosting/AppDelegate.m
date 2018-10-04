//
//  AppDelegate.m
//  ghosting
//
//  Created by George Nachman on 10/3/18.
//  Copyright © 2018 George Nachman. All rights reserved.
//

#import "AppDelegate.h"

@interface ContentView : NSView
@end

@interface TextView : NSView
- (void)rotateString;
@end

@implementation ContentView {
    TextView *_textView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _textView = [[TextView alloc] initWithFrame:self.frame];
        [self addSubview:_textView];
        [NSTimer scheduledTimerWithTimeInterval:0.25 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self->_textView rotateString];
            [self->_textView setNeedsDisplay:YES];
        }];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor clearColor] set];
    NSRectFill(dirtyRect);
}

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize {
    [super resizeSubviewsWithOldSize:oldSize];
    _textView.frame = self.bounds;
}

@end


@implementation TextView {
    NSString *_string;
}

- (void)rotateString {
    _string = @"";
    int count = arc4random_uniform(80);
    for (int i = 0; i < count; i++) {
        _string = [_string stringByAppendingString:@"x"];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor colorWithRed:1 green:1 blue:1 alpha:0.25] set];
    NSRectFill(dirtyRect);
    
    [[NSColor blackColor] set];
    [_string drawAtPoint:NSMakePoint(100, 100) withAttributes:nil];
}

@end

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.window.opaque = NO;
    self.window.backgroundColor = [NSColor clearColor];
    self.window.contentView = [[ContentView alloc] init];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
