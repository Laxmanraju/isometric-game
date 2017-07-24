//
//  MCCustomSpriteObject.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 20/12/12.
//
//

#import "CCSprite.h"
#import "cocos2d.h"

@class MCObject;

@interface MCCustomSpriteObject : CCSprite
{
    MCObject *parentObject;
   // BOOL isRotated;
}
@property (nonatomic, assign) MCObject *parentObject;
//@property (nonatomic, assign)BOOL isRotated;

@end
