  //
//  MCGameEngineController.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 07/12/12.
//
//

#import "MCGameEngineController.h"
#import "GameLogicLayer.h"


@implementation MCGameEngineController

@synthesize isZooming;
@synthesize gameEngineModel;
@synthesize backGroundScrollLayer;
@synthesize gridInfo,tileInfo;
@synthesize sessionInfo;

static MCGameEngineController *_mcGameEngineController;

/**
 * sharedinstance of MCGameEngineController
 */
+ (MCGameEngineController *)sharedObject
{
        return _mcGameEngineController;
}
/**
 * initialization
 */

- (id)init
{
    self = [super init];
    if (self) {
        _mcGameEngineController = self;
        winsize = [[CCDirector sharedDirector] winSize];
        gameEngineModel = [[MCGameEngineModel alloc] init];
        scene = [[CCScene alloc] init];
        [self createBackGroundLayer];
    
        min_scale = gameEngineModel.minZoom;
		max_scale = gameEngineModel.maxZoom;

    }
    return self;
}

- (void)dealloc
{
    [scene release];
    [gameEngineModel release];
    [backGroundScrollLayer release];
    if(gridInfo)
	{
		[gridInfo release];
		gridInfo = nil;
	}
	
	if(sessionInfo)
	{
		[sessionInfo release];
		sessionInfo = nil;
	}
	
	if(tileInfo)
	{
		[tileInfo release];
		tileInfo = nil;
	}

    [super dealloc];
}

/**
 *  Main back ground scene
 */

- (CCScene *)scene
{
    return scene;
}

- (void)runGame
{
     [[CCDirector sharedDirector] runWithScene:scene];
}


/**
 * start game
 */

- (void)startGameFromOwnerFolder
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    if (sessionInfo) {
        [sessionInfo release];
        sessionInfo = nil;
    }
    
    if (gridInfo) {
        [gridInfo release];
        gridInfo = nil;
    }

    if (tileInfo) {
        [tileInfo release];
        tileInfo = nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( ![fileManager fileExistsAtPath:OWNER_FOLDER_PATH] )
	{
		//[fileManager createDirectoryAtPath:OWNER_FOLDER_PATH attributes:nil];//Changes_Vinodh_03/03_Directory path
		[fileManager createDirectoryAtPath:OWNER_FOLDER_PATH withIntermediateDirectories:NO attributes:nil error:nil];
	}
    NSString *sessionInfoPath = [[NSString alloc] initWithFormat:@"%@",[[NSBundle mainBundle]pathForResource:@"SessionInfo" ofType:@"plist"]];
	sessionInfo =  [[NSMutableDictionary alloc] initWithContentsOfFile:sessionInfoPath];
	if (sessionInfo == nil)
	{
		sessionInfo = [NSMutableDictionary new];
	}
    
    NSString *tileInfoPath = [[NSString alloc] initWithFormat:@"%@",[[NSBundle mainBundle]pathForResource:@"TileInfo" ofType:@"plist"]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:tileInfoPath];
    tileInfo = [[dict objectForKey:@"Grid"] retain];
    [self updateTileInfoToSetDefaultValues];
    [sessionInfoPath release];
    [tileInfoPath release];
    [dict release];
    [self creteGameLogicLayerWithSessionInfo:sessionInfo];

    [pool release];
}



- (void)addExpansionStartingAtRow:(int)Row andColumn:(int)Column ByRows:(int)Rows AndColumns:(int)Columns

{    BOOL isTileInfoChanged = NO;
    NSLog(@"Row :%d Column:%d Rows :%d Columns :%d", Row,Column,Rows,Columns);

    for (int i=Row; i <= Row+Rows-1; i++)
	{
		for (int j=Column ; j <= Column +Columns-1; j++)
		{
			if(![[[tileInfo objectAtIndex:i] objectAtIndex:j] intValue])
			{
				[[tileInfo objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:1]];
				isTileInfoChanged =YES;
			}
            NSLog(@" Value :%d", [[[tileInfo objectAtIndex:i]objectAtIndex:j]intValue]);
		}
	}
    
    if (isTileInfoChanged) {
        NSString *tileInfoPath =[[NSString alloc] initWithFormat:@"%@/%@", OWNER_FOLDER_PATH, TILE_INFO];
        //        NSLog(@"%@",tileInfoPath);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:tileInfoPath]) {
            NSDictionary *dict = [NSDictionary dictionaryWithObject:tileInfo forKey:@"Grid"];
            [dict writeToFile:tileInfoPath atomically:YES];
        }
        
    }
    
    NSLog(@"tileInfo :%@",tileInfo);
