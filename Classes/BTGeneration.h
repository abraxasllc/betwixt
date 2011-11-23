//
//  Betwixt - Copyright 2011 Three Rings Design

#import <Foundation/Foundation.h>
#import "BTObject.h"

@interface BTGeneration : SPEventDispatcher {
@private
    BTObject *_head;
    NSMutableDictionary *_namedObjects;
}
- (void)addObject:(BTObject*)object;
- (BTObject*)objectForName:(NSString*)name;
- (void)removeObject:(BTObject*)object;
@end