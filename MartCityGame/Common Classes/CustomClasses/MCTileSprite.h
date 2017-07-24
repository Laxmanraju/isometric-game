//
//  MCTileSprite.h
//  MartCityGame
//
//  Created by Laxman Raju on 13/12/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MCTileSprite : CCSprite
{
    CGPoint _tileTag, _indexTag;
    BOOL isOccupied;
}

@property(nonatomic,readwrite,assign)CGPoint indexTag,tileTag;
@property(nonatomic, readwrite, assign)BOOL isOccupied;
@end
