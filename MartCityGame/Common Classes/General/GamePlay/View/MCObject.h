//
//  MCObject.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 20/12/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MCCustomSpriteObject.h"

@class GameLogicLayer;
@interface MCObject : NSObject
{
    GameLogicLayer       *gameLogicLayer;
    MCCustomSpriteObject *objectSprite;
    int             width, height;
    BOOL            isObjectPlaced;
    CGPoint         touchPoint;
    BOOL            isObjectRotated;
    BOOL            isObjectPlaceable;
    int             timerCounts;

    
    int             coinsReqired;
    int             consumptionVariation;
    int             costPrice;
    int             sellingPrice;
    int             consumptionRate;
    
    NSString       *categoryName;
    NSString       *code;
    int             rotateCount;
    CCLabelTTF         *depletingLabel; //testing lx
    
    CGPoint         lowestPoint;
    CGRect          objectRect;
  
}
@property (nonatomic, assign) MCCustomSpriteObject   *objectSprite;
@property  int	width, height, coinsReqired, consumptionVariation, sellingPrice, costPrice, consumptionRate, itemsQuantity,rotateCount;
@property (nonatomic, retain) NSString       *categoryName, *code;
@property  BOOL isObjectPlaced, isObjectRotated, isObjectPlaceable;
@property (nonatomic, assign)CCLabelTTF *depletingLabel;
@property CGPoint lowestPoint;
@property CGRect objectRect;

- (void)createAsyncSprite:(CCTexture2D*)tex;
- (void)createAisleSpriteWithData:(NSDictionary *)objectDict andIndex:(int)index;
- (void)ObjectStatusUpdate;
- (void)updateAisleConsumptionRate;


/**
 * adding background to the object
 */
- (void)changeToRedLayer:(CGPoint)gridPosition;
- (void)changeToGreenLayer:(CGPoint)gridPosition;
- (void)hideBgImages;


@end
