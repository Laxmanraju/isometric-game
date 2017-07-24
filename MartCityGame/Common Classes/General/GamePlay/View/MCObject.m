 //
//  MCObject.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 20/12/12.
//
//

#import "MCObject.h"
#import "GameLogicLayer.h"

@implementation MCObject
@synthesize objectSprite;
@synthesize width,height,coinsReqired, consumptionVariation, sellingPrice, costPrice, consumptionRate, itemsQuantity,rotateCount, categoryName,code;
@synthesize isObjectPlaced, isObjectRotated, isObjectPlaceable,lowestPoint;
@synthesize depletingLabel;
@synthesize objectRect;

// IMAGES NAME.....
#define		REDTRANPARENT_IMAGE                 @"red_1x1.png"
#define		GREENTRANSPARENT_IMAGE              @"green_1x1.png"
#define     GREENSPRITE_TAG                          11111
#define     REDSPRITE_TAG                            22222


- (id)init
{
    self = [super init];
    if (self)
    {
        width = 165;
        height = 188;
        gameLogicLayer	= [GameLogicLayer sharedObject];
        isObjectPlaceable = NO;
        [self createBgObject];
    }
    return self;
}

- (void)dealloc
{
    [gameLogicLayer release];
    [super dealloc];
}

- (void)createAsyncSprite:(CCTexture2D*)tex
{
    self.objectSprite = [MCCustomSpriteObject spriteWithFile:@"DairyAisle_v01.png"];
    self.isObjectRotated = NO;
    objectSprite.parentObject = self;
    objectSprite.anchorPoint = ccp(0, 0);
    objectSprite.opacity = 60;
    objectSprite.position = ccp(gameLogicLayer.contentSize.width / 2, gameLogicLayer.contentSize.height / 2);
    [gameLogicLayer addChild:objectSprite];
    
   
    
    

}
- (void)createBgObject
{
    
    CCSprite *redSprite = [CCSprite spriteWithFile:REDTRANPARENT_IMAGE];
    redSprite.scale = 2;
    redSprite.tag = REDSPRITE_TAG;
    [gameLogicLayer addChild:redSprite z:10000000000];
    redSprite.visible = NO;
    
 
    CCSprite *greenSprite = [CCSprite spriteWithFile:GREENTRANSPARENT_IMAGE];
    greenSprite.scale = 2;
    greenSprite.tag = GREENSPRITE_TAG;
    [gameLogicLayer addChild:greenSprite z:10000000000];
    greenSprite.visible = NO;
   
    
}

- (void)createAisleSpriteWithData:(NSDictionary *)objectDict andIndex:(int)index
{
    NSLog(@"%@", objectDict);
    self.coinsReqired = [[objectDict objectForKey:@"cost"] intValue];
  NSLog(@"%d", coinsReqired);
//    NSString *ratioString =  [objectDict objectForKey:@"consumptionRatio"];
//    NSArray *chunks = [ratioString componentsSeparatedByString: @":"];
    //    self.consumptionRate = [[objectDict objectForKey:@"consumptionRate"] intValue];
    self.coinsReqired           = [[objectDict objectForKey:@"cost"] intValue];
    self.consumptionVariation   = [[objectDict objectForKey:@"baseConsumption"] intValue];
    self.itemsQuantity          = [[objectDict objectForKey:@"quantity"] intValue];
    self.costPrice              = [[objectDict objectForKey:@"cost"]intValue];
    NSString *imageName         = [NSString stringWithFormat:@"%@_0.png",[objectDict objectForKey:@"code"]];
    self.objectSprite           = [MCCustomSpriteObject spriteWithFile:imageName];
    
    self.categoryName           = [objectDict objectForKey:@"categoryCode"];    
    self.code                   = [objectDict objectForKey:@"code"];
    self.width                  = [[objectDict objectForKey:@"width"]intValue];
    self.height                 = [[objectDict objectForKey:@"height"]intValue];
    self.isObjectRotated        = NO;
    self.rotateCount            = 0;
    self.lowestPoint            = ccp(self.objectSprite.position.x + _TILE_WIDTH/2, self.objectSprite.position.y+_TILE_HEIGHT/2);

    NSLog(@"cost %d", self.costPrice);
    objectSprite.parentObject = self;
    objectSprite.anchorPoint = ccp(0, 0);
    objectSprite.opacity = 60;
    objectSprite.position = ccp(gameLogicLayer.contentSize.width / 2, gameLogicLayer.contentSize.height / 2);
    [gameLogicLayer addChild:objectSprite];
    
    if (!self.depletingLabel) {
        self.depletingLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", itemsQuantity] fontName:@"Marker Felt" fontSize:30];
    }
    depletingLabel.position = CGPointMake(self.objectSprite.position.x, self.objectSprite.position.y+30);
   
    [gameLogicLayer addChild:self.depletingLabel z:1000000000];


}

- (void) ObjectStatusUpdate
{
    
}

- (void)updateAisleConsumptionRate
{
    NSLog(@"%d %d %d",self.costPrice, self.sellingPrice, self.consumptionVariation);
    int priceDifference = self.costPrice - self.sellingPrice;
    if (priceDifference>0)
    {
        self.consumptionRate =(self.consumptionVariation+priceDifference);
    }
    else if(priceDifference < 0)
    {
        self.consumptionRate = (self.consumptionVariation+priceDifference);
    }else {
        self.consumptionRate = self.consumptionVariation;
    }
    
    NSLog(@"cr =%d cv = %d cp = %d sp = %d", consumptionRate, consumptionVariation, costPrice, sellingPrice);
}

- (void)changeToRedLayer:(CGPoint)gridPosition
{
    [gameLogicLayer getChildByTag:GREENSPRITE_TAG].visible = NO;
    CCSprite *sprite = (CCSprite *)[gameLogicLayer getChildByTag:REDSPRITE_TAG];
    sprite.visible = YES;
    sprite.position = gridPosition;
}

- (void)changeToGreenLayer:(CGPoint)gridPosition
{
    [gameLogicLayer getChildByTag:REDSPRITE_TAG].visible = NO;
    CCSprite *sprite = (CCSprite *)[gameLogicLayer getChildByTag:GREENSPRITE_TAG];
    sprite.visible = YES;
    sprite.position = gridPosition;

}

- (void)hideBgImages
{
    [gameLogicLayer getChildByTag:GREENSPRITE_TAG].visible = NO;
    [gameLogicLayer getChildByTag:REDSPRITE_TAG].visible = NO;
}
@end
