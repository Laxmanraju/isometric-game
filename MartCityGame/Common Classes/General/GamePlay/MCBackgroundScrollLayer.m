//
//  MCBackgroundScrollLayer.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 07/12/12.
//
//

#import "MCBackgroundScrollLayer.h"
#import "MCGameEngineController.h"

@implementation MCBackgroundScrollLayer

@synthesize velocity;
@synthesize prevTouchPoint;
@synthesize isBounced;
@synthesize isZoomingStarted, isCanMove;
@synthesize touches = _touches;
/**
 * initializing the color of the background layer
 */

- (id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h
{
    self = [super initWithColor:color width:w height:h];
    if (self) {
        
        _deaccelerateInX = 5.0;
		_deaccelerateInY = 5.0;
        self.touches = [NSMutableArray arrayWithCapacity: 10];
		self.isTouchEnabled = NO;
    }
    return self;
}
/**
 *
 * stop scrolling action
 */

- (void)stopScrollingAction
{
    velocity = CGPointZero;
    startTouchTime = 0;
    timer = 0;
    isBounced = NO;
}

/**
 *
 * start scrolling action
 */

- (void)startScrollingEffect
{
	[self schedule:@selector(scrollLayer:) interval:1/60.0f];
}

- (void)scrollLayer:(ccTime)time
{
    if(!CGPointEqualToPoint(velocity,CGPointZero))
    {
        if (!startTouchTime) {
            velocity.y *= -1;
            velocity = ccpMult(velocity, 1/60);
        }
        startTouchTime++;
        if (startTouchTime-60 == 0) {
            timer++;
            startTouchTime = 1;
        }
        dt = (startTouchTime%5)?(dt+1):1;
        float x = (int)velocity.x==0?0:(velocity.x<0?-_deaccelerateInX/dt:_deaccelerateInX/dt);
        float y = (int)velocity.y==0?0:(velocity.y<0?-_deaccelerateInY/dt:_deaccelerateInY/dt);
        if(x == 0) {
            velocity.x = 0;
        }
        if(y == 0) {
            velocity.y = 0;
        }
        velocity = ccpSub(velocity, ccp(x,y));
        if (!isBounced) {
            CGPoint prevPoint =[[MCGameEngineController sharedObject]checkBoundaryConditionForPosition:ccpAdd(self.position, velocity) width:self.contentSize.width height:self.contentSize.height anchorPoint:self.anchorPoint andScale:self.scale];
            if (CGPointEqualToPoint(prevPoint, self.position)) {
				[self stopScrollingAction];
			}
        } else {
			[self stopScrollingAction];
		}
//		[[MCGameEngineController sharedObject] bounceBack:self];
	} else {
		[self stopScrollingAction];
	}
    
}

- (void) ccTouchesCancelled: (NSSet *) touches
				  withEvent: (UIEvent *) event
{
//    self.isZoomingStarted = NO;
	for (UITouch *touch in [touches allObjects])
	{
		// Remove touche from the array with current touches
		[self.touches removeObject: touch];
	}
}
@end
