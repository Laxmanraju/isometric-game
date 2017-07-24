//
//  MCImageCache.h
//  MartCityGame
//
//  Created by Laxman Raju on 05/02/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MCImageCache : NSObject{
    NSMutableDictionary          *characterImageStorage, *localImageCache;
    NSString                *bundleString;
    NSMutableDictionary     *gridObjectsCache;
}

+ (MCImageCache *)sharedMCImageCache;

- (void)removeImageSet:(NSString*)characterName action:(int)actionType direction:(int)direction;
- (NSMutableArray*)getCharacterImageSetWithName:(NSString*)charName actionType:(int)actionType actionSubType:(int)subType totImgCnt:(int)totImgCnt;
- (void)storeAnimationImgsWithName:(NSString*)imgName subType:(int)subType inDict:(NSMutableDictionary*)aDict maxImgCnt:(int)totImgCnt;

@end
