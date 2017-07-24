//
//  GameLogicLayer.m
//  MartCityGame
//
//  Created by Laxman Raju on 10/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLogicLayer.h"
#import "MCStoryBoardViewController.h"
#import "MCPurchaseView.h"
#import "MCAilse.h"
#import "Character.h"
#import "CharacterController.h"

@implementation CSAsyncObject
@synthesize target_, object_, callBack_;
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    self.object_  = nil;
    target_ = nil;
    [super dealloc];
}

@end


@implementation GameLogicLayer

static GameLogicLayer *_sharedObject = nil;

@synthesize boundaryRect;
@synthesize selectedObject;
@synthesize arrExpRows,m_arrGridSquares;
@synthesize gameMode;
@synthesize objectsInfo, placedObjectsArray;
@synthesize rows,columns;


+ (GameLogicLayer *)sharedObject
{
    if (!_sharedObject) {
         _sharedObject = [[GameLogicLayer alloc] init];
    }
    return _sharedObject;
    
}
- (id)init
{
    if (self = [super initWithColor:ccc4(200, 200, 150, 150)])
    {
        srand(time(NULL));
        
         [self initialSetUp];
        OneCharacter = NO;
    }
    return self;
}

- (void)dealloc
{
    [arrExpRows release];
    [m_arrGridSquares release];
    [_sharedObject release];
    if (placedObjectsArray)
    {
        [placedObjectsArray release];
        placedObjectsArray = nil;
    }
    
    [super dealloc];
}

#pragma mark -
#pragma mark Basic Game Setup
#pragma mark -
/**
 *Initial setUp of game logic layer
 **/
-(void)initialSetUp
{
    static int i=0;
    if (i>0)
    return;
    i++;
    self.isTouchEnabled = YES;
    rows = _INITIAL_ROWS;
    columns = _INITIAL_COLUMNS;
    placedObjectsArray = nil;
    storyBoardViewController = [MCStoryBoardViewController _sharedObject];
    
    levelCharacters = [[NSMutableArray alloc]init];
    allCharacters = [[NSMutableArray alloc]init];
    unlockedCharacters = [[NSMutableArray alloc] init];
    
    [self PopulateLandArray];
    [self gameTimerStart];
}

/**
 *  Default GameLayer Settings
 */
- (void)defaultGameSetup
{
    gameEngineController = [MCGameEngineController sharedObject];
    
    label1 = [CCLabelTTF labelWithString:@"" fontName:@"TIMES NEW ROMAN" fontSize:30];
    label1.color = ccc3(0, 0, 0);
    [self addChild:label1];
    
    label2 = [CCLabelTTF labelWithString:@"" fontName:@"TIMES NEW ROMAN" fontSize:30];
    label2.color = ccc3(0, 0, 0);
    [self addChild:label2];
    
    label3 = [CCLabelTTF labelWithString:@"" fontName:@"TIMES NEW ROMAN" fontSize:30];
    label3.color = ccc3(0, 0, 0);
    [self addChild:label3];
    
    label4 = [CCLabelTTF labelWithString:@"" fontName:@"TIMES NEW ROMAN" fontSize:30];
    label4.color = ccc3(0, 0, 0);
    [self addChild:label4];
}

/**      
 * Initialize Game logic layer
 */
-(void)initializeGameLogicLayer
{
    self.contentSize = [[MCGameEngineController sharedObject].backGroundScrollLayer contentSize];
    startPoint = CGPointMake(self.contentSize.width/2, self.contentSize.height-Y_MARGIN);
    self.isTouchEnabled = YES;
    gameMode = kNormalMode;
    [self generateTiles];
}
/**
 * generating tiles
 */
- (void)generateTiles
{

    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    int tagVal = 0;
    int offsetVal = -2;
    NSMutableArray *tileInfoDict = [[MCGameEngineController sharedObject]tileInfo];
    NSLog(@"tileInfoDict :%@",tileInfoDict);
    CGPoint refPoint =ccp(startPoint.x,startPoint.y -_TILE_HEIGHT/2);//ccp(startPoint.x, startPoint.y-_TILE_HEIGHT/2);
    tilenode = [[CCSpriteBatchNode alloc] initWithTexture:[[CCSprite spriteWithFile:@"Tile_128.png"]texture] capacity:1];

    
    for (int i=0; i<_MAX_ALLOWED_ROWS; i++)
    {
        NSAutoreleasePool *aPool = [[NSAutoreleasePool alloc] init];
        for (int j = 0; j<_MAX_ALLOWED_COLUMNS; j++)
        {
            NSString *aStr;
            int zOrderTile = -10000000000000;
            if([[[tileInfoDict objectAtIndex:i] objectAtIndex:j] intValue]== 1)
			{

                aStr = [NSString stringWithFormat:@"Tile_128.png"];
            }
            else{
                aStr = [NSString stringWithFormat:@"GreyTile.PNG"];
            }
           MCTileSprite *tile = [MCTileSprite spriteWithFile:aStr];
////            tile.position = ccp(refPoint.x+j*((_TILE_WIDTH-offsetVal)/2), refPoint.y-j*((_TILE_HEIGHT-offsetVal)/2));
// 
            tile.position = [self getGridPosition:ccp(i,j)];
           tile.tag = tagVal*(-1000);
           tile.isOccupied = NO;
           tile.tileTag = CGPointMake(i, j);
            
//            
            
            
    //        CCSpriteBatchNode *tile = [CCSpriteBatchNode  batchNodeWithFile:aStr];//:<#(CCSpriteBatchNode *)#> rect:<#(CGRect)#>:aStr];
            //            tile.position = ccp(refPoint.x+j*((_TILE_WIDTH-offsetVal)/2), refPoint.y-j*((_TILE_HEIGHT-offsetVal)/2));
            
           // tile.position = [self getGridPosition:ccp(i,j)];
//            tile.tag = tagVal*(-1000);
//            tile.isOccupied = NO;
//            tile.tileTag = CGPointMake(i, j);
            
                
//                CCLabelTTF *labelTile = [CCLabelTTF labelWithString:@"" fontName:@"TIMES NEW ROMAN" fontSize:20];
//                [labelTile setString:[NSString stringWithFormat:@"%@",NSStringFromCGPoint(tile.position) ]];
//                labelTile.color = ccc3(0, 0, 0);
//                labelTile.position = tile.position;
//                [[MCGameEngineController sharedObject].backGroundScrollLayer addChild:labelTile z:2];
            
            [tilenode addChild:tile z:zOrderTile];


            tagVal++;
        }
        [aPool release];
        refPoint = ccp(refPoint.x-(_TILE_WIDTH-offsetVal)/2, refPoint.y-(_TILE_HEIGHT-offsetVal)/2);
    }
    
    [self addChild:tilenode z:-1000000];
    [tilenode release];
    boundaryRect.origin.x = refPoint.x - _TILE_WIDTH/2;
    boundaryRect.origin.y = refPoint.y -_TILE_HEIGHT/2;   //boundaryRect.origin.y = refPoint.y -
    
    boundaryRect.size.width = (_TILE_WIDTH-offsetVal) * _INITIAL_COLUMNS;
    boundaryRect.size.height = (_TILE_HEIGHT-offsetVal) * _INITIAL_ROWS;
    
   
    
}


