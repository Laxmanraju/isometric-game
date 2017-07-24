//
//  Character.m
//  MartCityGame
//
//  Created by Laxman Raju on 04/02/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "GameLogicLayer.h"
#import "CharacterController.h"

@implementation Character

@synthesize         characterSprite;
@synthesize         startingDirection,currentDirection;
@synthesize         sourceGridIndex, position, destinationGridIndex;
@synthesize         grid_Object;
@synthesize         currAction;
@synthesize         currAnimation;
@synthesize         currPoint, nextPoint;
@synthesize         imageName, characterName,imageType, characterTypeName, empType, custType;
@synthesize         currTexturesArray;
@synthesize         totalImageCount;
@synthesize         aStar;
@synthesize         currActionEnded,characterWalking;

-(id)initWithParams:(GameLogicLayer *)layer characterName:(NSString *)characterName_ imageName:(NSString *)imageName_
{
    if (self = [super init])
    {
        gameLayer                   = layer;
        direction= startingDirection= DOWN_LEFT;
        currAnimation               = WALKING_ANI;
        pauseCharacter              = NO;
        canWalk                     = YES;
        characterAtLastGridOfPath   = NO;
        currActionEnded             = YES;
        self.characterName          = characterName_;
        NSLog(@"char name = %@", characterName_);
        self.imageType              = imageName_;
        self.imageName              = imageName_,
        imageCache                  = [MCImageCache sharedMCImageCache];
        currTexturesArray           = [[NSMutableArray alloc]init];
        imageIndex                  = 1;
      
        aStar = [[AStarCalculator alloc] init];
        [self createCharacter];
       [self createShortPathArrayFro];      
    }
    return  self;
}

-(void) createCharacter
{
    NSString *emptyImage    = [[NSString alloc] initWithFormat:@"startUpAvatarImage.png"];
    CCTexture2D *zTexture   = [[CCTexture2D alloc]initWithImage:[UIImage imageNamed:emptyImage]];
    [gameLayer setTextureForThirtyTwoBits];
    self. characterSprite   = [CharacterSprite spriteWithTexture: zTexture];
    [zTexture release];
    [emptyImage release];
    [gameLayer setTextureForSixteenBits];
}

-(void) initializeCharacter
{
    
    newDirection = direction = startingDirection;
    
    currGridPoint = sourceGridIndex;
    currentPosition = [gameLayer getPosForGridRow:sourceGridIndex.x andColumn:sourceGridIndex.y];
//    nextPosition = [gameLayer getPosForGridRow:nextGridPoint.x andColumn:nextGridPoint.y];
/*!<original*/    direction = [self getDirectionBetweenCurrentPoint:currGridPoint andNextPoint:nextGridPoint numberOfDirections:CHARACTER_DIRECTIONS_EIGHT];
    
///*!< test*/    direction = 7;  //// <! lx change for testing initial direction for non movement char 19/2
    
//    NSLog(@"direction=%d at func %s",direction, __func__);
//    gridPoint_foreLook = [self getNextGridPosForCharacterAtGridPoint:nextGridPoint];
//    gridPosition_foreLook = [gameLayer getPosForGridRow:gridPoint_foreLook.x andColumn:gridPoint_foreLook.y];
    
//    destinationPosition = [gameLayer getPosForGridRow:destinationPosition.x andColumn:destinationPosition.y];
//    self.characterSprite.scale = 1;
    
//    currentDirection = direction;  ///lx 08/03
    
    self.characterSprite.anchorPoint = ccp(0.5, 0.25);
    CGPoint zOrderPoint = [gameLayer getGridPointForPosition:characterSprite.position];
    int zOrder = zOrderPoint.x+zOrderPoint.y;
    [gameLayer addChild:self.characterSprite z:zOrder+10000000000000000];
    [self.characterSprite setPosition: currentPosition];
    
}

