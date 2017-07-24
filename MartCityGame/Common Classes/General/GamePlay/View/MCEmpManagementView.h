//
//  MCEmpManagementView.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 16/02/13.
//
//

#import <UIKit/UIKit.h>
#import "GameSession.h"
#import "MCEmpView.h"
#import "CustomProgressView.h"
#import "GameLogicLayer.h"   ///// to be removed lx
#import "Character.h"        ///



@interface MCEmpManagementView : UIView
{
    IBOutlet UIImageView    *empButtonsImageView;
    IBOutlet UIScrollView   *empMngmtScrollView;
    IBOutlet UIButton       *asstMangerButton;
    IBOutlet UIButton       *franchiseButton;
    IBOutlet UIButton       *socialButton;
    IBOutlet UIButton       *statsButton;
    
    IBOutlet UIImageView    *empInfoBgImageView;
    IBOutlet UIImageView    *empInfoButtonsImageView;
    IBOutlet UIButton       *empInfoButton1;
    IBOutlet UIButton       *empInfoButton2;
    IBOutlet UIButton       *empInfoButton3;
    
    IBOutlet UIView         *assistanceView;
    IBOutlet UIButton       *acceptButton;
    IBOutlet UIView         *confirmAlertView;
    
    
    
    
    GameLogicLayer *gameLayer;   /////lx to be removed when standardised
    
    NSMutableArray *aItems;
    
    NSString *characterName;
   
    int selectedTag;
    BOOL isViewOpen;
}

@property (nonatomic, assign)BOOL isViewOpen;



- (IBAction)empManagementButtonAction:(id)sender;
- (IBAction)acceptButtonAction:(id)sender;
- (IBAction)confirmButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;

- (void)showEmpManagementView;
- (void)hideEmpManagementView;


- (NSArray *)getTheSelectedEmpInfo:(int)tag;
- (void)addSelectedImage:(UIButton*)button;
- (void)empInfoImplementation:(int)senderTag;
- (void)cleanItemsContentView;
- (void)updatingButtonImages:(int)senderTag;


@end