-(CGPoint)getGridPosition:(CGPoint)gridPos
{
    CGPoint gridPosition = ccp(startPoint.x + ((gridPos.y* _TILE_WIDTH/2)-(gridPos.x *_TILE_WIDTH/2)),startPoint.y -((gridPos.x * _TILE_HEIGHT/2)+(gridPos.y * _TILE_HEIGHT/2))-_TILE_HEIGHT/2); //// lx added tileheight/2 at the end
    return gridPosition;
}


- (NSArray *)getEntityItems:(int)index
{
//    NSArray *entityGroupsArray = [[NSDictionary dictionaryWithContentsOfFile:GAMEINFOPLIST] objectForKey:ENTITYGROUPS];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"GameInfo" ofType:@"plist"];
    NSArray *entityGroupsArray = [[NSDictionary dictionaryWithContentsOfFile:plistPath]objectForKey:ENTITYGROUPS];
    NSArray *entitiesArray = [[entityGroupsArray objectAtIndex:index] objectForKey:ENTITIES];
     return entitiesArray ;
    
}
#pragma mark -
#pragma mark Object placement
#pragma mark -
/**
 * Object Placement
 */


- (void)confirmObjectPosition
{
    if (!placedObjectsArray)
    {
        placedObjectsArray = [[NSMutableArray alloc] init];
    }
    if (self.selectedObject.isObjectPlaceable)
    {
         [[storyBoardViewController statisticsBoard] updateLevel:0 coins:-[self.selectedObject coinsReqired]];
        selectedObject.objectSprite.opacity = 255;
        [self setZorder];
        [selectedObject hideBgImages];
        gameMode = kNormalMode;
        CGPoint objectsize = [self getObjectSize];
        [placedObjectsArray addObject:selectedObject ];
        
        //object intersection
        CGPoint gridPoint = [self getGridPointForPosition:selectedObject.lowestPoint];
        if ([[MCGameEngineController sharedObject] checkForObjectIntersection:gridPoint.x andColoumn:gridPoint.y andObjectSize:objectsize]) {
            [[MCGameEngineController sharedObject] updateGameInfoWithObject:selectedObject forX:(int)gridPoint.x andY:(int)gridPoint.y andObjectSize:objectsize];
            [[CharacterController getInstance] populateAisleDestinationsWith:gridPoint andRotation:NO];
            [[CharacterController getInstance] UpdateCharacterPaths];
        }
        

//        if (!OneCharacter) {
            [self fetchRandomCharacter];
//            OneCharacter = YES;
//        }
//        [[storyBoardViewController managementView]openViewWithAnimation:YES];
        self.selectedObject = nil;
        
        if (!self.selectedObject) {
            [[storyBoardViewController managementView]closeViewWithAnimation:YES];
            
        }
        self.selectedObject.isObjectRotated = NO;
        [self getChildByTag:444].visible = NO;
        //lx
        self.selectedObject.sellingPrice = [storyBoardViewController pricingView].currentCost;
        [self.selectedObject updateAisleConsumptionRate];

    }
    
    
}

- (void)setZorder
{
    CGPoint objectSize = [self getObjectSize];
    NSLog(@"%@", NSStringFromCGPoint(objectSize));
    //    int zX = closestTile.tileTag.x +closestTile.tileTag.y +2 - objectSize.x;
    //    int zY = closestTile.tileTag.x + closestTile.tileTag.y +2 - objectSize.y;
    //    int _Z = zX>zY?zY:zX;
    //    int _Z = 3*closestTile.tileTag.y+(1*closestTile.tileTag.x-2);//...its workin..check if any issues araises

//    int _Z = closestTile.tileTag.y+closestTile.tileTag.x;//+(2-3/*objects largest dimension*/);
//    [self reorderChild:selectedObject.objectSprite z:_Z*5];
    CGPoint zValue = [self getGridPointForPosition:selectedObject.lowestPoint];
    int zX = zValue.x+zValue.y+2-objectSize.x;
    int zY = zValue.x+zValue.y+2-objectSize.y;
    int _Z =  zX>zY?zX:zY;
    [self reorderChild:selectedObject.objectSprite z:_Z*5];
                      
    
    
    
}

- (void)rotateCurrentObject
{
    self.selectedObject.rotateCount++;
    if (self.selectedObject.rotateCount > 3) {
        self.selectedObject.rotateCount = 0;
    }
    if (self.selectedObject.rotateCount == 1 ) {
        [self.selectedObject.objectSprite setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"%@_1.png",self.selectedObject.code]]];
        self.selectedObject.isObjectRotated = YES;
    }else if (self.selectedObject.rotateCount == 2 ) {
        [self.selectedObject.objectSprite setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"%@_2.png",self.selectedObject.code]]];
        self.selectedObject.isObjectRotated = NO;
    }
    else if (self.selectedObject.rotateCount == 3 ) {
        [self.selectedObject.objectSprite setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"%@_3.png",self.selectedObject.code]]];
        self.selectedObject.isObjectRotated = YES;
    }
    else if (self.selectedObject.rotateCount == 0 ) {
        [self.selectedObject.objectSprite setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"%@_0.png",self.selectedObject.code]]];
        self.selectedObject.isObjectRotated = NO;
    }
    


    

}


- (CGPoint)getObjectSize
{
    CGPoint objectsize;
    if (self.selectedObject.isObjectRotated) {
        objectsize = ccp(_AISLE_COLUMNS,_AISLE_ROWS);
    } else {
        objectsize = ccp(_AISLE_ROWS,_AISLE_COLUMNS);
    }
    return objectsize;
}

#pragma mark -
#pragma mark Object Movement
#pragma mark

- (void)objectTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CCDirector *director = [CCDirector sharedDirector];
    CGPoint touchPoint = [self convertToNodeSpace:[director convertToGL:[touch locationInView:[director openGLView]]]];
    [self moveObject:selectedObject fromLocation:touchPoint withTouch:touch];
    
}

