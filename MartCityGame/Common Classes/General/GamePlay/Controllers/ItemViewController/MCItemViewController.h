//
//  MCItemViewController.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 26/12/12.
//
//

#import <UIKit/UIKit.h>
#import "MCItemView_iPhone.h"
#import "MCitemView.h"
#import "GameLogicLayer.h"
#import "MCGameEngineController.h"


@interface MCItemViewController : UIViewController //<MCItemView_iPhoneDelegate, MCitemViewDelegate> // this is scroll view delegate now not using
{
    IBOutlet UIView   *buyMenuView;
    IBOutlet UIScrollView *categoryScrollView;
    IBOutlet UIButton *apparel,*hygiene,*hardware, *electronics, *food, *button6, *button7, *button8, *button9, *button10;
    IBOutlet UIImageView *itemsImageView;
    IBOutlet UIScrollView *itemsScrollView;
    IBOutlet UIScrollView *itemsImagesScrollView;
    IBOutlet UILabel *itemLabel;
    
    UIButton *previousSelectedBtn;
    
    float ITEM_WIDTH,ITEM_HEIGHT;
    BOOL isViewOpen;
    
    NSArray *itemsArray;
    NSArray *imageArray;
}

//@property (nonatomic, assign)  IBOutlet UIScrollView	*categoriesScrollView;
//@property (nonatomic, assign) IBOutlet UIScrollView     *itemsContentView;
@property BOOL isViewOpen;

- (IBAction)categorySelectedAction:(id)sender;

- (void)reloadItemsContentViewCategory:(int)categoryIndex;
- (void)cleanItemsContentView;
//- (NSMutableArray *)getItemsForCategoryIndex:(NSString *)categoryIndex;
- (void)purchaseButtonAction:(id)sender;;

@end