//    
//    for (unsigned int i = Row; i < Row+Rows; ++i) {
//        NSMutableArray *arrRow ;
////        if (i  >= [tileInfo count]) {
////            arrRow = [[NSMutableArray alloc] init];
////        }
////        else
//        arrRow = [tileInfo objectAtIndex:i];
//        NSLog(@"arrRow %@",arrRow);
//        for (unsigned int j = Columns; j < Column + Columns; ++j) {
//            [arrRow insertObject:[NSNumber numberWithInt:1] atIndex:j];
//         NSLog(@"insertion %@",arrRow);
//        }
//        [tileInfo insertObject:arrRow atIndex:i];
//    }
//    
//    NSLog(@"tileInfo :%@",tileInfo);
   
}

- (void)updateTileInfoToSetDefaultValues
{
    
    BOOL isTileInfoChanged = NO;
    for (int i=0; i <= _INITIAL_ROWS-1; i++)
	{
		for (int j=0 ; j <=_INITIAL_ROWS-1; j++)
		{
			if(![[[tileInfo objectAtIndex:i] objectAtIndex:j] intValue])
			{
				[[tileInfo objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:1]];
				isTileInfoChanged =YES;
			}
		}
	}
    if (isTileInfoChanged) {
        NSString *tileInfoPath =[[NSString alloc] initWithFormat:@"%@/%@", OWNER_FOLDER_PATH, TILE_INFO];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:tileInfoPath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:tileInfoPath withIntermediateDirectories:YES attributes:nil error:NULL];
            [tileInfo writeToFile:[NSString stringWithFormat:@"%@/%@",tileInfoPath,TILE_INFO] atomically:YES ];
        }
        else{
           [tileInfo writeToFile:[NSString stringWithFormat:@"%@/%@",tileInfoPath,TILE_INFO] atomically:YES ]; 
        }
        
    }
    
}

#pragma mark -
#pragma mark Save Game

- (void)saveGameLocally
{
    NSAutoreleasePool * pool = [NSAutoreleasePool new];
    if(!sessionInfo )
    {
        [pool release];
        return;
    }
    
//[gameLogicLayer updateSessionInfo];
    NSLog(@"sessionInfo :%@",sessionInfo);
   
    NSString *sessionInfoPath = [[NSString alloc] initWithFormat:@"%@/%@", OWNER_FOLDER_PATH, SESSION_INFO];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:sessionInfoPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:sessionInfoPath withIntermediateDirectories:YES attributes:nil error:NULL];
         [sessionInfo writeToFile:[NSString stringWithFormat:@"%@/%@", sessionInfoPath, SESSION_INFO] atomically:YES];
    }else{
         [sessionInfo writeToFile:[NSString stringWithFormat:@"%@/%@", sessionInfoPath, SESSION_INFO] atomically:YES];
    }
    
    [sessionInfoPath release];
}

- (void)saveGameToServer
{
    [self saveGameLocally];
}


#pragma mark -
#pragma mark - Object Intersection Delegate
#pragma mark -

- (BOOL)checkForObjectIntersection:(int)row andColoumn:(int)coloumn andObjectSize:(CGPoint)aObjectSize
{
  
    if (row < 0 || coloumn < 0 ) {
        return NO;
    }

    for (int i = 0; i < aObjectSize.x; i++)
    {
        for (int j = 0; j < aObjectSize.y; j++)
        {
            int rowCheck,colCheck;
            rowCheck = row -i;
            colCheck = coloumn -j;
            if (rowCheck < [tileInfo count])
            {
                if (colCheck < [[tileInfo objectAtIndex:rowCheck] count])
                {
//                    NSLog(@"row :%d coloumn :%d value :%d aObjectSize:%@",row-i,coloumn-j,[[[tileInfo objectAtIndex:row-i]objectAtIndex:coloumn-j]intValue],NSStringFromCGPoint(aObjectSize));
                    
                    if (![[[tileInfo objectAtIndex:rowCheck]objectAtIndex:colCheck]intValue] ) {
                        return NO;
                    }
                    if([[[tileInfo objectAtIndex:rowCheck]objectAtIndex:colCheck]intValue] == -1) {
                        return NO;
                    }
 
                }
                    
                
            }
            
        }
    }
    return YES;
}