/** */
- (void)moveObject:(MCObject*)object fromLocation:(CGPoint)touchPoint withTouch:(UITouch*)touch
{
   [gameEngineController disableGestures];
//    if (CGRectContainsPoint([object.objectSprite boundingBox], touchPoint)) {
//        [gameEngineController disableGestures];
//    }
//    CGPoint a = ccp(object.objectSprite.position.x+_TILE_WIDTH/2, object.objectSprite.position.y);
//    [label1 setString:NSStringFromCGPoint(a)];
//    label1.position = a;
//    
//    CGPoint b = ccp(object.objectSprite.position.x+object.objectSprite.contentSize.width, object.objectSprite.position.y+3*_TILE_HEIGHT/2);
//    [label2 setString:NSStringFromCGPoint(b)];
//    label2.position = b;
//    
//    CGPoint c = ccp(object.objectSprite.position.x+object.objectSprite.contentSize.width, object.objectSprite.position.y+object.objectSprite.contentSize.height);
//    [label3 setString:NSStringFromCGPoint(c)];
//    label3.position = c;
//    
//    CGPoint d = ccp(object.objectSprite.position.x, object.objectSprite.position.y+(object.objectSprite.contentSize.height /2));
//    [label4 setString:NSStringFromCGPoint(d)];
//    label4.position = d;
//    NSMutableArray *objectBoundaryRect = [self getObjectBoundaryRect];
//    CGPoint a1 = CGPointFromString([objectBoundaryRect objectAtIndex:0]);
//    CGPoint b1 = CGPointFromString([objectBoundaryRect objectAtIndex:1]);
//    CGPoint c1 = CGPointFromString([objectBoundaryRect objectAtIndex:2]);
//    CGPoint d1 = CGPointFromString([objectBoundaryRect objectAtIndex:3]);
//   if (touchPoint.y > a1.y && touchPoint.x > d1.x && touchPoint.x < b1.x && touchPoint.x < c1.y) {
//         [gameEngineController disableGestures];
//        
//    }
//   else {
//       [gameEngineController enableGestures];
//   }
    CCSprite *objectSprite = object.objectSprite;
    if(self.selectedObject != nil)
    {
        [self objectPlacementOnGrid:touchPoint];
        objectSprite.opacity = 70;
        
    }

    
    //lx
    self.selectedObject.depletingLabel.position = selectedObject.lowestPoint;
   
}


//-(CGPoint)getPoint:(int)row:(int)col
//{
//	float unitwidth = _TILE_WIDTH ;
//	float unitHeight = _TILE_HEIGHT ;
//	
//	CGPoint pt = ccp(startPoint.x - row*unitwidth/2,startPoint.y - row*unitHeight/2);
//	pt = ccp(pt.x+ col*unitwidth/2,pt.y-col*unitHeight/2 - unitHeight);
//	return pt;
//}

#pragma mark -
#pragma mark New Grid Caluculations
#pragma mark -

-(CGPoint)getPosForGridRow:(int)row andColumn:(int)column
{
    CGPoint gridPosition = ccp(startPoint.x +((column*_TILE_WIDTH/2)-(row *_TILE_WIDTH/2)),startPoint.y -((row*_TILE_HEIGHT/2)+(column*_TILE_HEIGHT/2))-_TILE_HEIGHT/2); //lx added -tile height/2 in the end

    return gridPosition;
}


-(CGPoint)getGridPointForPosition:(CGPoint)point
{
    float x,y;
    y= (((point.x- (startPoint.x ))/(_TILE_WIDTH/2)) + ((point.y - (startPoint.y ))/-(_TILE_HEIGHT/2)))/2;
    x= -(((point.x -(startPoint.x ))/(_TILE_WIDTH/2)) - y);
    
    return ccp((int)x, (int)y); //Lx returning back to use the points
    
//    CGPoint gridMidPoint = [self getPosForGridRow:x andColumn:y];
//    
//    //Leftl;x
//    if (point.x < gridMidPoint.x) {
//        
//        if (point.y > gridMidPoint.y) {
//            //TopLeft
//            if ([self isLeft:ccp(gridMidPoint.x,gridMidPoint.y +_TILE_HEIGHT/2) withLinePoint:ccp(gridMidPoint.x - (_TILE_WIDTH/2),gridMidPoint.y) againstPoint:point]) {
//                
//                if (point.y < (gridMidPoint.y + _TILE_HEIGHT/2)) {
//                    --y;
//                }
//                else if([self isRight:ccp(gridMidPoint.x - (_TILE_WIDTH/2),gridMidPoint.y+_TILE_HEIGHT) withLinePoint:ccp(gridMidPoint.x,gridMidPoint.y +_TILE_HEIGHT/2) againstPoint:point]){
//                    --x;
//                    --y;
//                }
//                else
//                {
//                    --y;
//                }
//            }
//        }
//        else if (point.y < gridMidPoint.y){
//            if ([self isLeft:ccp(gridMidPoint.x - (_TILE_WIDTH/2),gridMidPoint.y) withLinePoint:ccp(gridMidPoint.x,gridMidPoint.y -_TILE_HEIGHT/2) againstPoint:point]) {
//                
//                if (point.y > (gridMidPoint.y - _TILE_HEIGHT/2)) {
//                    ++x;
//                }
//                else if([self isRight:ccp(gridMidPoint.x - (_TILE_WIDTH/2),gridMidPoint.y-_TILE_HEIGHT) withLinePoint:ccp(gridMidPoint.x,gridMidPoint.y +_TILE_HEIGHT/2) againstPoint:point]){
//                    ++x;
//                    ++y;
//                }
//                else
//                {
//                    ++x;
//                }
//            }
//            
//            //BottomLeft
//        }
//    }
//    else if (point.x > gridMidPoint.x){
//        
//        if (point.y > gridMidPoint.y) {
//            //TopRight
//            if ([self isRight:ccp(gridMidPoint.x,gridMidPoint.y +_TILE_HEIGHT/2) withLinePoint:ccp(gridMidPoint.x + (_TILE_WIDTH/2),gridMidPoint.y) againstPoint:point]) {
//                
//                if (point.y < (gridMidPoint.y + _TILE_HEIGHT/2)) {
//                    --x;
//                }
//                else if([self isLeft:ccp(gridMidPoint.x +(_TILE_WIDTH/2),gridMidPoint.y+_TILE_HEIGHT) withLinePoint:ccp(gridMidPoint.x,gridMidPoint.y +_TILE_HEIGHT/2) againstPoint:point]){
//                    --x;
//                    --y;
//                }
//                else
//                {
//                    --x;
//                }
//            }
//        }
//        else if (point.y < gridMidPoint.y){
//            
//            if ([self isRight:ccp(gridMidPoint.x +(_TILE_WIDTH/2),gridMidPoint.y) withLinePoint:ccp(gridMidPoint.x,gridMidPoint.y -_TILE_HEIGHT/2) againstPoint:point]) {
//                
//                if (point.y > (gridMidPoint.y - _TILE_HEIGHT/2)) {
//                    ++y;
//                }
//                else if([self isLeft:ccp(gridMidPoint.x,gridMidPoint.y -_TILE_HEIGHT/2) withLinePoint:ccp(gridMidPoint.x + (_TILE_WIDTH/2),gridMidPoint.y-_TILE_HEIGHT) againstPoint:point]){
//                    ++x;
//                    ++y;
//                }
//                else
//                {
//                    ++y;
//                }
//            }
//            
//            //BottomRight
//        }
//        
//    }
//    
//    CGPoint gridPosition = ccp(x,y);
//    return gridPosition;
}