- (void)createShortPathArrayFro
{
    NSLog(@"%s",__func__);
    aStar.fromTileCoor = ccp(0, 0); /*<! change this to entrance door point grid */
    CGPoint tPoint = ccp(gameLayer.selectedObject.lowestPoint.x-_TILE_WIDTH/2, gameLayer.selectedObject.lowestPoint.y-_TILE_HEIGHT/2);
    aStar.toTileCoord  = [gameLayer getGridPointForPosition:tPoint];
    NSLog(@"xxx%@",NSStringFromCGPoint(aStar.toTileCoord));
    [aStar CalculatePath];
    if (self.aStar.pathCalculated)
    {
        self.characterSprite.pathArrayFro = self.aStar.shortestPath;
    }    
    stepIndex =0;
}

- (CGPoint) getNextGridPosForCharacterAtGridPoint:(CGPoint)currGridPos
{
     NSLog(@"%s",__func__);
      if (self.aStar.pathCalculated) {
         
          if (self.aStar.shortestPath )
          {
              CGPoint nextGrid;
             if ((stepIndex <[aStar.shortestPath count]))
              {
                  nextGrid = CGPointFromString([aStar.shortestPath objectAtIndex:stepIndex])  ;
                  stepIndex++;
                  NSLog(@"stepIndex = %d", stepIndex);
                  return CGPointMake(nextGrid.x, nextGrid.y);
              }
             
          }
    }
    return gridPoint_foreLook;
//    if (self.aStar.pathCalculated) {
//        if (self.aStar.shortestPath && (stepIndex < [aStar.shortestPath count]))
//        {
//            CGPoint nextGrid = CGPointFromString([self.characterSprite.pathArrayFro objectAtIndex:stepIndex])  ;
//            stepIndex++;
//            return CGPointMake(nextGrid.x, nextGrid.y);
//        }
//    }
//    return gridPoint_foreLook;

}

-(Direction) getDirectionBetweenCurrentPoint:(CGPoint)currentPoint_ andNextPoint:(CGPoint)nextpoint_ numberOfDirections:(int)directionsCount
{
    Direction *nxtDirection = startingDirection;  // lx if no direction is specified in non-movable actions assiginin startinDir ...testing ourpse
    if(nextpoint_.x<currentPoint_.x)
    {
        if (currentPoint_.y>nextpoint_.y)
        {
            nxtDirection = UP;
        }
        else if (currentPoint_.y<nextpoint_.y)
        {
            nxtDirection = RIGHT;
        }
        else
        {
            nxtDirection = UP_RIGHT;
        }
    }
    else if(nextpoint_.x>currentPoint_.x)
    {
        if (currentPoint_.y>nextpoint_.y)
        {
            nxtDirection = LEFT;
        }
        else if(currentPoint_.y<nextpoint_.y)
        {
            nxtDirection = DOWN;
        }
        else
        {
            nxtDirection = DOWN_LEFT;
        }
    }
    else if(nextpoint_.x == currentPoint_.x)
    {
        if (currentPoint_.y < nextpoint_.y)
        {
            nxtDirection = DOWN_RIGHT;
        }
        else if (currentPoint_.y > nextpoint_.y)
        {
            nxtDirection = UP_LEFT;
        }
       
    }
//    else
//        nxtDirection = DOWN; ///lx to prevent it from being non zero 19/2  // 08/03
    return nxtDirection;
}

#pragma mark -
#pragma mark ACTION_CALLS
#pragma mark -

-(void)randomWalkingCall
{
    if (!pauseCharacter) {
    currAnimation =  WALKING_ACTION;
       
    [self moveCharacterToNextPoint];
    [self reorderCharacterSprites];
    [self changeCharacterTextures];
    totalImageCount = WALK_FRAME_COUNT;
    [self checkForNewAvatars];
        
    }
}


- (void)moveCharacterToNextPoint
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    
    if (!characterWalking  && aStar.pathCalculated)
    {
        
        characterWalking = YES;
        NSLog(@"currpos = %@ nextpo = %@",NSStringFromCGPoint(currGridPoint),NSStringFromCGPoint(nextGridPoint));
        
        [self setNextGrid];      
        [self setNewGridPoints];
        NSLog(@"path array = %@", aStar.shortestPath);
        NSLog(@"after settinggrids currpos = %@ nextpo = %@",NSStringFromCGPoint(currGridPoint),NSStringFromCGPoint(nextGridPoint));
        direction = [self getDirectionBetweenCurrentPoint:currGridPoint andNextPoint:nextGridPoint numberOfDirections:CHARACTER_DIRECTIONS_EIGHT];
        [self transformCharacter:direction];
        
        CCMoveTo *ccMove = [CCMoveTo actionWithDuration:2.5 position:nextPosition];
        CCCallFunc *callFunc = [CCCallFunc actionWithTarget:self selector:@selector(TileMoveEnded)];
        CCSequence *seqFro = [CCSequence actions:ccMove,callFunc, nil];
        [self.characterSprite runAction:seqFro];
        
    }
    [pool release];
}

