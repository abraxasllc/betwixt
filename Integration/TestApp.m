//
// Betwixt - Copyright 2012 Three Rings Design

#import "TestApp.h"
#import "BTApp+Protected.h"
#import "SubObjectMode.h"
#import "PlayMovieMode.h"
#import "NamedNodeMode.h"
#import "MoveMode.h"
#import "RepeatingMode.h"
#import "Square.h"
#import "SelfRemoveMode.h"
#import "BTModeStack.h"
#import "GroupTestMode.h"
#import "LeakTestMode.h"
#import "FlipbookMode.h"
#import "MovieTestMode.h"

#import "BTLoadingMode.h"

@interface LoadingMode : BTLoadingMode
@end

@implementation LoadingMode

- (void)setup {
    [self addFiles:@[
        @"iPhone/squaredance/resources.xml",
        @"iPhone/guybrush/resources.xml"
    ]];
    [self.loadComplete connectUnit:^{
        [self.modeStack changeMode:[[FlipbookMode alloc] init]];
        [self.modeStack pushMode:[[NamedNodeMode alloc] init]];
        [self.modeStack pushMode:[[MoveMode alloc] init]];
        [self.modeStack pushMode:[[SelfRemoveMode alloc] init]];
        [self.modeStack pushMode:[[PlayMovieMode alloc] init]];
        [self.modeStack pushMode:[[RepeatingMode alloc] init]];
        [self.modeStack pushMode:[[SubObjectMode alloc] init]];
        [self.modeStack pushMode:[[GroupTestMode alloc] init]];
        [self.modeStack pushMode:[[LeakTestMode alloc] init]];
    }];
}

@end

@implementation TestApp

- (void)run:(BTModeStack *)defaultStack {
    [defaultStack pushMode:[[LoadingMode alloc] init]];
}

- (NSString*)resourcePathPrefix {
    return @"rsrc/";
}

@end
