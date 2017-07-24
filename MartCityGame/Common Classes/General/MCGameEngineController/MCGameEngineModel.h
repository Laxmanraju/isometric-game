//
//  MCGameEngineModel.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 13/12/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MCGameEngineConstants.h"

@interface MCGameEngineModel : NSObject
{
    float maxZoom;
    float minZoom;
    float startZoom;
    float gameScale;
    float tileWidth, tileHeight;
    float unitTileWidth,unitTileHeight;
    float yMargin;
}

@property (nonatomic, assign)float maxZoom,minZoom,startZoom;
@property (nonatomic, assign)float tileWidth,tileHeight,unitTileWidth,unitTileHeight;
@property (nonatomic, assign)float gameScale,yMargin;

- (void)updateGameSettingsWithImagesScaleFactor:(float)anImagesScale andGameScaleFactor:(float)gameCalcScale;
@end
