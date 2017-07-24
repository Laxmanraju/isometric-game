//
//  CharacterController.h
//  MartCityGame
//
//  Created by Laxman Raju on 05/02/13.
//
//

#import <Foundation/Foundation.h>
#import "Character.h"

@class GameLogicLayer;
@interface CharacterController : NSObject
{
    GameLogicLayer *gameLayer;
    CharacterController *_sharedObject;
    NSMutableArray *allAvatars;
    NSMutableArray *openAisleDestinations;
    NSMutableArray *closedDestinations;
    NSMutableArray *openCheckOutLanes;
    
}

@property(nonatomic, assign)GameLogicLayer *gameLayer;
@property(nonatomic, retain) NSMutableArray *allAvatars;

+ (CharacterController *)getInstance;
-(void)UpdateCharacterPaths;
-(void)FinishedAction:(Character *)Agent;
-(void)populateAisleDestinationsWith:(CGPoint)gridPoint andRotation:(BOOL)isRotated;
@end