- (void) TileMoveEnded
{
    characterWalking =NO;
    //    NSLog(@"currpos = %@ nextpo = %@ foregrid = %@",NSStringFromCGPoint(currGridPoint),NSStringFromCGPoint(nextGridPoint), NSStringFromCGPoint(gridPoint_foreLook));
    CGPoint lastPoint =CGPointFromString([aStar.shortestPath lastObject]);
    if (stepIndex == [aStar.shortestPath count] && (CGPointEqualToPoint(lastPoint,gridPoint_foreLook)))
    {
        [self characterReachedEndOfpathAt:CGPointFromString([aStar.shortestPath lastObject])];
    }
}


- (void)cleaningActionCall
{
    currAnimation = CLEAN_ACTION;
    [self moveCharacterToNextPoint];
    [self reorderCharacterSprites];
    [self changeCharacterTextures];
    totalImageCount = CLEANING_FRAME_COUNT;
    [self checkForNewAvatars];
}


- (void)walkToIdleActionCall
{
    
}


- (void)idleToWalkActionCall
{
    
}


- (void)idle1ActionCall
{
    if (currActionEnded == YES)
    {
        currAnimation = IDLE1_ACTION;
        currActionEnded = NO;
        //         NSString *fileName = [NSString stringWithFormat:@"%@_%d_1",characterName,currAction];
        [self transformCharacter:direction];
        totalImageCount = IDLE1_FRAME_COUNT;
        [self checkForNewAvatars];
        [self performSelector:@selector(currentActionDidEnd) withObject:self afterDelay:3.6];
    }
    [self changeCharacterTextures];
}


- (void)idle2ActionCall
{
    if (currActionEnded == YES)
    {
        currAnimation = IDLE2_ACTION;
        currActionEnded = NO;
        //         NSString *fileName = [NSString stringWithFormat:@"%@_%d_1",characterName,currAction];
        [self transformCharacter:direction];
        totalImageCount = IDLE2_FRAME_COUNT;
        [self checkForNewAvatars];
        [self performSelector:@selector(currentActionDidEnd) withObject:self afterDelay:2];
    }
    [self changeCharacterTextures];

}



- (void)freeLookCall
{
    if (currActionEnded == YES)
    {        
        currAnimation = LOOK_ANI;
        currActionEnded = NO;
        
        //         NSString *fileName = [NSString stringWithFormat:@"%@_%d_1",characterName,currAction];
        [self transformCharacter:direction];
        totalImageCount = LOOK_FRAME_COUNT;
        [self checkForNewAvatars];
        [self performSelector:@selector(currentActionDidEnd) withObject:self afterDelay:2];
        //        [self animateCharaterWithParametres:fileName FramesCount:12 andDelay:0.2];
    }
    [self changeCharacterTextures];
    
}



- (void) browse1ActionCall
{
    if (currActionEnded == YES)
    {
        currAnimation = BROWSE1_ANI;
        currActionEnded = NO;
        [self transformCharacter:direction];
        totalImageCount = BROWSE1_FRAME_COUNT;
        [self checkForNewAvatars];
        [self performSelector:@selector(currentActionDidEnd) withObject:self afterDelay:3.5];

    }
    [self changeCharacterTextures];
}


- (void) browse2ActionCall
{
    if (currActionEnded == YES)
    {
        currAnimation = BROWSE2_ANI;
        currActionEnded = NO;
        [self transformCharacter:direction];
        totalImageCount = BROWSE2_FRAME_COUNT;
        [self checkForNewAvatars];
        [self performSelector:@selector(currentActionDidEnd) withObject:self afterDelay:4.2];

    }
    [self changeCharacterTextures];
}

