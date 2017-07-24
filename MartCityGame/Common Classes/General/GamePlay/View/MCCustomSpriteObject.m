//
//  MCCustomSpriteObject.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 20/12/12.
//
//

#import "MCCustomSpriteObject.h"
#import "MCGameEngineController.h"

@implementation MCCustomSpriteObject
@synthesize parentObject;
//@synthesize isRotated;
/**
 *  initialization
 **/
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 *  dealloc
 **/
- (void) dealloc
{
	[super dealloc];
}


#pragma mark -
#pragma mark Touch_events
#pragma mark -
//- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//{
//	if ([MCGameEngineController sharedObject].backGroundScrollLayer.isZoomingStarted)
//		return NO;
//    return YES;
//}
//- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    
//}
//- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
//{
//}
//-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
//{
//}

@end
