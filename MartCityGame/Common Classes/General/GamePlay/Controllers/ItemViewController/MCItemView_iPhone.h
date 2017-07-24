//
//  MCItemView_iPhone.h
//  MartCityGame
//
//  Created by Laxman Raju on 08/01/13.
//
//

#import <UIKit/UIKit.h>
#import "MCItemImageView.h"
@protocol MCItemView_iPhoneDelegate;

@interface MCItemView_iPhone : UIView
{
    id<MCItemView_iPhoneDelegate> delegate;
    
    MCItemImageView *itemImageView;
    UIView *costView;
}

@property (nonatomic, retain) id<MCItemView_iPhoneDelegate> delegate;

- (id)initWithFrame:(CGRect)frame itemInfo:(NSDictionary *)itemDict;
- (void)displayCost:(NSDictionary *)itemDict;
@end

#pragma mark - 
#pragma  - Delegate methods
#pragma mark - 

@protocol MCItemView_iPhoneDelegate <NSObject>

@optional

- (void)itemTouchBeganWithTouches: (MCItemView_iPhone *)details;

- (void)itemTouchMovedWithTouches: (MCItemView_iPhone *)details;

- (void)itemTouchEndedWithTouches: (MCItemView_iPhone *)details;

@end


