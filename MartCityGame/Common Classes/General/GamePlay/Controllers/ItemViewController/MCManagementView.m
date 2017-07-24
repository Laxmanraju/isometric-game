//
//  MCManagementView.m
//  MartCityGame
//
//  Created by Laxman Raju on 18/01/13.
//
//

#import "MCManagementView.h"
#import "MCStoryBoardViewController.h"
@implementation MCManagementView
@synthesize isViewOpen;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    self.userInteractionEnabled = YES;
   
    [self closeViewWithAnimation:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



#pragma  mark-
#pragma mark Animations

-(void)openViewWithAnimation:(BOOL)animated
{
    isViewOpen = YES;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
    }
    else
    {
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y-self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    }
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    [self disableAllButtons];
    
}


-(void)closeViewWithAnimation:(BOOL)animated
{
    
    isViewOpen = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
       
    }
    else
    {
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    }
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    [self disableAllButtons];
    
}

#pragma mark -
#pragma button actions
- (void)viewOpenAndCloseAnimation
{
    if (!isViewOpen)
    {
        [self openViewWithAnimation:YES];
    }
    else
    {
        [self closeViewWithAnimation:YES];
    }
}
- (void)disableAllButtons
{
    [priceButton setSelected:NO];
    [restockButton setSelected:NO];
    [placeButton setSelected:NO];
    [rotateButton setSelected:NO];
}
- (IBAction)priceButtonAction:(id)sender
{
    [self disableAllButtons];
    [sender setSelected:YES];
    [[MCStoryBoardViewController _sharedObject].pricingView openView];
    [[MCStoryBoardViewController _sharedObject].pricingView getCostPriceOfObject];
//    [self removeFromSuperview];
    
}
- (IBAction)restockButtonAction:(id)sender
{
    [self disableAllButtons];
   [sender setSelected:YES];
//    [self removeFromSuperview];
}

- (IBAction)rotateAction:(id)sender
{
    [self disableAllButtons];
    [sender setSelected:YES];
    [[GameLogicLayer sharedObject] rotateCurrentObject];
//    [self viewOpenAndCloseAnimation];
//    [self removeFromSuperview];
}
- (IBAction)placeButtonAction:(id)sender
{
    [self disableAllButtons];
    [sender setSelected:YES];
    [[GameLogicLayer sharedObject] confirmObjectPosition];
//    [self viewOpenAndCloseAnimation];
//    [self removeFromSuperview];
}

@end