#pragma  mark -
#pragma mark UPDATING GRIDS AND DIRECTIONS
#pragma  mark -

- (void)setNewGridPoints
{
    currGridPoint = nextGridPoint;
    currentPosition = nextPosition;
    nextGridPoint = gridPoint_foreLook;
    nextPosition = gridPosition_foreLook;
}


- (int)transformCharacter:(Direction)dir
{
//    NSLog(@"transformchar dir =%d", dir);
    int subDir = 0;  //making it non zero at start and 1 for default
    
    switch (dir) {
        case RIGHT:
            self.characterSprite.scaleX = 1.0f;
            subDir = RIGHT;//LEFT;
            break;
        case LEFT:
            self.characterSprite.scaleX = -1.0f;
            subDir = RIGHT;//LEFT;
            break;
        case UP:
            self.characterSprite.scaleX = 1.0f;
            subDir = UP;
            break;
        case DOWN:
            self.characterSprite.scaleX = 1.0f;
            subDir = DOWN;
            break;
        case UP_RIGHT:
            self.characterSprite.scaleX = 1.0f;
            subDir = UP_RIGHT;
            break;
        case UP_LEFT:
            self.characterSprite.scaleX = -1.0f;
            subDir = UP_RIGHT;
            break;
        case DOWN_RIGHT:
            self.characterSprite.scaleX = 1.0f;
            subDir = DOWN_RIGHT;
            break;
        case DOWN_LEFT:
            self.characterSprite.scaleX = -1.0f;
            subDir = DOWN_RIGHT;
            break;
            
        default:
            break;
    }
    NSLog(@"subDir %d", subDir);
    return subDir;    
}

- (void) setNextGrid
{
    gridPoint_foreLook = [self getNextGridPosForCharacterAtGridPoint:nextGridPoint];
    NSLog(@"gridpoiunt_forelook %@",NSStringFromCGPoint(gridPoint_foreLook));
    gridPosition_foreLook = [gameLayer getPosForGridRow:gridPoint_foreLook.x andColumn:gridPoint_foreLook.y];
}

-(void) changeCharacterTextures /// assigning new frame
{
    if (!pauseCharacter)
    {
   
    [self setFrameIndex];
//    NSLog(@"imageindx = %d", imageIndex);
//    NSLog(@"textureArray cnt = %d at %s",[self.currTexturesArray count], __func__);
    if (([self.currTexturesArray count]<= imageIndex)|| ![self.currTexturesArray count])
    {
        return;
    }
       
//        NSLog(@"imgeindx= %d",imageIndex);
    CCSpriteFrame *frame = [self.currTexturesArray objectAtIndex:imageIndex];
    
    CGRect rect = [frame rect];
    rect.size = frame.originalSizeInPixels;
    self.characterSprite.textureRect = rect;
    [self.characterSprite setDisplayFrame:frame];
        
    }
}

-(void) setFrameIndex
{
    if (currAction ==  WALKING_ACTION) {
        if (!aStar.pathCalculated) {
            NSLog(@"**path not calculted-frames not incrementing in %s**", __func__);
            return;
        }
    }
    
    if (self.currTexturesArray)
    {
        imagesCount = [self.currTexturesArray count]-1;
        imageIndex++;
        if (imageIndex >imagesCount)
        {
            imageIndex = 0;
        }
    }
}

- (void)reorderCharacterSprites
{
    NSLog(@"charactePos %@", NSStringFromCGPoint(characterSprite.position));
    if (self.characterSprite)
    {
        CGPoint zValue = [gameLayer getGridPointForPosition:self.characterSprite.position];
        zValue = ccp(zValue.x+1, zValue.y+1);
        int zOrder = (zValue.x+zValue.y);
        [gameLayer reorderChild:self.characterSprite z:zOrder*5];
    }
}

