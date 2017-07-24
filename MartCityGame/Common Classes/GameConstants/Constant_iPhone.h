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
#define _INITIAL_ROWS 10
#define _INITIAL_COLUMNS 10
#define _TILE_WIDTH 128.0f
#define _TILE_HEIGHT 64.0f

#define _MAX_ALLOWED_ROWS 10
#define _MAX_ALLOWED_COLUMNS 10 

#define A_MAX_ALLOWED_ROWS 60
#define A_MAX_ALLOWED_COLUMNS 60
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


#define WALK_FRAME_COUNT 8
#define WALK_IDLE_FRAME_COUNT 5
#define IDLE_WALK_FRAME_COUNT 4
#define LOOK_FRAME_COUNT 12
#define IDLE1_FRAME_COUNT 23
#define IDLE2_FRAME_COUNT 14
#define BROWSE1_FRAME_COUNT 20
#define BROWSE2_FRAME_COUNT 25
#define CLEANING_FRAME_COUNT 9
#define MANAGER_LOOK_COUNT 15    /// to be removed

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
    WALKING_ACTION =1,
    WALK_IDLE_ACTION, //2
    IDLE_WALK_ACTION, //3
    LOOK_ACTION,      //4
    IDLE1_ACTION,     //5
    IDLE2_ACTION,     //6
    BROWSE1_ACTION,   //7
    BROWSE2_ACTION,   //8
    CLEAN_ACTION,     //9
}CharacterActions;

typedef enum                ///// curraction == curranimation///////
{
    WALKING_ANI =1,
    WALK_IDLE_ANI, //2
    IDLE_WALK_ANI, //3
    LOOK_ANI,      //4
    IDLE1_ANI,     //5
    IDLE2_ANI,     //6
    BROWSE1_ANI,   //7
    BROWSE2_ANI,   //8
    CLEAN_ANI,     //9
    
//    WALKING_ANI=1,
//    LOOKING_ANI = 2,
//    BROWSING_ANI = 3,
//    DESTINATION_WALKING_ANI,
//    SHOPPING_ANI,
//    CLEANING_ANI,
//    CHECK_AISLE_ANI
    
}CharacterAnimation;

typedef enum
{
//    DownNormal=1,
//    UpNormal,
//	frontNormal,
//	backNormal,
//    Side,
    frontNormal = 1,
    DownNormal,
    Side,
    UpNormal,
    backNormal,
    
}flipImages;



#endif
