//
//  MCEmpView.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 19/02/13.
//
//

#import <UIKit/UIKit.h>
#import "CustomProgressView.h"

@interface MCEmpView : UIView
{
    
   
}
- (id)initWithFrame:(CGRect)frame anItemInfo:(NSDictionary *)anItemInfo andTag:(int)hireButtonTag;
- (void)addItemInfoContent:(NSDictionary *)anItemInfo andTag:(int)hireButtonTag;

@end



