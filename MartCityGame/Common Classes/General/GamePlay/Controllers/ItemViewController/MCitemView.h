//
//  MCitemView.h
//  MartCityGame
//
//  Created by Laxman Raju on 08/01/13.
//
//

#import <UIKit/UIKit.h>
#include "MCItemImageView.h"

//@protocol MCitemViewDelegate;  // this is scroll view delegate now not using

@interface MCitemView : UIImageView
{
   
    //    id<MCitemViewDelegate> delegate; // this is scroll view delegate now not using

    
}
//@property (nonatomic, retain)  id<MCitemViewDelegate> delegate; // this is scroll view delegate now not using


- (id)initWithFrame:(CGRect)frame itemInfo:(NSDictionary *)itemDict andTag:(int)imageTag;
- (void)displayCost:(NSDictionary *)itemDict;


@end





// this is scroll view delegate now not using
//#pragma mark -
//#pragma  - Delegate methods
//#pragma mark -
//
//@protocol MCitemViewDelegate <NSObject>
//
//@optional
//
//- (void)itemTouchBeganWithTouches: (MCitemView *)details;
//
//- (void)itemTouchMovedWithTouches: (MCitemView *)details;
//
//- (void)itemTouchEndedWithTouches: (MCitemView *)details;
//
//@end

