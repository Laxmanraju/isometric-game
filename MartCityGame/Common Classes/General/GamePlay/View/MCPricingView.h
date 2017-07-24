//
//  MCPricingView.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 23/01/13.
//
//

#import <UIKit/UIKit.h>
#import "MCObject.h"

@interface MCPricingView : UIView
{
    
    IBOutlet UILabel        *priceValue;
    IBOutlet UIButton       *up_Button;
    IBOutlet UIButton       *down_Button;
    IBOutlet UIButton       *doneButton;
    BOOL isViewOpen;
    
    int tempCost, currentCost;
}

@property(nonatomic, assign)BOOL isViewOpen;
@property int currentCost;


- (void)openView;
- (void)updatePricingView;
- (void)getCostPriceOfObject;
- (void)closeViewWithAnimation:(BOOL)animated;
- (IBAction)doneButtonAction:(id)sender;

- (IBAction)up_ButtonClicked:(id)sender;
- (IBAction)down_ButtonClicked:(id)sender;

@end