- (void) checkForNewAvatars
{    
    switch (currAction) {
        case WALKING_ACTION:
            if (direction != prevDirection) // != original
            {
                [self updateAvatarDirection:currGridPoint nextPoint:nextGridPoint direction:direction subDirection:1]; // "direction" is changed in movingCharacterToNextPoint
            }
            break;
            
        case WALK_IDLE_ACTION:
            [self getTextures];
            break;
            
        case IDLE_WALK_ACTION:
            [self getTextures];
            break;
            
        case CLEAN_ACTION:
            if (direction != prevDirection) // != original
            {
                [self updateAvatarDirection:currGridPoint nextPoint:nextGridPoint direction:direction subDirection:1]; // "direction" is changed in movingCharacterToNextPoint
            }
            break;
    
        case LOOK_ACTION:
            if (currentDirection == 0) {
                
            }
            [self getTextures];
            break;
         
        case IDLE1_ACTION:
            [self getTextures];
            break;
            
        case IDLE2_ACTION:
            [self getTextures];
            break;
            
        case BROWSE1_ACTION:
            [self getTextures];
            break;
            
        case BROWSE2_ACTION:
            [self getTextures];
            break;
            
        default:
            break;
    }
    
}

-(void) updateAvatarDirection:(CGPoint)currPoint nextPoint:(CGPoint)nextPoint direction:(Direction)aDirection subDirection:(Direction)subDirection
{
NSLog(@"direction=%d at func %s",direction, __func__);
    [imageCache removeImageSet:self.characterName action:currAnimation direction:direction];
//    totalImageCount = 8;      /// number of frames
//    if (aDirection != prevDirection) // != original
//    {
        prevDirection = aDirection;
        if (prevDirection == DOWN_RIGHT || prevDirection == DOWN_LEFT)
        {
            currentDirection = DownNormal;
        }
        else if(prevDirection == UP_RIGHT  ||prevDirection == UP_LEFT)
        {
            currentDirection = UpNormal;
        }
        else if (prevDirection == RIGHT || prevDirection == LEFT)
        {
            currentDirection = Side;
        }
        else if (prevDirection == UP)
        {
            currentDirection = backNormal;
        }
        else if(prevDirection ==  DOWN)
        {
            currentDirection = frontNormal;
        }
        prevDirection = currentDirection;
        prevAction = currAction;
        
NSLog(@"direction=%d at func %s",direction, __func__);
//        imageIndex = 0;
        [self getTextures];
//    }
}

- (void) getTextures
{
    @synchronized ([UIApplication sharedApplication])
    {
        [self pause];
        [gameLayer setTextureForThirtyTwoBits];
        [gameLayer getTexturesSelector:@selector(assignTextures:) forTarget:self withObject:nil];
        // [self performasynchhronusactionswithtype]
    }
}


- (void)assignTextures:(NSMutableArray *)texArray
{                                                   // to be changed to "switch" call insted of else if
    NSLog(@"curraction = %d IC = %d II = %d",currAction, [texArray count], imageIndex);
    if (currAction  == WALKING_ACTION)
    {
        [self setWalkingFramesArray:texArray];
    }
    else if (currAction == LOOK_ACTION) {
        [self setWalkingFramesArray:texArray];          ///lx all same now, to be customised later if required
    }
    else if(currAction == BROWSE1_ACTION)
    {
        [self setWalkingFramesArray:texArray];
    }
    else if(currAction == BROWSE2_ACTION)
    {
        [self setWalkingFramesArray:texArray];
    }
    else if(currAction == WALK_IDLE_ACTION)
    {
        [self setWalkingFramesArray:texArray];
    }
    else if (currAction == IDLE_WALK_ACTION)
    {
        [self setWalkingFramesArray:texArray];
    }
    else if (currAction == IDLE1_ACTION)
    {
        [self setWalkingFramesArray:texArray];
    }
    else if(currAction == IDLE2_ACTION)
    {
        [self setWalkingFramesArray:texArray];
    }
    else if (currAction == CLEAN_ACTION)
    {
        [self setWalkingFramesArray:texArray];
    }
    //    else if(other_Action)
    //    {
    //        ///write method for adding other frames to that actionarray
    //    }
    
    [gameLayer setTextureForSixteenBits];
    [self resume];
}

- (void)setWalkingFramesArray:(NSMutableArray *)texArray
{
    if (texArray)
    {
        self.currTexturesArray = texArray;
    }
    else
    {
        self.currTexturesArray = nil;
    }
}

