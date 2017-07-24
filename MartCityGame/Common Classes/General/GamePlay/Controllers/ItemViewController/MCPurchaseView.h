//
//  MCPurchaseView.h
//  MartCityGame
//
//  Created by Laxman Raju on 18/01/13.
//
//

#import <UIKit/UIKit.h>
#import "MCItemViewController.h"
#import "MCPurchaseView.h"
#import "MCPricingView.h"
@interface MCPurchaseView : UIView<UIScrollViewDelegate>
{
    IBOutlet UIScrollView*          sScrollView;
    IBOutlet UIButton*              searchButton;
    IBOutlet UIButton*              buyButton;
    IBOutlet UIButton*              setPriceButton;
    IBOutlet UIButton*              ejectButton;
    
    BOOL                            isViewOpen;
    
    MCItemViewController*      categoriesController;
   
    
    
}
@property (nonatomic, assign) BOOL   isViewOpen;
@property (nonatomic, assign) MCItemViewController*      categoriesController;

-(IBAction)ejectAction:(id)sender;
-(IBAction)buyButtonAction:(id)sender;
-(IBAction)setPriceButtonAction:(id)sender;
-(IBAction)searchButtonAction:(id)sender;

- (void)openViewWithAnimation:(BOOL)animated;
- (void)closeViewWithAnimation:(BOOL)animated;
- (void)initialSetUp;
- (void)viewOpenAndCloseAnimation;

@end
