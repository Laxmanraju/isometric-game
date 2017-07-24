//
//  GameLogicLayer.h
//  MartCityGame
//
//  Created by Laxman Raju on 10/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MCTileSprite.h"
#import "Constant_iPhone.h"
#import "MCGameEngineController.h"
#import "MCServerHandlerConstants.h"
#import "GameConstants.h"

@class MCObject;
@class MCGameEngineController;
@class MCStoryBoardViewController;

@interface GameLogicLayer : CCLayerColor
{
   
    int     rows, initialRows,numberOfDecorBunsPopUps,columns, initialColumns; //Initial Row Column setUp
    
    CGPoint  startPoint;
    CGPoint  internalTIleIndex;
   
   
    
    CGRect      boundaryRect;
    MCObject	*selectedObject;
    MCGameEngineController *gameEngineController;
    MCStoryBoardViewController *storyBoardViewController;

    // This contains the grid : - cue tron music
    NSMutableArray *    arrExpRows;
    NSMutableArray *    m_arrGridSquares;
    
    //placed objects array
    NSMutableArray  *placedObjectsArray;
    
    //instance of Game mode
    GameMode  gameMode;
   MCTileSprite *closestTile;
    
    
    CCSprite *chara;
    bool  ExpandButtons;
  
    
    CCLabelTTF *label1;
    CCLabelTTF *label2;
    CCLabelTTF *label3;
    CCLabelTTF *label4;
    
    CGPoint a;
    CGPoint b;
    CGPoint c;
    CGPoint d;
   
}

@property (nonatomic, assign)  CGRect	           boundaryRect;
@property (nonatomic, retain)  MCObject           *selectedObject;

/*Grid stuff*/ 
@property (nonatomic, retain)  NSMutableArray     *arrExpRows;
@property (nonatomic, retain)  NSMutableArray     *m_arrGridSquares;
 //instance of Game mode
@property (nonatomic, assign)  GameMode			   gameMode;

/**
 * class method for shared object
 */
+ (GameLogicLayer *)sharedObject;

/**
 * basic game setup
 */
- (id) init;
- (void) initialSetUp;
- (void) initializeGameLogicLayer;
- (void) generateTiles;
- (void)defaultGameSetup;
- (NSArray *)getEntityItems:(int)index;
- (void)gameTimerStart;
- (void)updateAllObjectsTimer;


/**
 * object placement
 */
- (void)placeObjectInCorrectPos:(NSDictionary *)objectDict;
- (void)confirmObjectPosition;
- (void)setZorder;
- (void)rotateCurrentObject;




-(void)animateCharacter;

/**
 *object movement and screen movement
 */

- (void)objectTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)moveObject:(MCObject*)object fromLocation:(CGPoint)touchPoint withTouch:(UITouch*)touch;


/**
 *  grid caluculation
 */

- (CGPoint)getPosForGridRow:(int)row andColumn:(int)column;
- (CGPoint)getGridPointForPosition:(CGPoint)point;
- (BOOL)objectMovable:(CGPoint)currGridPos withObjectSize:(CGPoint)objectSize;
- (CGPoint)getObjectSize;
- (void)objectPlacementOnGrid:(CGPoint)touchPoint;


/**
 * Tile expansion
 */
-(void)ExpandGridFromRow:(int)startRow startingAtColumn:(int)startColumn by:(int)endRow rowsAndColumns:(int)endColumns;
-(void)ToggleExpandButtons;

/**
 * lowest point of object
 */
- (CGPoint)getLowestPointOfObject;

- (BOOL)checkForObjectIntersection:(int)row andColoumn:(int)coloumn;


#pragma  mark Character methods
/**
 * Setting Texture //lx
 */
- (void) setTextureForThirtyTwoBits;
- (void) setTextureForSixteenBits;
- (Character *)generateCharacterWithSourceIndex: (CGPoint)sourcePoint destinationIndex:(CGPoint)destinationPoint andDirection:(Direction)aDirection;
- (NSString *) getRandomCharacterName;
-(int)getCustomerType:(NSString *)customerName;

- (void)characterControl;

/**
 * asynch texture
 */
- (void)getTexturesSelector:(SEL)sel forTarget:(Character*)target withObject:(id)object;
- (void)tex:(CSAsyncObject*)asyncObject;
- (void)getTextures:(CSAsyncObject*)asyncObject;

@end



