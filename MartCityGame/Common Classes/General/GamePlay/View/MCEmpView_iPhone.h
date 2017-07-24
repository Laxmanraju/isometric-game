//
//  MCEmpView_iPhone.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 25/02/13.
//
//

#import <UIKit/UIKit.h>
#import "CustomProgressView.h"

@interface MCEmpView_iPhone : UIView


- (id)initWithFrame:(CGRect)frame anItemInfo:(NSDictionary *)anItemInfo andTag:(int)hireButtonTag;
- (void)addItemInfoContent:(NSDictionary *)anItemInfo andTag:(int)hireButtonTag;
@end
