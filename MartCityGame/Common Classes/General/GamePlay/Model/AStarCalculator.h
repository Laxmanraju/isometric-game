//
//  AStarCalculator.h
//  MartCityGame
//
//  Created by Sangam Gupta on 13/02/13.
//
//

#import <Foundation/Foundation.h>


@interface AStarCalculator : NSObject
{
    NSMutableArray *spOpenSteps,*spClosedSteps,*shortestPath;
    CGPoint fromTileCoor,toTileCoord;
    BOOL pathCalculated,calculatingPath;
    
}


@property(nonatomic,assign)BOOL pathCalculated;
@property(nonatomic,assign)BOOL calculatingPath;
@property(nonatomic,assign)CGPoint fromTileCoor;
@property(nonatomic,assign)CGPoint toTileCoord;
@property(nonatomic,retain)NSMutableArray *shortestPath;


- (void)CalculatePath;
-(void)RecalculatePath:(int)StepIndex;
-(void)AsyncCalcPath;


@end
// A class that represents a step of the computed path
@interface ShortestPathStep : NSObject
{
	CGPoint position;
	int gScore;
	int hScore;
    ShortestPathStep *parent;
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) int gScore;
@property (nonatomic, assign) int hScore;
@property (nonatomic, assign) ShortestPathStep *parent;

- (id)initWithPosition:(CGPoint)pos;
- (int)fScore;

@end


@interface AStarOperation :NSInvocationOperation
{
    
}
@end