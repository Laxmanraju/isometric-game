//
//  MCGameEngineController.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 07/12/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MCBackgroundScrollLayer.h"
#import "MCGameEngineConstants.h"

#import "Constant_iPhone.h"
#import "MCGameEngineModel.h"
#import "UIDeviceMyDeviceType.h"
#import "MCObject.h"

@class MCObject;
@class GameLogicLayer;
@interface MCGameEngineController : NSObject
{
    CGSize winsize;
    CCScene *scene;
    MCBackgroundScrollLayer *backGroundScrollLayer;
    MCGameEngineModel *gameEngineModel;
    GameLogicLayer	  *gameLogicLayer;
    
    float min_scale;
    float max_scale;
    
//    GameLogicLayer *gameLogicLayer;
    
    CGPoint prevNodePoint;
    CGPoint delta;
    
    BOOL isFirstLaunch;
    BOOL isZooming;
    BOOL guesturesEnable;
    
    NSMutableArray *gridInfo,*tileInfo;
    NSMutableDictionary *sessionInfo;
   
    
    
    
}
@property (nonatomic, assign) NSMutableArray		*gridInfo,*tileInfo;
@property (nonatomic, assign) NSMutableDictionary   *sessionInfo;
@property (nonatomic, assign) BOOL isZooming;
@property (nonatomic, assign) MCGameEngineModel	 *gameEngineModel;
@property (nonatomic, retain) MCBackgroundScrollLayer *backGroundScrollLayer;

/**
 * sharedinstance of MCGameEngineController
 */
+ (MCGameEngineController *)sharedObject;

/**
 * Main back ground scene
 */
- (void)runGame;
/**
 * start game
 */
- (void)startGameFromOwnerFolder;
- (void)saveGameToServer;
- (void)saveGameLocally;
/**
 * creating the game Logic Layer
 */
- (void)creteGameLogicLayerWithSessionInfo:(NSMutableDictionary*)sessionInformation;


/**
 *
 * background scroll layer initialization and setting the delegates
 */
- (void)createBackGroundLayer;

- (void)defaultGameLayerSettings;

- (void)initializeScrollGuesturesForDelegate:(CCNode *)node;


/**
 * update tileInfo with the Object placement
 */
- (void)updateGameInfoWithObject:(MCObject*)object forX:(int)x andY:(int)y andObjectSize:(CGPoint)aObjectSize;
- (BOOL)checkForObjectIntersection:(int)row andColoumn:(int)coloumn andObjectSize:(CGPoint)aObjectSize;

/**
 *	Guesture Delegate method for Dragging.
 */
- (void)drag:(UIGestureRecognizer *)recognizer node:(CCNode*)node;

- (CGPoint)checkBoundaryConditionForPosition:(CGPoint)nodePosition width:(float)width height:(float)height anchorPoint:(CGPoint)anchorPt andScale:(float)nodeScale;

- (void)setPositionForNode:(CCNode*)node andAnchorPoint:(CGPoint)anchorPt;

- (float)scaleFactorWtihBoundaryConditionForNode:(CCNode*)node andScale:(float)pinchScale;
- (void)bounceBack:(CCNode *)node;
-(void)addExpansionStartingAtRow:(int)Row andColumn:(int)Column ByRows:(int)Rows AndColumns:(int)Columns;


/** */
- (void)disableGestures;
/** */
- (void)enableGestures;



@end
