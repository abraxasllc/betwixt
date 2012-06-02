//
// Betwixt - Copyright 2012 Three Rings Design

#import "BTObject.h"

@class BTEventSignal;

/// A BTObject that wraps an SPDisplayObject
@interface BTViewObject : BTObject

@property (nonatomic,readonly) SPDisplayObject* display; // abstract

@property (nonatomic,readonly) BTEventSignal* touchEvent;  // <SPTouchEvent>
@property (nonatomic,readonly) RAObjectSignal* touchBegan; // <SPTouch>
@property (nonatomic,readonly) RAObjectSignal* touchMoved; // <SPTouch>
@property (nonatomic,readonly) RAObjectSignal* touchStationary; // <SPTouch>
@property (nonatomic,readonly) RAObjectSignal* touchEnded; // <SPTouch>
@property (nonatomic,readonly) RAObjectSignal* touchCanceled; // <SPTouch>

+ (BTViewObject*)viewObjectWithDisplay:(SPDisplayObject*)disp;

@end
