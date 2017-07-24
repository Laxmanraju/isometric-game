//
//  CharacterSprite.h
//  MartCityGame
//
//  Created by Laxman Raju on 04/02/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Character;
@interface CharacterSprite : CCSprite<CCTargetedTouchDelegate>
{
    Character *parentObject;
    NSMutableArray *pathArrayFro;
    
}
@property (nonatomic, assign)Character *parentObject;
@property (nonatomic, retain)NSMutableArray *pathArrayFro;

-(void)addAnimationEffect;

@end