/**
 * update tileInfo with the Object placement
 */
- (void)updateGameInfoWithObject:(MCObject*)object forX:(int)x andY:(int)y andObjectSize:(CGPoint)aObjectSize
{
    NSLog(@"%@",NSStringFromCGPoint(aObjectSize));
    
    for (int i = 0; i < aObjectSize.x; i++) {
        for (int j = 0; j < aObjectSize.y; j++) {
//             NSLog(@"row :%d coloumn :%d aObjectSize:%@",x-i,y-j,NSStringFromCGPoint(aObjectSize));
            [[tileInfo objectAtIndex:x-i]replaceObjectAtIndex:y-j withObject:[NSNumber numberWithInt:-1]];
            
            if ([GameLogicLayer sharedObject].gameMode == kEditMode) {
                if ([[[tileInfo objectAtIndex:x-i]objectAtIndex:y-j]intValue] == -1) {
                    [[tileInfo objectAtIndex:x-i]replaceObjectAtIndex:y-j withObject:[NSNumber numberWithInt:1]];
                }
              
            }
           
        }
    }
    
//    NSLog(@"tileInfo :%@",tileInfo);
    
    [self updateSessionInfoObjectInfo:object];
}

//updating the objects in session info

#pragma mark -
#pragma mark - updating the objects in session info
#pragma mark -

- (void)updateSessionInfoObjectInfo:(MCObject *)object
{
    NSMutableDictionary *objectInfoDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:object.categoryName,CATEGORYID,NSStringFromCGPoint(object.lowestPoint),LOWESTPOINT, nil];
    NSString *aPoint = NSStringFromCGPoint([gameLogicLayer getGridPointForPosition:ccp(object.lowestPoint.x, object.lowestPoint.y)]);
    NSMutableArray *gridIndexArray = nil;
    if ((gridIndexArray = [gameLogicLayer.objectsInfo objectForKey:aPoint])) {
        if ([gridIndexArray isKindOfClass:[NSMutableArray class]]) {
            [gridIndexArray addObject:object];
            [[sessionInfo objectForKey:aPoint] addObject:objectInfoDict];
        }else{
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:[gameLogicLayer.objectsInfo objectForKey:aPoint],object,nil];
            [gameLogicLayer.objectsInfo setObject:array forKey:aPoint];
            [array release];
            array = [[NSMutableArray alloc] initWithObjects:[sessionInfo objectForKey:aPoint], objectInfoDict, nil];
            [sessionInfo setObject:array forKey:aPoint];
            [array release];
        }
    }
    else {
        [gameLogicLayer.objectsInfo setObject:object forKey:aPoint];
        [sessionInfo setObject:objectInfoDict forKey:aPoint];
    }
    [objectInfoDict release];
    NSLog(@"session Info :%@",sessionInfo);
}


/**
 *
 * background scroll layer
 */

- (void)createBackGroundLayer
{
//    float tileWidth		= gameEngineModel.tileWidth;
//	float tileHeight	= gameEngineModel.tileHeight; \
//	float yMargin		= gameEngineModel.yMargin;
//    CGSize size = CGSizeMake((INITIAL_ROWS*6)*tileWidth, (INITIAL_ROWS*2)*tileHeight/2 + yMargin);
//   CGSize size = CGSizeMake(12000, 7000);
//    CGSize size = CGSizeMake(4000, 2000);
    CGSize size =  CGSizeMake((A_MAX_ALLOWED_ROWS+A_MAX_ALLOWED_COLUMNS)*_TILE_WIDTH/2,(A_MAX_ALLOWED_ROWS+A_MAX_ALLOWED_ROWS)*_TILE_HEIGHT/2 + Y_MARGIN );
    backGroundScrollLayer = [[MCBackgroundScrollLayer alloc] initWithColor:ccc4(255.0f, 255.0f, 255.0f, 255.0f) width:size.width height:size.height];
    [scene addChild:backGroundScrollLayer z:-10000000000];
    backGroundScrollLayer.isTouchEnabled = YES;
    [self initializeScrollGuesturesForDelegate:backGroundScrollLayer];
    [self defaultGameLayerSettings];
    
}
/**
 *  setting the backgroundScroll Layer
 */

