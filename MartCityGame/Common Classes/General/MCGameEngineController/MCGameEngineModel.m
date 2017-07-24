//
//  MCGameEngineModel.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 13/12/12.
//
//

#import "MCGameEngineModel.h"

@implementation MCGameEngineModel

@synthesize maxZoom;
@synthesize minZoom;
@synthesize startZoom;
@synthesize gameScale;

@synthesize tileWidth,tileHeight, unitTileWidth,unitTileHeight,yMargin;

/**
 *  initialization
 */

- (id)init
{
    self = [super init];
    if (self) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            // ipad
            if (CC_CONTENT_SCALE_FACTOR() == 2) {
                minZoom			= 0.1f;
                maxZoom			= 2.8f;
                startZoom		= 2.0f;
            }
            else
            {
                minZoom			= 0.5f;
                maxZoom			= 1.5f;
                startZoom		= 1.0f;
                
            }
            
        }else if (UI_USER_INTERFACE_IDIOM() == 2) {
            //iphone Retina display
            minZoom			= 0.2f;
            maxZoom			= 1.5f;
            startZoom		= 1.0f;
        }else{
            // iPhone
            [self updateGameSettingsWithImagesScaleFactor:1.0 andGameScaleFactor:1.0];
            minZoom			= 0.3f;
            maxZoom			= 2.0f;
            startZoom		= 0.3;
        }
        
    }
    return self;
}

- (void)updateGameSettingsWithImagesScaleFactor:(float)anImagesScale andGameScaleFactor:(float)gameCalcScale
{
    tileWidth       = TILE_WIDTH_SCALE*gameCalcScale;
    tileHeight      = TILE_HEIGHT_SCALE*gameCalcScale;
    unitTileWidth	= UNIT_TILE_WIDTH*gameCalcScale;
	unitTileHeight	= UNIT_TILE_HEIGHT*gameCalcScale;
    yMargin			= 2*tileHeight;
}
@end
