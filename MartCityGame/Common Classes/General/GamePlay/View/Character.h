//
//  Character.h
//  MartCityGame
//
//  Created by Laxman Raju on 04/02/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constant_iPhone.h"
#import "CharacterSprite.h"
#import "MCImageCache.h"
#include "AStarCalculator.h"


typedef enum
{
    zCustomer = 0,
    zEmployee,
}CharacterTypeName;

typedef enum {
    zKidMale = 0,  //0_13
    zKidFemale,    //0_23
    zTeenMale,     //0_33
    zTeenFemale,   //0_43
    zOldLady,      //0_53
    zPunk,         //0_63
    zClean         // 0_cl1    //// to ber removed 19/02
}CustomerSubType;

typedef enum {
    zManager = 0,
    zCleaner,
    zSecurity,
    zCashier,
    zRegular 
}EmployeeSubType;
//AStarCalc *pathing
// pathing.Current <-set
// pathing.Destination <-set
// [pathing CalculatePath];
//insanity check
// if (pathing.pathCalculated)
// pathing.shortestPath <-Use the path  ^_^



@class GameLogicLayer;
@class MCObject;
@interface Character : NSObject<CCTargetedTouchDelegate>
{
    CharacterSprite         *characterSprite;
    GameLogicLayer          *gameLayer;
    Direction               direction, prevDirection, currentDirection, newDirection, targetedDirection, startingDirection;
    MCObject                *grid_Object;
    MCImageCache            *imageCache;
    CharacterActions        currAction, prevAction;
    CharacterAnimation      currAnimation;
    CharacterTypeName       characterTypeName;
    
    CGPoint                 sourceGridIndex, destinationGridIndex, destinationPosition, currentPosition, nextPosition, currGridPoint, nextGridPoint,position, currPoint, nextPoint, gridPoint_foreLook, gridPosition_foreLook;
    NSString                *imageName,*imageType,*characterName,*name;
    BOOL                    pauseCharacter, resumeCharacter, canWalk, currActionEnded, characterAtLastGridOfPath,characterUpdatingPath,characterWalking;
    
    NSMutableArray          *currTexturesArray;   //currStateImg
    AStarCalculator         *aStar;
    EmployeeSubType         empType;
    CustomerSubType         custType;
    
   
    
    int imagesCount, imageIndex, totalImageCount;
    int stepIndex;
    
    
}


@property (nonatomic, retain)NSMutableArray      *currTexturesArray;
@property (nonatomic) Direction                 startingDirection,currentDirection;
@property (nonatomic) CGPoint                   sourceGridIndex,position,destinationGridIndex;
@property (nonatomic, retain)CharacterSprite    *characterSprite;
@property (nonatomic, retain)MCObject           *grid_Object;
@property (nonatomic)CharacterActions           currAction;
@property (nonatomic)CharacterAnimation         currAnimation;
@property (nonatomic)CGPoint                    currPoint,nextPoint;
@property (nonatomic, retain)NSString           *imageName, *characterName, *imageType;
@property (nonatomic, assign)CharacterTypeName  characterTypeName;
@property (nonatomic, assign)EmployeeSubType    empType;
@property (nonatomic, assign)CustomerSubType    custType;
@property (nonatomic, assign)int                totalImageCount;
@property (nonatomic, retain)AStarCalculator    *aStar;
@property (nonatomic, assign)BOOL               currActionEnded;
@property (nonatomic, assign)BOOL               characterWalking;

/*!< initialize character method */
- (id)initWithParams:(GameLogicLayer *)layer characterName:(NSString *)characterName imageName:(NSString *)imageName;
- (void) initializeCharacter;

/*!< initialize Character Sprite */
-(void)createCharacter;

/*!< generate Employee avatar */

/*!< pause animation */
- (void)pause;

/*!< resume */
- (void)resume;

/*!< position setter and getter */
-(void) setPosition:(CGPoint)position;
- (CGPoint)position;

/*!< reorder Character Sprites */
- (void)reorderCharacterSprites;

/*!< setting next and current grid points */
- (void)setNewGridPoints;

/*!< updating characters */
- (void) updateCharacterAction;
- (void) TileMoveEnded;
- (void) setNextGrid;
- (int)  transformCharacter:(Direction)dir;
- (void) changeCharacterTextures;
- (void) setFrameIndex;
- (void) checkForNewAvatars;
- (void) updateAvatarDirection:(CGPoint)currPoint nextPoint:(CGPoint)nextPoint direction:(Direction)aDirection subDirection:(Direction) subDirection;
- (void) getTextures;
- (void) assignTextures:(NSMutableArray *)texArray;
- (void) setWalkingFramesArray:(NSMutableArray *)texArray;
- (void) createShortPathArrayFro;

- (void) moveCharacterToNextPoint;
- (void) movingDidEnd;
-(void)RecalculatePath;
- (void) currentActionDidEnd;
- (void) characterReachedEndOfpathAt:(CGPoint)characterPoint;

/*!< performing actions*/
- (void) randomWalkingCall;
- (void) walkToIdleActionCall;
- (void) idleToWalkActionCall;
- (void) idle1ActionCall;
- (void) idle2ActionCall;
- (void) freeLookCall;
- (void) browse1ActionCall;
- (void) browse2ActionCall;
- (void) cleaningActionCall;

/*!< animating the character*/
-(void)animateCharaterWithParametres:(NSString *)fileName FramesCount:(int)framesCnt andDelay:(float)aniDelay;

/*!< ggetting next grid pos for character to move */
- (CGPoint) getNextGridPosForCharacterAtGridPoint:(CGPoint)currGridPos;

/*!< get directions betweeen source and destination */
-(Direction) getDirectionBetweenCurrentPoint:(CGPoint)currentPoint_ andNextPoint:(CGPoint)nextpoint_ numberOfDirections:(int)directionsCount;


-(void)RecalculatePath;

@end
