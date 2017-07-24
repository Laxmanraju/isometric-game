//
//  CharacterController.m
//  MartCityGame
//
//  Created by Laxman Raju on 05/02/13.
//
//

#import "CharacterController.h"
#import "MCGameEngineController.h"
#import "Character.h"

@implementation CharacterController
@synthesize gameLayer,allAvatars;

static CharacterController *_sharedObject = nil;

-(void)UpdateCharacterPaths
{
    for (Character *avatar in allAvatars) {
        //Recalc
        [avatar RecalculatePath];
    }
}

+ (CharacterController *)getInstance
{
    if (!_sharedObject) {
        _sharedObject = [[CharacterController alloc] init];
    }
    return _sharedObject;
    
}

- (id)init
{
    self = [super init];
    if (self)
    {
        openAisleDestinations = [[NSMutableArray alloc] init];
        closedDestinations = [[NSMutableArray alloc] init];
        openCheckOutLanes = [[NSMutableArray alloc] init];
        allAvatars = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)FinishedAction:(Character *)Agent
{
//    Agent.currAction = CLEAN_ACTION;
    
    
    if(Agent.characterTypeName == zEmployee){
        switch (Agent.empType) {
            case zRegular:
            {
                //if currAction is walking
                switch (Agent.currAction) {
                    case WALKING_ACTION:
                    {
                           
                    }
                    break;
                     
                    case LOOK_ACTION:
                    {
                        Agent.currAction = IDLE1_ACTION;
                    }
                        break;
                    case  IDLE1_ACTION:
                    {
                        Agent.currAction = IDLE2_ACTION;
                    }
                        break;
                    case IDLE2_ACTION:
                    {
                        Agent.currAction = LOOK_ACTION;
                    }
                        break;
                    default:
                        [self GoToAisle:Agent];
                        break;
                }
                    
                
                // if 
            }
                break;
            case zCashier:
            {
                
            }
                break;
            case zCleaner:
            {
                
                
                switch (Agent.currAction) {
                    case WALKING_ACTION:
                    {
                        Agent.currAction = CLEAN_ACTION;
                        [self GoToAisle:Agent];
                    }
                        break;
                
                    case CLEAN_ACTION:
                    {
                       
                        [self GoToAisle:Agent];
                        
                    }
                        break;

                    default:
                        [self GoToAisle:Agent];
                        break;
                }
                /*if currAction is Walking */
                
                //Change to either clean and walk
            
                
            }
                break;
            case zSecurity:
            {
                
            }
                break;
            case zManager:
            {
               Agent.currAction = LOOK_ACTION; // Walk to another destination
            }
                break;
                
            default:
                [self GoToAisle:Agent];
                break;
        }
    }
    else if(Agent.characterTypeName == zCustomer){
        
        switch (Agent.currAction) {
            case WALKING_ACTION:
                Agent.currAction =BROWSE1_ACTION;// WALK_IDLE_ACTION;
                break;
             case WALK_IDLE_ACTION:
                Agent.currAction = BROWSE1_ACTION;
                break;
             case BROWSE1_ACTION:
                Agent.currAction = IDLE1_ACTION;
                break;
             case IDLE1_ACTION:
                Agent.currAction = BROWSE2_ACTION;
                break;
            case BROWSE2_ACTION:
                Agent.currAction = WALKING_ACTION;
            default:
                break;
        }
        
        /*switch (Agent.custType) {
            case zKidFemale:
            {
                
            }
                break;
            case zKidMale:
            {
                
            }
                break;
            case zPunk:
            {
                
            }
                break;
            case zOldLady:
            {
                
            }
                break;
            case zTeenFemale:
            {
                
            }
                break;
            case zTeenMale:
            {
                
            }
                break;
           
            
         
            default:
                [self GoToAisle:Agent];
                break;
        }*/ 
    }
    

}

-(void)populateAisleDestinationsWith:(CGPoint)gridPoint andRotation:(BOOL)isRotated
{
    
    if (!isRotated) {
        //Check left side
        if ([[MCGameEngineController sharedObject] checkForObjectIntersection:gridPoint.x andColoumn:gridPoint.y-1 andObjectSize:ccp(1, 1)]) {
            [openAisleDestinations addObject:[NSString stringWithFormat:@"%@",NSStringFromCGPoint(CGPointMake(gridPoint.x, gridPoint.y-1))]];
        }
        
        if ([[MCGameEngineController sharedObject] checkForObjectIntersection:gridPoint.x-1 andColoumn:gridPoint.y-1 andObjectSize:ccp(1, 1)]) {
            [openAisleDestinations addObject:[NSString stringWithFormat:@"%@",NSStringFromCGPoint(CGPointMake(gridPoint.x-1, gridPoint.y-1))]];
        }
        if ([[MCGameEngineController sharedObject] checkForObjectIntersection:gridPoint.x-2 andColoumn:gridPoint.y-1 andObjectSize:ccp(1, 1)]) {
            [openAisleDestinations addObject:[NSString stringWithFormat:@"%@",NSStringFromCGPoint(CGPointMake(gridPoint.x-2, gridPoint.y-1))]];
        }
        // check for side
        if ([[MCGameEngineController sharedObject] checkForObjectIntersection:gridPoint.x andColoumn:gridPoint.y+1 andObjectSize:ccp(1, 1)]) {
            [openAisleDestinations addObject:[NSString stringWithFormat:@"%@",NSStringFromCGPoint(CGPointMake(gridPoint.x, gridPoint.y+1))]];
        }
        if ([[MCGameEngineController sharedObject] checkForObjectIntersection:gridPoint.x-1 andColoumn:gridPoint.y+1 andObjectSize:ccp(1, 1)]) {
            [openAisleDestinations addObject:[NSString stringWithFormat:@"%@",NSStringFromCGPoint(CGPointMake(gridPoint.x-1, gridPoint.y+1))]];
        }
        if ([[MCGameEngineController sharedObject] checkForObjectIntersection:gridPoint.x-2 andColoumn:gridPoint.y+1 andObjectSize:ccp(1, 1)]) {
            [openAisleDestinations addObject:[NSString stringWithFormat:@"%@",NSStringFromCGPoint(CGPointMake(gridPoint.x-2, gridPoint.y+1))]];
        }
    }
    else
    {
        
    }
  
}

-(int)GenerateRandomAction
{
    int action = (arc4random() % 9)+1;
    
    return action;
}

-(void)GoToAisle:(Character *)Agent
{

    Agent.aStar.fromTileCoor = Agent.aStar.toTileCoord;
    unsigned int i = arc4random() % ([openAisleDestinations count]-1);
    Agent.aStar.toTileCoord = CGPointFromString([openAisleDestinations objectAtIndex:i]);
    
    [Agent.aStar CalculatePath];
    Agent.currAction = WALKING_ACTION;
    
}
@end