- (void) updateCharacterAction
{
    NSLog(@"curr directi %d", currentDirection);
	if(pauseCharacter)
		return;
	switch (currAction)
	{
		case WALKING_ACTION:
            totalImageCount = WALK_FRAME_COUNT;
            if (!characterUpdatingPath) {
                [self randomWalkingCall];
            }
            else if(aStar.pathCalculated){
                characterUpdatingPath = false;
            }
			
            break;
        case WALK_IDLE_ACTION:
            totalImageCount = WALK_IDLE_FRAME_COUNT;
            [self walkToIdleActionCall];
            break;
            
        case IDLE_WALK_ACTION:
            totalImageCount = IDLE_WALK_FRAME_COUNT;
            [self idleToWalkActionCall];
            break;
            
        case LOOK_ACTION:
            totalImageCount = LOOK_FRAME_COUNT;
            [self freeLookCall];  
            break;
            
        case IDLE1_ACTION:
            totalImageCount = IDLE1_FRAME_COUNT;
            [self idle1ActionCall];
            break;
            
        case IDLE2_ACTION:
            totalImageCount = IDLE2_FRAME_COUNT;
            [self idle2ActionCall];
            break;
            
        case BROWSE1_ACTION:
            totalImageCount  =BROWSE1_FRAME_COUNT;
            [self browse1ActionCall];
            break;
            
        case BROWSE2_ACTION:
            totalImageCount = BROWSE2_FRAME_COUNT;
            [self browse2ActionCall];
            break;
            
        case CLEAN_ACTION:
            totalImageCount = CLEANING_FRAME_COUNT;
            [self cleaningActionCall];
            break;
            //		case DESTINATION_WALKING:
            //			[self shortestPathWalking];
            //			break;
            //
            //		case BOWING_ACTION:
            //			[self showBowAnimationForAvatar];
            //			break;
            
		default:
			break;
	}
	return;
}

#pragma mark ANIMATIONS
/**
 * Action Animations
 */

-(void)animateCharaterWithParametres:(NSString *)fileName FramesCount:(int)framesCnt andDelay:(float)aniDelay
{
    
    [characterSprite stopAllActions];
   
    NSMutableArray *animationArray = [[NSMutableArray alloc] init];
    CCSpriteFrameCache *animationFrameCache = [CCSpriteFrameCache sharedSpriteFrameCache];//[[CCSpriteFrameCache alloc]init];
    CCSpriteFrame *animationFrame = [[CCSpriteFrame alloc]init];
    [animationFrameCache addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",fileName]];
    
    for (int i =0; i<framesCnt; i++)
    {
        animationFrame = [animationFrameCache spriteFrameByName:[NSString stringWithFormat:@"%@_%d.png",fileName, i]];
        [animationArray addObject:animationFrame];
    }
    
    CCAnimation *zAnimation = [[CCAnimation alloc]initWithFrames:animationArray delay:aniDelay];
    CCAnimate *zAniamte = [[CCAnimate alloc]initWithAnimation:zAnimation];
    CCCallFunc *callFunc = [CCCallFunc actionWithTarget:self selector:@selector(currentActionDidEnd)];
    CCSequence *animationSeq = [CCSequence actions:zAniamte,callFunc,nil];
    [self.characterSprite runAction:animationSeq];
    
    [animationArray release];
    [animationFrame release];
    [zAnimation release];
}


- (void)pause
{
    pauseCharacter = YES;
}

- (void)resume
{
    pauseCharacter = NO;
}

-(void) currentActionDidEnd
{
    currActionEnded = YES;
    [self pause];
    [[CharacterController getInstance] FinishedAction:self];
    stepIndex = 0;
    [self resume];
}


-(void)RecalculatePath
{
    characterUpdatingPath = YES;
//    [[CCActionManager sharedManager] removeAllActionsFromTarget:self];
    [aStar RecalculatePath:stepIndex];
    stepIndex = 0;
    
}
- (void) characterReachedEndOfpathAt:(CGPoint)characterPoint
{
//    characterAtLastGridOfPath = YES;
    
    [self currentActionDidEnd];
   
    //// call the method to generate next pat /////////
    //////./lx write the method to return next action to be performed by character///////
}

@end