//-(bool)isRight:(CGPoint)a withLinePoint:(CGPoint)b againstPoint:(CGPoint) c{
//    return ((b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x)) < 0;
//}
//
//-(bool)isLeft:(CGPoint)a withLinePoint:(CGPoint)b againstPoint:(CGPoint) c{
//    return ((b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x)) > 0;
//}
//#pragma mark 
//#pragma mark - updateSessionInfo
//#pragma mark
//
//-(void)updateSessionInfo
//{
//    NSArray 
//}
#pragma mark -
#pragma mark Grid Caluculations
#pragma mark -

- (void)placeObjectInCorrectPos:(NSDictionary *)objectDict
{
    if (self.selectedObject == nil)
    {
        MCObject *object = [[MCAilse alloc]initWithObject:objectDict];
        self.selectedObject = object;
        self.selectedObject.objectSprite.position = ccp(startPoint.x-100,startPoint.y-300);
        
        self.selectedObject.isObjectRotated = NO;
        [[storyBoardViewController managementView]viewOpenAndCloseAnimation];
    }
    
}

- (void)objectPlacementOnGrid:(CGPoint)touchPoint
{
    
    CGPoint posInGrid =[self getGridPointForPosition:touchPoint];
    CGPoint lowestPoint = [self getLowestPointOfObject];
    CGPoint gridOfObject  = [self getGridPointForPosition:lowestPoint];
    NSLog(@"posInGrid= %@ gridOfObject = %@ spriPos = %@",NSStringFromCGPoint(posInGrid), NSStringFromCGPoint(gridOfObject), NSStringFromCGPoint( selectedObject.lowestPoint));
    CGPoint gridPos =  [self getPosForGridRow:posInGrid.x andColumn:posInGrid.y];
    CGPoint objectsize = [self getObjectSize];
    if ([self objectMovable:posInGrid withObjectSize:objectsize])
    {
    
        if (!self.selectedObject.isObjectRotated)
        {
            touchPoint.x = gridPos.x - _TILE_WIDTH/2;
            touchPoint.y = gridPos.y - _TILE_HEIGHT/2;
        }
        else
        {
            touchPoint.x = gridPos.x - _AISLE_ROWS *_TILE_WIDTH/2;
            touchPoint.y = gridPos.y - _TILE_HEIGHT/2;
        }
        
        selectedObject.objectSprite.position = ccp(touchPoint.x, touchPoint.y);
        if (![[MCGameEngineController sharedObject] checkForObjectIntersection:gridOfObject.x andColoumn:gridOfObject.y andObjectSize:objectsize])
        {
            self.selectedObject.isObjectPlaceable = NO;
            [self.selectedObject changeToRedLayer:gridPos];
        }
        else
        {
            self.selectedObject.isObjectPlaceable = YES;
            [self.selectedObject changeToGreenLayer:gridPos];
            
        }
        
    }


    //!< lx >!//
    
    
    //    NSLog(@"posInGrid :%@, gridPos = :%@",NSStringFromCGPoint(posInGrid),NSStringFromCGPoint(gridPos));
    
}
/**
 * boundary checking 
 */

- (BOOL)objectMovable:(CGPoint)currGridPos withObjectSize:(CGPoint)objectSize
{
    NSLog(@"currGridPos :%@ objectSize :%@",NSStringFromCGPoint(currGridPos), NSStringFromCGPoint(objectSize));
    if(((currGridPos.x >= objectSize.x-1))  &&((currGridPos.y >= objectSize.y-1))&&((currGridPos.x <= 100)  &&(currGridPos.y <= 100)))
        return true;

    return false;
}


/////// Find where the grid
//
//-(CGPoint)FindGridPos:(CGPoint)gridSquarePos
//{
//    CGPoint gridPos;
//    
//    for (int nRow =0; nRow < [m_arrGrid count]; ++nRow) {
//        
//        NSMutableArray *column = [m_arrGrid objectAtIndex:nRow];
//        
//        for (int nColumn= 0; nColumn < [column count]; ++nColumn) {
//            
//            MCTileSprite *tile = [column objectAtIndex:nColumn];
//            
//            if (tile.position.x  == gridSquarePos.x && tile.position.y == gridSquarePos.y)
//            {
//                gridPos.x = nRow;
//                gridPos.y = nColumn;
//            }
//            
//        }
//    }
//    return gridPos;
//}
//
//- (MCTileSprite *)FindClosestGrid:(CGPoint) pos
//{
//    CGPoint closestGridPos;
//    float ClosestDistance = MAXFLOAT;
//    closestTile = [[[MCTileSprite alloc] init]autorelease];
//
//    for (unsigned int nIndex = 0; nIndex < [m_arrGridSquares count]; ++nIndex) {
//        
//        MCTileSprite *currTile = [m_arrGridSquares objectAtIndex:nIndex];
//        CGFloat currDistance = [self AbsoluteDistanceBetweenTwoPoints:pos withArg2:currTile.position ];
//        
//        if (currDistance < ClosestDistance)
//        {
//            closestGridPos = currTile.position;
//            ClosestDistance = currDistance;
//            closestTile = currTile;           
//        }
//    }
//    
//    
//    return closestTile;
//}
//
//
//
//-(CGFloat)AbsoluteDistanceBetweenTwoPoints:(CGPoint)point1 withArg2:(CGPoint)point2;
//{
//    CGFloat dx = point2.x - point1.x;
//    CGFloat dy = point2.y - point1.y;
//    return abs(sqrt(dx*dx + dy*dy ));
//};

