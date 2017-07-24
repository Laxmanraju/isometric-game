//
//  GameConstants.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 08/01/13.
//
//

#import <Foundation/Foundation.h>

@protocol GameConstants <NSObject>
//Game Logic Layer
#define     ENTITYGROUPS                        @"entityGroups"
#define     ENTITIES                            @"entities"
#define     EMP_MANGEMENT                       @"empMangement"

#define     COLLECTION_CODE                     @"code"

#define     FOOD_CATEGORY                       @"oc1"
#define     FURNISHING_CATEGORY                 @"oc2"
#define     APPAREL_CATEGORY                    @"oc3"
#define     ACCESSORIES_CATEGORY                @"oc4"


#define     ITEMCOST                            @"cost"
#define     CATEGORYID                          @"catrgoryId"
#define     LOWESTPOINT                         @"LowestPoint"


#define     GAMEINFOPLIST                       [NSString stringWithFormat:@"GameInfo.plist"] 
@end
