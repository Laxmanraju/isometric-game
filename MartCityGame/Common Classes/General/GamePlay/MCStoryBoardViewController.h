//
//  MCStoryBoardViewController.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 20/12/12.
//
//

#import <UIKit/UIKit.h>
#import "UIDeviceMyDeviceType.h"
#import "GameLogicLayer.h"
#import "MCItemViewController.h"
#import "MCPurchaseView.h"
#import "MCManagementView.h"
#import "MCStatisticsBoard.h"
#import "MCPricingView.h"

#import "MCEmpMgmtViewController.h"

@interface MCStoryBoardViewController : UIViewController
{    
    
    IBOutlet MCManagementView            *managementView;
    IBOutlet MCPurchaseView              *purchaseView;
    IBOutlet MCStatisticsBoard           *statisticsBoard;
    IBOutlet MCPricingView               *pricingView;
    IBOutlet UIButton                    *buyButton;
    IBOutlet UIButton                    *empMngmtButton;
   
    MCItemViewController                 *categoriesController;
    MCEmpMgmtViewController              *empMgmtViewController;

   
    
}


@property (nonatomic, assign) MCItemViewController*      categoriesController;
@property (nonatomic, assign) MCEmpMgmtViewController    *empMgmtViewController;

@property (nonatomic, readonly) IBOutlet MCManagementView        *managementView;
@property (nonatomic, readonly) IBOutlet MCPurchaseView          *purchaseView;
@property (nonatomic, readonly) IBOutlet MCStatisticsBoard       *statisticsBoard;
@property (nonatomic, readonly) IBOutlet MCPricingView           *pricingView;



+ (MCStoryBoardViewController *)_sharedObject;
- (IBAction)Expand:(id)sender;
- (IBAction)empMngmtButtonAction:(id)sender;
- (IBAction)buyButtonAction:(id)sender;

@end
