//
//  MCGameEngineConstants.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 10/12/12.
//
//

#import <Foundation/Foundation.h>

//@protocol MCGameEngineConstants <NSObject>
//
//@end

#define			SCREEN_WIDTH		[[UIScreen mainScreen] bounds].size.height  //768.0f
#define			SCREEN_HEIGHT	[[UIScreen mainScreen] bounds].size.width //1024.0f


#define			MAX_ZOOM			1.5f
#define			MIN_ZOOM			0.2f


#define			UNIT_TILE_WIDTH			50//90 //TILE_WIDTH/SMALL_GRID_ROWS
#define			UNIT_TILE_HEIGHT		26//48 //TILE_HEIGHT/SMALL_GRID_ROWS

#define			TILE_WIDTH_SCALE				UNIT_TILE_WIDTH*4.0//90*4
#define			TILE_HEIGHT_SCALE				UNIT_TILE_HEIGHT*4.0//48*4
#define			GRID_KEY			@"Grid";

#define			OWNER_FOLDER_PATH	[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Owner"]
#define			TILE_INFO			@"TileInfo.plist"
#define         SESSION_INFO        @"SessionInfo.plist"
typedef enum
{
	kNormalMode		=	1,
	kEditMode		=	2,
	kCreateMode,
}GameMode;
