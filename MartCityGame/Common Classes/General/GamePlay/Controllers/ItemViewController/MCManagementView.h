//
//  MCManagementView.h
//  MartCityGame
//
//  Created by Laxman Raju on 18/01/13.
//
//

#import <UIKit/UIKit.h>

@interface MCManagementView : UIView<UIScrollViewDelegate>
{
    
    
    IBOutlet UIButton*             priceButton;
    IBOutlet UIButton*             restockButton;
    IBOutlet UIButton*             rotateButton;
    IBOutlet UIButton*             placeButton;
    BOOL                           isViewOpen;
}

@property(nonatomic, assign)BOOL     isViewOpen;

- (IBAction)priceButtonAction:(id)sender;
- (IBAction)restockButtonAction:(id)sender;
- (IBAction)rotateAction:(id)sender;
- (IBAction)placeButtonAction:(id)sender;


- (void)openViewWithAnimation:(BOOL)animated;
- (void)closeViewWithAnimation:(BOOL)animated;
- (void)viewOpenAndCloseAnimation;
- (void)disableAllButtons;

@end
