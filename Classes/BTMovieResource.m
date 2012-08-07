//
// Betwixt - Copyright 2012 Three Rings Design

#import "BTMovieResource.h"
#import "BTMovieResourceLayer.h"
#import "BTMovieResourceKeyframe.h"
#import "BTResourceFactory.h"
#import "BTMovie.h"
#import "BTMovie+Package.h"
#import "GDataXMLNode+BTExtensions.h"
#import "BTApp.h"
#import "BTResourceManager.h"
#import "BTDeviceType.h"

@interface BTMovieResourceFactory : NSObject<BTResourceFactory>
@end

@implementation BTMovieResource

- (id)initFromXml:(GDataXMLElement*)xml {
    if ((self = [super init])) {
        _layers = [[NSMutableArray alloc] init];
        int numFrames = 0;

        _framerate = [xml floatAttribute:@"frameRate" defaultVal:30];

        NSArray* layerEls = [xml elementsForName:@"layer"];

        if ([[layerEls objectAtIndex:0] boolAttribute:@"flipbook" defaultVal:NO]) {
            BTMovieResourceLayer* layer =
            [[BTMovieResourceLayer alloc] initFlipbookNamed:[xml stringAttribute:@"name"]
                                                        xml:[layerEls objectAtIndex:0]];
            [_layers addObject:layer];
            numFrames = layer.numFrames;
        } else {
            for (GDataXMLElement* layerEl in layerEls) {
                BTMovieResourceLayer* layer = [[BTMovieResourceLayer alloc] initWithXml:layerEl];
                [_layers addObject:layer];
                numFrames = MAX(numFrames, layer.numFrames);
            }
        }

        _labels = [[NSMutableArray alloc] initWithCapacity:numFrames];
        for (int ii = 0; ii < numFrames; ii++) {
            [_labels insertObject:[[NSMutableArray alloc] init] atIndex:ii];
            if (ii == 0 || ii == numFrames - 1) {
                NSString* label = ii == 0 ? BTMovieFirstFrame : BTMovieLastFrame;
                [[_labels lastObject] addObject:label];
            }
        }
        for (BTMovieResourceLayer* layer in _layers) {
            for (BTMovieResourceKeyframe* kf in layer->keyframes) {
                if (kf->label) [[_labels objectAtIndex:kf->index] addObject:kf->label];
            }
        }
    }
    return self;
}

- (BTMovie*)newMovie {
    return [[BTMovie alloc] initWithFramerate:_framerate layers:_layers labels:_labels];
}

- (SPDisplayObject*)createDisplayObject { return [self newMovie]; }

+ (id<BTResourceFactory>)sharedFactory {
    return OOO_SINGLETON([[BTMovieResourceFactory alloc] init]);
}

+ (BTMovieResource*)require:(NSString*)name {
    return [BTApp.resourceManager requireResource:name ofType:[BTMovieResource class]];
}

+ (BTMovie*)newMovie:(NSString*)name {
    return [[BTMovieResource require:name] newMovie];
}

@end


@implementation BTMovieResourceFactory

- (BTResource*)create:(GDataXMLElement*)xml {
    return [[BTMovieResource alloc] initFromXml:xml];
}

@end