- (void)defaultGameLayerSettings
{
    NSLog(@"SIze :%@",NSStringFromCGSize(backGroundScrollLayer.contentSize));
    NSLog(@"xxxx: %lf  yyyy:%lf",backGroundScrollLayer.position.x,backGroundScrollLayer.position.y);
    float scale = gameEngineModel.startZoom;
    backGroundScrollLayer.scale = scale;
    float width = winsize.width;
    if (width == 1024.0f)
    {
        if (CC_CONTENT_SCALE_FACTOR() == 2)
        {

        }
        else
        {
            [backGroundScrollLayer setPosition:CGPointMake(-backGroundScrollLayer.contentSize.width/2.3,
                                                           -backGroundScrollLayer.contentSize.height/1.4)];
        }
    } else if (width == 480.0f) {
        if (CC_CONTENT_SCALE_FACTOR() == 2)
        {

        }
        else
        {
            [backGroundScrollLayer setPosition:CGPointMake(-backGroundScrollLayer.contentSize.width/2.3,
                                                           -backGroundScrollLayer.contentSize.height/2)];
        }
    }else {
         backGroundScrollLayer.contentSize = CGSizeMake(800, 600);
        [backGroundScrollLayer setPosition:CGPointMake(-backGroundScrollLayer.contentSize.width/2,
                                                       -backGroundScrollLayer.contentSize.height/4)];
    }
}
/**
 *  initializeScrollGuesturesForDelegate
 **/

- (void)initializeScrollGuesturesForDelegate:(CCNode *)node
{
    // setup a tap for scene for test with menu
	// add UILongPressGestureRecognizer
//    UILongPressGestureRecognizer *press = [[[UILongPressGestureRecognizer alloc] init]autorelease];
////    press.minimumPressDuration = 0.5f;
////    
//    press.allowableMovement = 10.0f;
    CCGestureRecognizer *recognizer;
    recognizer = [CCGestureRecognizer CCRecognizerWithRecognizerTargetAction:[[[UIPanGestureRecognizer alloc ]init] autorelease] target:self action:@selector(drag:node:)];
    [node addGestureRecognizer:recognizer];
    
   // add UIPanGestureRecognizer
    
    recognizer = [CCGestureRecognizer CCRecognizerWithRecognizerTargetAction:[[[UIPinchGestureRecognizer alloc] init]autorelease] target:self action:@selector(scale:node:)];
    [node addGestureRecognizer:recognizer];
	node.isTouchEnabled = YES;
    guesturesEnable = YES;
	
}


- (void)creteGameLogicLayerWithSessionInfo:(NSMutableDictionary*)sessionInformation
{
    gameLogicLayer = [GameLogicLayer sharedObject];
    [gameLogicLayer initializeGameLogicLayer];
    [gameLogicLayer defaultGameSetup];
    [backGroundScrollLayer addChild:gameLogicLayer z:1];
}

#pragma mark -
#pragma mark - Dragging Delegate
#pragma mark -

/**
 *	Guesture Delegate method for Dragging.
 */
