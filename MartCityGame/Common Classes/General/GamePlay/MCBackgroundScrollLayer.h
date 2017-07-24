//
//  MCBackgroundScrollLayer.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 07/12/12.
//
//
#import "cocos2d.h"
#import "CCLayer.h"

@interface MCBackgroundScrollLayer : CCLayerColor
{
    CGPoint velocity,dragPoint;
    CGPoint prevTouchPoint;
    float moveValueX, moveValueY, _deaccelerateInX, _deaccelerateInY, dt;
    int startTouchTime, endTouchTime, timer;
    BOOL isBounced;
    BOOL isZoomingStarted, isCanMove;
    NSMutableArray *_touches;
}

@property (nonatomic, assign) BOOL   isZoomingStarted, isCanMove;
@property (nonatomic, assign)CGPoint velocity;
@property (nonatomic, assign)CGPoint prevTouchPoint;
@property (nonatomic, assign)BOOL isBounced;
@property (nonatomic, retain) NSMutableArray *touches;

/**
 * initializing the color of the background layer
 */
- (id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h;
/**
 *
 * start scrolling action
 */
- (void)startScrollingEffect;
/**
 *
 * stop scrolling action
 */
- (void)stopScrollingAction;
/**
 *
 * start scrolling action
 */

- (void)startScrollingEffect;
- (void)scrollLayer:(ccTime)time;
@end