- (MCObject *)getObjectForTouchPoint:(CGPoint)touch
{
    
    for(MCObject *object in placedObjectsArray)
    {
        
        if (CGRectContainsPoint([object.objectSprite boundingBox], touch)) {
            return object;
        }
    }
    
    return selectedObject;
}


//-(BOOL)checkForObjectIntersection
//{
//    CGPoint objectsize = [self getObjectSize];
//   
//        for (int i=0; i<objectsize.y; i++)
//        {
//            for (int j=0; j<objectsize.x; j++)
//            {
//                if ([self isTileWithTagOccupied:((closestTile.tag+i*1000)+(j*_INITIAL_ROWS*1000))]) {
//                    return  true;
//                    
//                }
//            }
//        }
//    return false;
//    
//}

-(BOOL)isTileWithTagOccupied:(int)tileTag
{
    MCTileSprite *tile = (MCTileSprite *)[self getChildByTag:tileTag];
  //  NSLog(@"tile tag = %d", tile.tag);
    if (tile.isOccupied) {
//        NSLog(@"true = %d", tileTag);
        return true;
    }
//    NSLog(@"false = %d", tileTag);
    return false;
}


#pragma mark -
#pragma mark Game Timer
#pragma mark -

- (void)gameTimerStart
{
    [self schedule:@selector(updateAllObjectsTimer) interval:1.0/8.0];
}

- (void)updateAllObjectsTimer
{    for (int i = 0; i< [placedObjectsArray count]; i++)
    {
        [(MCObject *)[placedObjectsArray objectAtIndex:i] ObjectStatusUpdate];
    }
    [self getLowestPointOfObject];
    [self characterControl];
}

/**
 * lowest point of object
 */

- (CGPoint)getLowestPointOfObject
{
    if (!selectedObject.isObjectRotated) {
        selectedObject.lowestPoint = ccp(selectedObject.objectSprite.position.x+_TILE_WIDTH/2, selectedObject.objectSprite.position.y+_TILE_HEIGHT/ 2);
    }else{
        selectedObject.lowestPoint = ccp(selectedObject.objectSprite.position.x+_TILE_WIDTH/2 +_TILE_WIDTH, selectedObject.objectSprite.position.y + _TILE_HEIGHT/2);
    }
    self.selectedObject.depletingLabel.position = selectedObject.lowestPoint;
//    [self getObjectBoundaryRect];
    
    return selectedObject.lowestPoint;
}

- (NSMutableArray *)getObjectBoundaryRect
{
     a = ccp(selectedObject.objectSprite.position.x, selectedObject.objectSprite.position.y);
     b = ccp(selectedObject.objectSprite.position.x+selectedObject.objectSprite.contentSize.width, selectedObject.objectSprite.position.y);
     c = ccp(selectedObject.objectSprite.position.x+selectedObject.objectSprite.contentSize.width, selectedObject.objectSprite.position.y+selectedObject.objectSprite.contentSize.height);
     d = ccp(selectedObject.objectSprite.position.x, selectedObject.objectSprite.position.y+selectedObject.objectSprite.contentSize.height);
    
    
    NSMutableArray *objectRectArray = nil;
    if (!objectRectArray) {
        objectRectArray = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",NSStringFromCGPoint(a)],
                                                                 [NSString stringWithFormat:@"%@",NSStringFromCGPoint(b)],
                                                                 [NSString stringWithFormat:@"%@",NSStringFromCGPoint(c)],
                                                                 [NSString stringWithFormat:@"%@",NSStringFromCGPoint(d)], nil];
    }
    return objectRectArray;
    
}

//- (void)draw
//{
////    glColor4f(0.8, 1.0, 0.76, 1.0);
////	glLineWidth(8.0f);
////    ccDrawLine(a, b);
////    ccDrawLine(b, c);
////    ccDrawLine(c, d);
////    ccDrawLine(d, a);
////       ccDrawColor4F(0, 1, 0, 1);
//}
#pragma mark -
#pragma mark Tile Expansion
#pragma mark -


-(void)ExpandGridFromRow:(int)startRow startingAtColumn:(int)startColumn by:(int)endRow rowsAndColumns:(int)endColumns
{
    int tagVal = 0;
    
    
    [[MCGameEngineController sharedObject] addExpansionStartingAtRow:startRow andColumn:startColumn ByRows:endRow AndColumns:endColumns];
    for (int i=startRow; i<(startRow+endRow); i++)
    {
        NSAutoreleasePool *aPool = [[NSAutoreleasePool alloc] init];
        
        //Column Grid stuff
        
        for (int j = startColumn; j<(startColumn+endColumns); j++)
        {
            NSString *aStr;
            int zOrderTile = -10000000000000;
            aStr = [NSString stringWithFormat:@"Tile_128.png"];
            MCTileSprite *tile = [MCTileSprite spriteWithFile:aStr];
            //tile.position = ccp(refPoint.x+j*((_TILE_WIDTH-offsetVal)/2), refPoint.y-j*((_TILE_HEIGHT-offsetVal)/2));
            //            tile.scale = 0.5;
            
            tile.position =  [self getPosForGridRow:i andColumn:j];
            
            tile.tag = tagVal*(-1000);
            tile.isOccupied = NO;
            tile.tileTag = CGPointMake(i, j);
            
            
            // [gridDict setObject:[NSNumber numberWithInt:0] forKey:[NSString stringWithFormat:@"%ix%i",i,j]];
            
            //          [[MCGameEngineController sharedObject].backGroundScrollLayer addChild:tile z:zOrderTile];
            [tilenode addChild:tile z:zOrderTile];
            
                      //
            //            CCLabelTTF *labelTile = [CCLabelTTF labelWithString:@"" fontName:@"TIMES NEW ROMAN" fontSize:20];
            //            [labelTile setString:[NSString stringWithFormat:@"%d",/*NSStringFromCGPoint(tile.position) */ tile.tag]];
            //            labelTile.color = ccc3(0, 0, 0);
            //            labelTile.position = tile.position;
            //            [self addChild:labelTile z:zOrderTile+1];
            
            tagVal++;
            // NSLog(@"%f, %f", tile.position.x, tile.position.y);
            //  Grid stuff // add tile to list of unsorted gridsquares
            
        }
        
        [aPool release];
    }
}

#pragma mark -
#pragma mark CHARACTER CONTROL
#pragma mark -