- (void)drag:(UIGestureRecognizer *)recognizer node:(CCNode*)node
{
   
    static CGPoint firstPoint, endPoint;
    static NSTimeInterval firstTouchTime, lastTouchTime;
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)recognizer;
    // this will center the node on the touch

    if ([recognizer state] == UIGestureRecognizerStateBegan || [recognizer state]== UIGestureRecognizerStateChanged) {
        if ([recognizer state] == UIGestureRecognizerStateBegan) {
            backGroundScrollLayer.isCanMove =YES;
            [node stopAllActions];
            [backGroundScrollLayer stopScrollingAction];
            firstPoint = [pan locationInView:pan.view];
            firstTouchTime = [NSDate timeIntervalSinceReferenceDate];
        }
        else if ([recognizer state] == UIGestureRecognizerStateEnded)
        {
          
            [node stopAllActions];
            [backGroundScrollLayer stopScrollingAction];
            endPoint = [pan locationInView:pan.view];
            lastTouchTime = [NSDate timeIntervalSinceReferenceDate];
        }
        else{
            prevNodePoint = node.position;
        }
        
        endPoint = [pan locationInView:pan.view];
        lastTouchTime = [NSDate timeIntervalSinceReferenceDate];
        
        delta = CGPointZero;
        delta = [pan translationInView:pan.view];
        delta = ccp(delta.x, -delta.y);
        //checking the boundaries for the layer
        CGPoint position = [self checkBoundaryConditionForPosition:ccpAdd(node.position, delta) width:node.contentSize.width height:node.contentSize.height anchorPoint:node.anchorPoint andScale:node.scale];
        
        prevNodePoint = node.position;
        [node setPosition:position];
        [pan setTranslation:CGPointZero inView:pan.view];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
//         [self bounceBack:node];
          backGroundScrollLayer.isCanMove = NO;
        CGPoint velocity = [pan velocityInView:pan.view];
        {
            
            CGPoint velocity = ccpSub(firstPoint, endPoint);
            NSTimeInterval elapsedTime = lastTouchTime - firstTouchTime;
            velocity = ccpMult(velocity, 1/elapsedTime);
        }
        
        backGroundScrollLayer.velocity = velocity;
        backGroundScrollLayer.prevTouchPoint = prevNodePoint;
        [backGroundScrollLayer startScrollingEffect];
    }
}

/**
 *checking the boundaries for the background layer
 */
- (CGPoint) checkBoundaryConditionForPosition:(CGPoint)nodePosition width:(float)width height:(float)height anchorPoint:(CGPoint)anchorPt andScale:(float)nodeScale
{
  
   
    NSLog(@"nodeScale :%lf",nodeScale);
    NSLog(@"rows :%d columns :%d",gameLogicLayer.rows, gameLogicLayer.columns);
    float gameWidth = gameLogicLayer.contentSize.width;
    float gameHeight = gameLogicLayer.contentSize.height;
   
    float expandX = 0;
    float minX = (gameWidth*nodeScale - gameWidth)*anchorPt.x -15;
    float minY = (gameHeight*nodeScale - gameHeight)*anchorPt.y-15;
    
    NSLog(@"minY :%lf",minY);
    float maxX = -1*(((gameWidth -expandX)*nodeScale + -1*minX) -[UIDevice myDeviceScreenWidth])+15;
    float maxY = -1*(((gameHeight*nodeScale + -1*minY))- [UIDevice myDeviceScreenHeight])+15;
    NSLog(@"maxY :%lf",maxY);
    if (nodePosition.x>=minX)
	{
		nodePosition.x=minX;
	}
	if (nodePosition.y < maxY)
	{
		nodePosition.y = maxY;
	}
	if (nodePosition.x < maxX)
	{
		nodePosition.x = maxX;
	}
	if (nodePosition.y>=minY)
	{
		nodePosition.y=minY;
	}
    return nodePosition;
    
    
//    float gameWidth = gameLogicLayer.contentSize.width;
//	float gameHeight = gameLogicLayer.contentSize.height;
//	width = gameLogicLayer.boundaryRect.size.width;
//	height = gameLogicLayer.boundaryRect.size.height;
//	//CGPoint boundaryOrgin = gameLogicLayer.boundaryRect.origin;
//	
//	float minX = (gameWidth*nodeScale-gameWidth)*anchorPt.x - (gameWidth -width*_TILE_WIDTH/2)/2*nodeScale+100;
//	float maxX = -1*(((width)*nodeScale + -1*minX) - SCREEN_WIDTH)-200;
//	float minY = (gameHeight*nodeScale-gameHeight)*anchorPt.y;
//	float maxY = -1*(((height*nodeScale + -1*minY))- [UIDevice myDeviceScreenHeight])+15;//minY;
//	
//	if (nodePosition.x>=minX)
//	{
//		nodePosition.x=minX;
//	}
//	if (nodePosition.x < maxX)
//	{
//		nodePosition.x = maxX;
//	}
//	
//	if (nodePosition.y > minY)
//	{
//		nodePosition.y = minY;
//	}
//	
//	if (nodePosition.y<=maxY)
//	{
//		nodePosition.y=maxY;
//	}
//	
////	[gameLogicLayer.animationHelper resetPopUpsScale];
	return nodePosition;
}


