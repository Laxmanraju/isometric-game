//
//  MCTileSprite.m
//  MartCityGame
//
//  Created by Laxman Raju on 13/12/12.
//
//

#import "MCTileSprite.h"

@implementation MCTileSprite
@synthesize tileTag = _tileTag;
@synthesize indexTag = _indexTag;
@synthesize isOccupied;

- (id)init
{
    self = [super init];
    if (self!= nil) {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