- (void)fetchRandomCharacter  // lx to be standardised
{

    CGPoint entrancePoint = [self getPosForGridRow:0 andColumn:0];//ccp(2500+([placedObjectsArray count]*100),2500);
     NSLog(@"entrancepoint = %@", NSStringFromCGPoint(entrancePoint));
    CGPoint destinationPoint = ccp(10,10);
    
    CGPoint entranceGrid = [self getGridPointForPosition:entrancePoint];
    Character *character = [self generateCharacterWithSourceIndex:entranceGrid destinationIndex:destinationPoint andDirection:DOWN];
    
    
    if (character)
    {
        character.currAction =WALKING_ACTION;// FREE_LOOK;  // lx 19/2 to be cha
        [[CharacterController getInstance].allAvatars addObject:character];
      
    }
}


- (void)fetchCharacterOfKind:(NSString *)typeCode atGrid:(CGPoint)atGrid withAction:(CharacterActions)initAction andDirection:(Direction)aDirection    ///lx to be standardised
{
    Character *character  = [self generateStaffOfType:typeCode SourceIndex:atGrid destinationIndex:ccp(8,0) andDirection:aDirection];
    CGPoint destinationPoint = ccp(10, 10);
//    if (character) {
        character.currAction = initAction;
        [[CharacterController getInstance].allAvatars addObject:character];
//    }

}
/////////// lx testing///////////////////////////////////////////


-(Character *)generateStaffOfType:(NSString *)employeeKind SourceIndex:(CGPoint)sourcePoint destinationIndex:(CGPoint)destinationPoint andDirection:(Direction)aDirection
{
    NSString *tempStr;
    int action =WALKING_ACTION;// LOOKING;// walking   ///lx 19/2
    CGPoint aPoint;
    aPoint = sourcePoint;
    
    NSString *charName = employeeKind; //0_13
    NSString *plistName = [[NSString alloc] initWithFormat:@"%@/%@_%d_1.plist",[[NSBundle mainBundle]resourcePath],charName,action];
    NSLog(@"req plist = %@", plistName);
    NSString *resourceImageInfoPath = [NSString stringWithFormat:@"%@/%@_%d_1.plist",IMAGES_PATH, charName, action];
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:plistName] && ![[NSFileManager defaultManager]fileExistsAtPath:resourceImageInfoPath])
    {
        [levelCharacters removeObject:charName];
        charName = @"0_0_1";
        NSLog(@"******** %@ plist dosent exist********", plistName);
    }
    
    tempStr = [[NSString alloc] initWithFormat:@"%@_%d_1", charName, action];// 0_13_1_1
    
    Character *aCharacter = [[Character alloc] initWithParams:self characterName:charName imageName:tempStr];
    
    aCharacter.sourceGridIndex =aPoint;
    aCharacter.destinationGridIndex = destinationPoint;
    if(gameMode == kCreateMode)
    {
        aCharacter.characterSprite.visible = NO;
    }
    [aCharacter initializeCharacter];
    aCharacter.characterTypeName = [self getCharacterType:charName];
    [levelCharacters removeObject:charName];
    aCharacter.empType = [self getEmployeeType:charName];    /// get emp type
    
    [allCharacters addObject:aCharacter];
    [aCharacter release];
    return  aCharacter;
}


-(int)getCharacterType:(NSString *)customerName
{
    NSArray *cus = [customerName componentsSeparatedByString:@"_"];
    NSString *type = [cus objectAtIndex:0];
    int typeBit  = [type integerValue];
    
    CharacterTypeName retVal;
    
    switch (typeBit) {
        case 0:
            retVal = zCustomer;
            break;
        case 1:
            retVal = zEmployee;
        default:
            break;
    }
    return retVal;
}

-(int) getEmployeeType:(NSString *)employeeName
{
    NSArray *emp = [employeeName componentsSeparatedByString:@"_"];
    NSString *type = [emp objectAtIndex:1];
    int typeCode = [type integerValue];
    
    
    if (typeCode == 111)
        return zManager;
    else if(typeCode == 122 || typeCode == 133)
        return  zRegular;
    else if (typeCode == 143 || typeCode == 153)
        return zCleaner;
    
    return zRegular;
}

/////////////////////////////////////////////////////////////


/**
 * Setting texture
 */
-(void) setTextureForThirtyTwoBits
{
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
}

-(void) setTextureForSixteenBits
{
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
}


-(void) characterControl
{
    for (int i=0; i< [allCharacters count]; i++) {
        Character *tCharacter = [[CharacterController getInstance].allAvatars objectAtIndex:i];
        [tCharacter updateCharacterAction];
    }
}

-(Character *)generateCharacterWithSourceIndex:(CGPoint)sourcePoint destinationIndex:(CGPoint)destinationPoint andDirection:(Direction)aDirection 
{   
    NSString *tempStr;
    int action =WALKING_ACTION;// LOOKING;// walking   ///lx 19/2
    CGPoint aPoint;
    aPoint = sourcePoint; 
    
    NSString *charName = [self getRandomCharacterName]; //0_13
    NSString *plistName = [[NSString alloc] initWithFormat:@"%@/%@_%d_1.plist",[[NSBundle mainBundle]resourcePath],charName,action];
    NSLog(@"req plist = %@", plistName);
    NSString *resourceImageInfoPath = [NSString stringWithFormat:@"%@/%@_%d_1.plist",IMAGES_PATH, charName, action];
    NSLog(@"%@", resourceImageInfoPath);
    if (![[NSFileManager defaultManager]fileExistsAtPath:plistName] && ![[NSFileManager defaultManager]fileExistsAtPath:resourceImageInfoPath])
    {
        [levelCharacters removeObject:charName];
        charName = @"0_0_1";
        NSLog(@"******** %@ plist dosent exist********", plistName);
    }
    
    tempStr = [[NSString alloc] initWithFormat:@"%@_%d_1", charName, action];// 0_13_1_1

    Character *aCharacter = [[Character alloc] initWithParams:self characterName:charName imageName:tempStr];

    aCharacter.sourceGridIndex =aPoint;
    aCharacter.destinationGridIndex = destinationPoint;
    if(gameMode == kCreateMode)
    {
        aCharacter.characterSprite.visible = NO;
    }
    [aCharacter initializeCharacter];
    aCharacter.characterTypeName = [self getCharacterType:charName];
    aCharacter.empType = [self getEmployeeType:charName];   /// testing lx; to be removed
    NSLog(@"%d", aCharacter.empType);
    [levelCharacters removeObject:charName];
    [allCharacters addObject:aCharacter];
    [aCharacter release];
    return  aCharacter;    
}

