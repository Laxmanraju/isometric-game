//
//  Constant_iPhone.h
//  MartCityGame
//
//  Created by Laxman Raju on 10/12/12.
//
//

#ifndef MartCityGame_Constant_iPhone_h
#define MartCityGame_Constant_iPhone_h

/** 
 Constants for gameLogicLayer
 **/
#define _INITIAL_ROWS 11
#define _INITIAL_COLUMNS 11
#define _TILE_WIDTH 250.0f
#define _TILE_HEIGHT 129.0f

#define _MAX_ALLOWED_ROWS 10
#define _MAX_ALLOWED_COLUMNS 10 
#define Y_MARGIN 500

/*** HARD CODED PROPERTIES THAT HAVE TO BECOME OBJECT PROPERTIES FOR GRID CALCULATION*/
#define  _AISLE_COLUMNS  1
#define _AISLE_ROWS       3
#define _AISLE_OFFSET_X  131.5f
#define _AISLE_OFFSET_Y  54.0f

//
//save this
//#define _AISLE_OFFSET_X  10.0f
//#define _AISLE_OFFSET_Y  0.0f

#define _MAX_LAYER_WIDTH
/**********/ 

#define _SMALL_GRID_ROWS 5
#define _SMALL_GRID_COLUMNS 5
#define MAXIMUM_ALLOWED_SMALLGRIDS 50;
 

#define  CHARACTER_DIRECTIONS_EIGHT 8
#define  CHARACTER_DIRECTIONS_FOUR  4

#define IMAGES_PATH [NSString stringWithFormat:@"%@/Library/Caches/Images", NSHomeDirectory()]

typedef enum
{
    RIGHT =1,
    UP_RIGHT=2,
    UP=3,
    UP_LEFT=4,
    LEFT=5,
    DOWN_LEFT=6,
    DOWN=7,
    DOWN_RIGHT=8,
}Direction;

typedef enum
{
    RANDOM_WALKING =1,
    DESTINATION_WALKING,
    
}CharacterActions;

typedef enum
{
    STANDING = 0,
    WALKING,
    
}CharacterAnimation;

typedef enum
{
	frontNormal = 1,
	backNormal,
    UpNormal,
    DownNormal,
    Side,
}flipImages;


#endif
