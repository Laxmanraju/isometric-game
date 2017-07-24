//
//  AStarCalculator.m
//  MartCityGame
//
//  Created by Sangam Gupta on 13/02/13.
//
//

#import "AStarCalculator.h"
#import "MCGameEngineController.h"
#include "AppDelegate.h"



@implementation AStarCalculator

@synthesize shortestPath,pathCalculated,fromTileCoor,toTileCoord,calculatingPath;

- (id)init
{
    self = [super init];
    if (self) {
    
                shortestPath = [[NSMutableArray alloc] init];
        spOpenSteps = [[NSMutableArray alloc] init];
        spClosedSteps = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)CalculatePath
{
	// Start by stoping the current moving action
   	
	// Stop current effects
	
    calculatingPath = YES;
	// Init shortest path properties
    [spOpenSteps removeAllObjects];
    [spClosedSteps removeAllObjects];
    [shortestPath removeAllObjects];
    
	pathCalculated = NO;
    
   //   dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	// Get current tile coordinate and desired tile coord
		
	// Check that there is a path to compute ;-)
    
	if (CGPointEqualToPoint(fromTileCoor, toTileCoord)) {
        pathCalculated = YES;
		return;
	}
	
	// Must check that the desired location is walkable
	// In our case it's really easy, because only wall are unwalkable
    if ([self isWalkableTile:toTileCoord]) {
       
    }
	
	// Start by adding the from position to the open list
	[self insertInOpenSteps:[[[ShortestPathStep alloc]      initWithPosition:fromTileCoor] autorelease]];
	
	do {
		// Get the lowest F cost step
		// Because the list is ordered, the first step is always the one with the lowest F cost
		ShortestPathStep *currentStep = [spOpenSteps objectAtIndex:0];
        
		// Add the current step to the closed set
		[spClosedSteps addObject:currentStep];
        
		// Remove it from the open list
		// Note that if we wanted to first removing from the open list, care should be taken to the memory
		[spOpenSteps removeObjectAtIndex:0];
		
		// If the currentStep is at the desired tile coordinate, we have done
		if (CGPointEqualToPoint(currentStep.position, toTileCoord)) {
			[self constructPath:currentStep];
			spOpenSteps = nil; // Set to nil to release unused memory
			spClosedSteps = nil; // Set to nil to release unused memory
			break;
		}
		
		// Get the adjacent tiles coord of the current step
		NSArray *adjSteps = [self walkableAdjacentTilesCoordForTileCoord:currentStep.position];
		for (NSValue *v in adjSteps) {
            
			ShortestPathStep *step = [[ShortestPathStep alloc] initWithPosition:[v CGPointValue]];
			
			// Check if the step isn't already in the closed set
			if ([spClosedSteps containsObject:step]) {
				[step release]; // Must releasing it to not leaking memory ;-).
				continue; // Ignore it
			}
			
			// Compute the cost form the current step to that step
			int moveCost = [self costToMoveFromStep:currentStep toAdjacentStep:step];
            
			// Check if the step is already in the open list
			NSUInteger index = [spOpenSteps indexOfObject:step];
			
			if (index == NSNotFound) { // Not on the open list, so add it
				
				// Set the current step as the parent
				step.parent = currentStep;
                
				// The G score is equal to the parent G score + the cost to move from the parent to it
				step.gScore = currentStep.gScore + moveCost;
				
				// Compute the H score which is the estimated movement cost to move from that step to the desired tile coordinate
				step.hScore = [self computeHScoreFromCoord:step.position toCoord:toTileCoord];
				
				// Adding it with the function which is preserving the list ordered by F score
				[self insertInOpenSteps:step];
				
				// Done, now release the step
				[step release];
			}
			else { // Already in the open list
				
				[step release]; // Release the freshly created one
				step = [spOpenSteps objectAtIndex:index]; // To retrieve the old one (which has its scores already computed ;-)
				
				// Check to see if the G score for that step is lower if we use the current step to get there
				if ((currentStep.gScore + moveCost) < step.gScore) {
					
					// The G score is equal to the parent G score + the cost to move from the parent to it
					step.gScore = currentStep.gScore + moveCost;
					
					// Because the G Score has changed, the F score may have changed too
					// So to keep the open list ordered we have to remove the step, and re-insert it with
					// the insert function which is preserving the list ordered by F score
					
					// We have to retain it before removing it from the list
					[step retain];
					
					// Now we can removing it from the list without be afraid that it can be released
					[spOpenSteps removeObjectAtIndex:index];
					
					// Re-insert it with the function which is preserving the list ordered by F score
					[self insertInOpenSteps:step];
					
					// Now we can release it because the oredered list retain it
					[step release];
				}
			}
		}
		
	} while ([spOpenSteps count] > 0);
	
	if (shortestPath == nil) { // No path found
		
	}
         // });
}
// Insert a path step (ShortestPathStep) in the ordered open steps list (spOpenSteps)
- (void)insertInOpenSteps:(ShortestPathStep *)step
{
	int stepFScore = [step fScore]; // Compute only once the step F score's
	int count = [spOpenSteps count];
	int i = 0; // It will be the index at which we will insert the step
	for (; i < count; i++) {
		if (stepFScore <= [[spOpenSteps objectAtIndex:i] fScore]) { // if the step F score's is lower or equals to the step at index i
			// Then we found the index at which we have to insert the new step
			break;
		}
	}
	// Insert the new step at the good index to preserve the F score ordering
	[spOpenSteps insertObject:step atIndex:i];
}

// Compute the H score from a position to another (from the current position to the final desired position
- (int)computeHScoreFromCoord:(CGPoint)fromCoord toCoord:(CGPoint)toCoord
{
	// Here we use the Manhattan method, which calculates the total number of step moved horizontally and vertically to reach the
	// final desired step from the current step, ignoring any obstacles that may be in the way
	return abs(toCoord.x - fromCoord.x) + abs(toCoord.y - fromCoord.y);
}

// Compute the cost of moving from a step to an adjecent one
- (int)costToMoveFromStep:(ShortestPathStep *)fromStep toAdjacentStep:(ShortestPathStep *)toStep
{
	return ((fromStep.position.x != toStep.position.x) && (fromStep.position.y != toStep.position.y)) ? 14 : 10;
}


- (BOOL)isWalkableTile:(CGPoint)tile
{
     return [[MCGameEngineController sharedObject] checkForObjectIntersection:tile.x andColoumn:tile.y andObjectSize:ccp(1, 1)];
    
}

- (BOOL)isValidTileCoord:(CGPoint)tile
{
    return [[MCGameEngineController sharedObject] checkForObjectIntersection:tile.x andColoumn:tile.y andObjectSize:ccp(1, 1)];
}



- (NSArray *)walkableAdjacentTilesCoordForTileCoord:(CGPoint)tileCoord
{
	NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:8];
    
    BOOL t = NO;
    BOOL l = NO;
    BOOL b = NO;
    BOOL r = NO;
	
	// Top
	CGPoint p = CGPointMake(tileCoord.x, tileCoord.y - 1);
    
	if ([self isValidTileCoord:p] && [self isWalkableTile:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
        t = YES;
	}
	
	// Left
	p = CGPointMake(tileCoord.x - 1, tileCoord.y);
	if ([self isValidTileCoord:p] && [self isWalkableTile:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
        l = YES;
	}
	
	// Bottom
	p = CGPointMake(tileCoord.x, tileCoord.y + 1);
	if ([self isValidTileCoord:p] && [self isWalkableTile:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
        b = YES;
	}
	
	// Right
	p = CGPointMake(tileCoord.x + 1, tileCoord.y);
	if ([self isValidTileCoord:p] && [self isWalkableTile:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
        r = YES;
	}
    
    
//	// Top Left
//	p = CGPointMake(tileCoord.x - 1, tileCoord.y - 1);
//	if (t && l && [self isValidTileCoord:p] && [self isWalkableTile:p]) {
//		[tmp addObject:[NSValue valueWithCGPoint:p]];
//	}
//	
//	// Bottom Left
//	p = CGPointMake(tileCoord.x - 1, tileCoord.y + 1);
//	if (b && l && [self isValidTileCoord:p] && [self isWalkableTile:p]) {
//		[tmp addObject:[NSValue valueWithCGPoint:p]];
//	}
//	
//	// Top Right
//	p = CGPointMake(tileCoord.x + 1, tileCoord.y - 1);
//	if (t && r && [self isValidTileCoord:p] && [self isWalkableTile:p]) {
//		[tmp addObject:[NSValue valueWithCGPoint:p]];
//	}
//
//	// Bottom Right
//	p = CGPointMake(tileCoord.x + 1, tileCoord.y + 1);
//	if (b && r && [self isValidTileCoord:p] && [self isWalkableTile:p]) {
//		[tmp addObject:[NSValue valueWithCGPoint:p]];
//	}
    
    
	return [NSArray arrayWithArray:tmp];
}


-(void)AsyncCalcPath
{
    calculatingPath = YES;
    pathCalculated = NO;
    
    
  
        // Add code here to do background processing
       
    AStarOperation *op = [[AStarOperation alloc] initWithTarget:self selector:@selector(CalculatePath) object:nil];

    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] sharedOperationQueue] addOperation:op];
    [op release];
}
// Go backward from a step (the final one) to reconstruct the shortest computed path
- (void)constructPath:(ShortestPathStep *)step
{
//	shortestPath = [[NSMutableArray alloc] init];
	
	do {
		if (step.parent != nil) { // Don't add the last step which is the start position (remember we go backward, so the last one is the origin position ;-)
			[shortestPath insertObject:[NSString stringWithFormat:@"%@",NSStringFromCGPoint(step.position)] atIndex:0]; // Always insert at index 0 to reverse the path
		}
		step = step.parent; // Go backward
	} while (step != nil); // Until there is not more parent
	
	// Call the popStepAndAnimate to initiate the animations
	pathCalculated = YES;
    calculatingPath = NO;
      
    NSLog(@"Our path = %@",shortestPath);
}
-(void)RecalculatePath:(int)StepIndex
{
    fromTileCoor = CGPointFromString([shortestPath objectAtIndex:StepIndex]);
   
    [self AsyncCalcPath];
}

@end
@implementation ShortestPathStep

@synthesize position;
@synthesize gScore;
@synthesize hScore;
@synthesize parent;


- (id)initWithPosition:(CGPoint)pos
{
	if ((self = [super init])) {
		position = pos;
		gScore = 0;
		hScore = 0;
		parent = nil;
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@  pos=[%.0f;%.0f]  g=%d  h=%d  f=%d", [super description], self.position.x, self.position.y, self.gScore, self.hScore, [self fScore]];
}

- (BOOL)isEqual:(ShortestPathStep *)other
{
	return CGPointEqualToPoint(self.position, other.position);
}

- (int)fScore
{
	return self.gScore + self.hScore;
}

@end




@implementation AStarOperation



-(BOOL)isConcurrent
{
    return YES;
}

@end