//-(int)getCustomerType:(NSString *)customerName
//{
//    if ([customerName isEqualToString:@"0_13"])
//    {
//        return zCustomer;//return zKidMale;
//    }
//    else if([customerName isEqualToString:@"0_23"])
//    {
//        return zCustomer;//return  zKidFemale;
//    }
//    else if([customerName isEqualToString:@"0_33"])
//    {
//        return zCustomer;//return zTeenMale;
//    }
//    else if([customerName isEqualToString:@"0_43"])
//    {
//        return zCustomer;//return zTeenFemale;
//    }
//    else if([customerName isEqualToString:@"0_53"])
//    {
//        return zCustomer;//return zOldLady;
//    }
//    else if([customerName isEqualToString:@"0_63"])
//    {
//        return zCustomer;//return zPunk;
//    }
//    else if([customerName isEqualToString:@"0_cl1"])
//    {
//        return zEmployee;
//    }
//    return zKidMale;
//}

- (NSString *) getRandomCharacterName
{
    if ([levelCharacters count] <= 0)
    {
        [levelCharacters addObject:@"0_33"];
        [levelCharacters addObject:@"0_43"];
        [levelCharacters addObject:@"0_53"];
//        [levelCharacters addObject:@"0_43"];
//        [levelCharacters addObject:@"0_53"];
//        [levelCharacters addObject:@"0_63"];
//        [levelCharacters addObjectsFromArray: unlockedCharacters];
    }
    
    int charCount = [levelCharacters count];
    int randType = rand()%charCount;
    NSString *imageName = [levelCharacters objectAtIndex:randType];
//    NSString *imageName =@"0_53";//@"0_43"; // @"0_13"; // lx 19/2
    return imageName;
}

#pragma mark - 
#pragma mark asyncTexture
- (void)getTexturesSelector:(SEL)sel forTarget:(Character *)target withObject:(id)object
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    CSAsyncObject *asyncObject = [[CSAsyncObject alloc] init];
    [target retain];
    
    asyncObject.target_ = target;
    asyncObject.callBack_ = sel;
    asyncObject.object_ = object;
    [self performSelectorOnMainThread:@selector(getTextures:) withObject:asyncObject waitUntilDone:NO];
    [target release];
    [pool release];
}

-(void)getTextures:(CSAsyncObject *)asyncObject
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    Character *character = asyncObject.target_;
    [character retain];
    NSLog(@"charactename = %@ curranima= %d currdir = %d totImgCnt = %d", character.characterName, character.currAnimation, character.currentDirection, character.totalImageCount);
    if (character.currentDirection == 0) {
        character.currentDirection = 1;
    }

    NSMutableArray *texturesAray = [[MCImageCache sharedMCImageCache] getCharacterImageSetWithName:character.characterName
                                                                                        actionType:character.currAnimation actionSubType:character.currentDirection totImgCnt:character.totalImageCount];
    NSLog(@"texarraycount=%d", [texturesAray count]);
    [asyncObject.target_ performSelector:asyncObject.callBack_ withObject:texturesAray];
    [asyncObject release];
    [character release];
    [pool release];
}

#pragma mark -
#pragma mark Touch_events
#pragma mark -

//touch began handles the all the objects Touch events n respective actions logic.
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent*)event
{
  
    CCDirector *director = [CCDirector sharedDirector];
    UITouch *touch = [touches anyObject];
    CGPoint  point = [touch locationInView:[director openGLView]];
    CGPoint touchPoint = [director convertToGL:point];
	touchPoint = [self convertToNodeSpace:touchPoint];
    
    touchesBeganpt = touchPoint;
    CGRect rect = [selectedObject.objectSprite boundingBox];
    CGPoint vertices[4]={
        ccp(rect.origin.x,rect.origin.y),
        ccp(rect.origin.x+rect.size.width,rect.origin.y),
        ccp(rect.origin.x+rect.size.width,rect.origin.y+rect.size.height),
        ccp(rect.origin.x,rect.origin.y+rect.size.height),
    };
    ccDrawPoly(vertices, 4, YES);
 
    if (CGRectContainsPoint([selectedObject.objectSprite boundingBox], touchPoint)) {
        isObjectCanDrag = YES;
        return;
    }
    
    if ([storyBoardViewController purchaseView].isViewOpen) {
        [[storyBoardViewController purchaseView] viewOpenAndCloseAnimation];
    }
    if ([storyBoardViewController managementView].isViewOpen) {
        [[storyBoardViewController managementView]disableAllButtons];
    }
       
    
   if ((gameEngineController.backGroundScrollLayer.isZoomingStarted || gameEngineController.backGroundScrollLayer.isCanMove) && !isObjectCanDrag)
   {
        self.isTouchEnabled = NO;
		[gameEngineController enableGestures];
        return;
    }
   
 
    
//    NSMutableArray *objectBoundaryRect = [self getObjectBoundaryRect];
//    CGPoint a1 = CGPointFromString([objectBoundaryRect objectAtIndex:0]);
//    CGPoint b1 = CGPointFromString([objectBoundaryRect objectAtIndex:1]);
//    CGPoint c1 = CGPointFromString([objectBoundaryRect objectAtIndex:2]);
//    CGPoint d1 = CGPointFromString([objectBoundaryRect objectAtIndex:3]);
//    if (touchPoint.y > a1.y && touchPoint.x > d1.x && touchPoint.x < b1.x && touchPoint.x < c1.y) {
//        [gameEngineController disableGestures];
//        
//    }
//    else{
//        [gameEngineController enableGestures];
//    }

    if (gameMode == kEditMode) {
        if (!selectedObject) {
            selectedObject = [self getObjectForTouchPoint:touchPoint];
            CGPoint gridOfObject  = [self getGridPointForPosition:selectedObject.lowestPoint];
            CGPoint objectSize = [self getObjectSize];
            [[MCGameEngineController sharedObject] updateGameInfoWithObject:selectedObject forX:gridOfObject.x andY:gridOfObject.y andObjectSize:objectSize];
            [self moveObject:selectedObject fromLocation:touchPoint withTouch:touch];
            
        }
       
    }
    
//    
//    CGPoint  gridPoint = [self getGridPostionForPoint:touchPoint];
//    NSLog(@"gridPoint :%@",NSStringFromCGPoint(gridPoint));
    
}


- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] openGLView]];
	CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
    spoint =  [self convertToNodeSpace:spoint];
    if (CGRectContainsPoint([selectedObject.objectSprite boundingBox], spoint))
    {
        isObjectCanDrag = YES;
    }
    if (isObjectCanDrag) {
        [self objectTouchesMoved:touches withEvent:event];
        return;
    }

    NSLog(@"spoint:%@ spoint :%@",NSStringFromCGPoint(spoint),NSStringFromCGPoint(touchesBeganpt));
    
    if (self.selectedObject == nil) {
        return;
    }
    if ((gameEngineController.backGroundScrollLayer.isZoomingStarted || gameEngineController.backGroundScrollLayer.isCanMove) && !isObjectCanDrag)
    {
        self.isTouchEnabled = NO;
		[gameEngineController enableGestures];
        return;
    }
      
     
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    isObjectCanDrag = NO;
 
    if (self.selectedObject == nil) {
        return;
    }
    if (gameEngineController.backGroundScrollLayer.isZoomingStarted|| gameEngineController.backGroundScrollLayer.isCanMove)
    {
        self.isTouchEnabled = NO;
        [gameEngineController enableGestures];
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] openGLView]];
	CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
	spoint = [self convertToNodeSpace:spoint];
    [gameEngineController enableGestures];
   
}

#pragma mark -
#pragma mark Expansion
#pragma mark-
-(void)Expansion:(id)sender
{    
    CGPoint ButtonPos =[sender position];
    
    CGPoint gridPos = [self getGridPointForPosition:ButtonPos];
    
    gridPos.x -=5;
    gridPos.y -=5;
  
    [self ExpandGridFromRow:gridPos.x startingAtColumn:gridPos.y by:10 rowsAndColumns:10];
    
    
    NSMutableArray *expCol = [arrExpRows objectAtIndex:gridPos.x/10];
    
    [expCol setObject:[NSNumber numberWithInt:1] atIndexedSubscript:gridPos.y/10];
    
    [arrExpRows setObject:expCol atIndexedSubscript:gridPos.x/10];
    
    [self removeChild:[sender parent] cleanup:YES];
    [self PopulateBuyableLand];
    
}


-(void)PopulateLandArray
{
    
    arrExpRows  = [[NSMutableArray alloc] init];
    for (unsigned int i = 0 ; i < 10; ++i) {
        NSMutableArray * arrColumns = [[NSMutableArray alloc] init];
        for (unsigned int j = 0; j < 10; ++j) {
            if (i+j) {
                [arrColumns addObject:[NSNumber numberWithInt:0]];
            }
            else
                [arrColumns addObject:[NSNumber numberWithInt:1]];
        }
        [arrExpRows addObject:arrColumns];
    }
}
-(void)PopulateBuyableLand
{
    bool top,left;
    while ([self getChildByTag:98756467] != nil) {
        [self removeChildByTag:98756467 cleanup:YES];
    }//
    
    while ([self getChildByTag:987564679] != nil) {
        [self removeChildByTag:987564679 cleanup:YES];
    }

    
    for ( int i = 0; i < 10; ++i) {
        
        
        for ( int j =0; j < 10; ++j) {
            
            if ([[[arrExpRows objectAtIndex:i]objectAtIndex:j] intValue] == 0) {
                
                
                top = NO;
                left = NO;
                if ((i-1) >=0) {
                    if ([[[arrExpRows objectAtIndex:i-1]objectAtIndex:j] intValue] > 0)  {
                        top = YES;
                    }
                    
                }
                
                if ((j-1) >=0) {
                    if ([[[arrExpRows objectAtIndex:i]objectAtIndex:j-1] intValue] > 0)  {
                        left = YES;
                    }
                    
                }
                if (top || left)
                {
                    //Generate Land
                    
                    
                    [self ExpandBuyableGridFromRow:i*10 startingAtColumn:j*10 by:10 rowsAndColumns:10];
                    //Generate Button
                    
                    CCMenuItem *Button1 = [CCMenuItemImage
                                           itemFromNormalImage:@"Buy_Icon.png"
                                           selectedImage:nil
                                           target:self selector:@selector(Expansion:)];
                    Button1.scale =2.0f;
                    Button1.tag = 8765;
                    
                    CCMenu *MainMenuButton = [CCMenu menuWithItems: Button1, nil];
                    
                    
                    Button1.position = [self getPosForGridRow:(i*10)+5 andColumn:(j*10)+5];
                    
                    
                   
                    MainMenuButton.tag = 98756467;
                    
                    [self addChild:MainMenuButton z:0];
                    
                    
                }
            }
            
        }
    }
}



-(void)ExpandBuyableGridFromRow:(int)startRow startingAtColumn:(int)startColumn by:(int)endRow rowsAndColumns:(int)endColumns
{
    int tagVal = 0;
    for (int i=startRow; i<(startRow+endRow); i++)
    {
        NSAutoreleasePool *aPool = [[NSAutoreleasePool alloc] init];
        
        //Column Grid stuff
        
        for (int j = startColumn; j<(startColumn+endColumns); j++)
        {
            NSString *aStr;
            int zOrderTile = -10000000000000;
            aStr = [NSString stringWithFormat:@"GreyTile.PNG"];
            MCTileSprite *tile = [MCTileSprite spriteWithFile:aStr];
            //tile.position = ccp(refPoint.x+j*((_TILE_WIDTH-offsetVal)/2), refPoint.y-j*((_TILE_HEIGHT-offsetVal)/2));
            //            tile.scale = 0.5;
            
            tile.position =  [self getPosForGridRow:i andColumn:j];
            
            tile.tag = 987564679;
            tile.isOccupied = NO;
            tile.tileTag = CGPointMake(i, j);
            
            
            // [gridDict setObject:[NSNumber numberWithInt:0] forKey:[NSString stringWithFormat:@"%ix%i",i,j]];
            
            //          [[MCGameEngineController sharedObject].backGroundScrollLayer addChild:tile z:zOrderTile];
            [self addChild:tile z:zOrderTile];
            
            
            //
            //            CCLabelTTF *labelTile = [CCLabelTTF labelWithString:@"" fontName:@"TIMES NEW ROMAN" fontSize:20];
            //            [labelTile setString:[NSString stringWithFormat:@"%d",/*NSStringFromCGPoint(tile.position) */ tile.tag]];
            //            labelTile.color = ccc3(0, 0, 0);
            //            labelTile.position = tile.position;
            //            [self addChild:labelTile z:zOrderTile+1];
            
            tagVal++;
            // NSLog(@"%f, %f", tile.position.x, tile.position.y);
            //  Grid stuff // add tile to list of unsorted gridsquares
            
        }
        
        [aPool release];
    }
}

-(void)ToggleExpandButtons
{  
    if (!ExpandButtons) {
        
        [self PopulateBuyableLand];
    }
    else
    {
        while ([self getChildByTag:98756467] != nil) {
            [self removeChildByTag:98756467 cleanup:YES];
        }//
        
        while ([self getChildByTag:987564679] != nil) {
            [self removeChildByTag:987564679 cleanup:YES];
        }
    }
    
    ExpandButtons = !ExpandButtons;
}
@end