// this method moves a gesture recognizer's view's anchor point between the user's fingers
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer  andNode:(CCNode*)node
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        CCDirector *director = [CCDirector sharedDirector];
        CGPoint pt1 = [node convertToNodeSpace:[director convertToGL:[gestureRecognizer locationOfTouch:0 inView:gestureRecognizer.view]]];
        CGPoint pt2 = [node convertToNodeSpace:[director convertToGL:[gestureRecognizer locationOfTouch:1 inView:gestureRecognizer.view]]];
        pt1 = ccpMidpoint(pt1, pt2);
        CGPoint prevAnchorPoint = node.anchorPoint;
        node.anchorPoint = ccp(pt1.x/ node.contentSize.width, pt2.y/ node.contentSize.height);
        [self setPositionForNode: node andAnchorPoint:prevAnchorPoint];
    }
}


/**
 * setting the anchorPoint and position for pinch in and pinch out.
 */
-(void) setPositionForNode:(CCNode*)node andAnchorPoint:(CGPoint)anchorPt
{
	node.position = ccp(node.position.x - (-anchorPt.x + node.anchorPoint.x)*node.contentSize.width*node.scale,
						node.position.y - (-anchorPt.y + node.anchorPoint.y)*node.contentSize.height*node.scale);
}
/**	Guesture Delegate method for scaling. */
- (void)scale:(UIGestureRecognizer*)recognizer node:(CCNode*)node
{
    
    UIPinchGestureRecognizer *pinch = (UIPinchGestureRecognizer *)recognizer;
    if (isnan(pinch.scale) || isinf(pinch.scale)) {
        return;
    }
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        backGroundScrollLayer.isZoomingStarted = YES;

    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){

       backGroundScrollLayer.isZoomingStarted = NO;
    }
    
    float prevScale = node.scale;
    node.scale = [self scaleFactorWtihBoundaryConditionForNode:node andScale:pinch.scale];
    pinch.scale = 1.0f;
    float curScale = node.scale;
    if (prevScale != curScale) {
        
        [self adjustAnchorPointForGestureRecognizer:recognizer andNode:node];
        node.position = [self checkBoundaryConditionForPosition:node.position width:node.contentSize.width height:node.contentSize.height anchorPoint:node.anchorPoint andScale:node.scale];
    }
}


/**	Checking boudary condition for min scale value. */
- (float)scaleFactorWtihBoundaryConditionForNode:(CCNode*)node andScale:(float)pinchScale
{
    
    float nodeScale = node.scale*pinchScale;
    if (nodeScale < min_scale || nodeScale > max_scale || node.contentSize.height*nodeScale < [UIDevice myDeviceScreenWidth] || node.contentSize.width*nodeScale < [UIDevice myDeviceScreenHeight])
       return node.scale;
    
//    float nodeScale = node.scale * pinchScale;
//	
//	float scaleFactorX =SCREEN_WIDTH/gameLogicLayer.boundaryRect.size.width; // newSize.width/1024.0;
//	if(scaleFactorX < min_scale)
//		scaleFactorX = min_scale;
//	
//	if (( nodeScale > max_scale))// height*nodeScale < SCREEN_HEIGHT neccessary for small contentSize
//		return node.scale;
//    //	float bound = [[UIScreen mainScreen] bounds].size.width ;
//	if ( ((gameLogicLayer.boundaryRect.size.height*nodeScale) < SCREEN_HEIGHT))// height*nodeScale < SCREEN_HEIGHT neccessary for small contentSize
//		return node.scale;
//	
//	if ( ((gameLogicLayer.boundaryRect.size.width*nodeScale) < SCREEN_WIDTH))// height*nodeScale < SCREEN_HEIGHT neccessary for small contentSize
//		return node.scale;
	
    //	int htLimit = gameLogicLayer.boundaryRect.size.height;
    //	if (htLimit < SCREEN_HEIGHT)
    //		htLimit = SCREEN_HEIGHT;
    //	int wdLimit = gameLogicLayer.boundaryRect.size.width;
    //	if (wdLimit < SCREEN_WIDTH)
    //		wdLimit = SCREEN_WIDTH;
    //
    //	if ((htLimit*nodeScale) < SCREEN_HEIGHT)
    //	{
    //		return node.scale;
    //	}
    //	if ((wdLimit*nodeScale) < SCREEN_WIDTH)
    //	{
    //		return node.scale;
    //	}
	
	

    
    return nodeScale;
}

- (void)bounceBack:(CCNode *)node
{
//    BOOL bounceX = NO;
//    CGPoint centerPoint = node.position;
//    float width = node.contentSize.width;
//    float nodeScale = node.scale;
//    float minX = -(width*nodeScale - width)*node.anchorPoint.x;
//    float boundary = minX + [UIDevice myDeviceScreenWidth]/4;
//    if (centerPoint.x >= boundary) {
//        bounceX = YES;
//        centerPoint.x = boundary;
//    }
//    float maxX = minX - width*nodeScale;
//    boundary = maxX + [UIDevice myDeviceScreenWidth]*0.75;
//    if (centerPoint.x < boundary) {
//        bounceX = YES;
//        centerPoint.x = boundary;
//    }
//    if (bounceX) {
//        backGroundScrollLayer.isBounced = YES;
//       [node runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.3 position:CGPointMake(centerPoint.x, centerPoint.y)],[CCCallFunc actionWithTarget:self selector:@selector(stopBounce)],nil]];
//    }

    BOOL bounceX = NO;
    float width = node.contentSize.width;
    float height = node.contentSize.height;
    CGPoint nodePosition = node.position;
    float nodeScale = node.scale;
    float minX = (width*nodeScale  - width )*node.anchorPoint.x -15;
    float minY = (height*nodeScale - height)*node.anchorPoint.y -15;
    float maxX = -1*((width*nodeScale) - [UIDevice myDeviceScreenWidth]) +15;
    float maxY = -1*((height*nodeScale)- [UIDevice myDeviceScreenHeight]) +15;
    if (nodePosition.x>=minX)
	{   bounceX = YES;
		nodePosition.x=minX-20;
	}
	if (nodePosition.y < maxY)
	{
        bounceX = YES;
		nodePosition.y = maxY+20;
	}
	if (nodePosition.x < maxX)
	{
        bounceX = YES;
		nodePosition.x = maxX+20;
	}
	if (nodePosition.y>=minY)
	{
        bounceX = YES;
		nodePosition.y=minY-20;
	}
    if (bounceX) {
        backGroundScrollLayer.isBounced = YES;
        [node runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.3 position:CGPointMake(nodePosition.x, nodePosition.y)],[CCCallFunc actionWithTarget:self selector:@selector(stopBounce:)],nil]];
    }
    
}
- (void)stopBounce:(CCNode *)node
{
//    [node stopAllActions];
}



/** */
- (void)disableGestures
{
	if (guesturesEnable)
	{
		NSLog(@"Disabled");
		CCGestureRecognizer* recognizer;
		CCArray *gestureRecognizers_ =  backGroundScrollLayer.gestureRecognizers;
		CCARRAY_FOREACH(gestureRecognizers_, recognizer)
		{
			// just an extra check
			if( recognizer.node == backGroundScrollLayer )
				recognizer.gestureRecognizer.enabled = NO;
			guesturesEnable = NO;
		}
	}
}
/** */
- (void)enableGestures
{
	if (!guesturesEnable)
	{
		NSLog(@"Enabled");
		CCGestureRecognizer* recognizer;
		CCArray *gestureRecognizers_ =  backGroundScrollLayer.gestureRecognizers;
		CCARRAY_FOREACH(gestureRecognizers_, recognizer)
		{
			// just an extra check
			if( recognizer.node == backGroundScrollLayer )
				recognizer.gestureRecognizer.enabled = YES;
			guesturesEnable = YES;
		}
	}
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	//	CGPoint pt = [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
	return YES;//![menu_ isPointInArea:pt];
}

@end
