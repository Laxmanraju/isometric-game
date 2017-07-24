//
//  MCPurchaseView.m
//  MartCityGame
//
//  Created by Laxman Raju on 18/01/13.
//
//

#import "MCPurchaseView.h"
#import "MCStoryBoardViewController.h"
@implementation MCPurchaseView
@synthesize categoriesController;
@synthesize isViewOpen;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialSetUp];
    }
    return self;
}
- (void)dealloc
{
    if (categoriesController!= nil) {
        [categoriesController release];
        categoriesController = nil;
    }
    

    [super dealloc];
}
- (void)awakeFromNib
{
    self.userInteractionEnabled = YES;
    sScrollView.delegate = self;
    [self closeViewWithAnimation:NO];
}

- (void)initialSetUp
{
    categoriesController = nil;
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(IBAction)ejectAction:(id)sender
{
    [self viewOpenAndCloseAnimation];
}

- (void)viewOpenAndCloseAnimation
{
    if (!isViewOpen) {
        [self openViewWithAnimation:YES];
    }
    else
    {
        [self closeViewWithAnimation:YES];
    }
}

#pragma mark-
#pragma mark Animations

-(void)openViewWithAnimation:(BOOL)animated
{
    isViewOpen = YES;
    
    CGRect pvFrame = self.frame;
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        pvFrame = CGRectMake(pvFrame.origin.x, pvFrame.origin.y, pvFrame.size.width, pvFrame.size.height);
//        [sScrollView setContentOffset:CGPointMake(-60,0)];
//    }
//    else 
//    {
//        pvFrame =  CGRectMake(pvFrame.origin.x, pvFrame.origin.y, pvFrame.size.width, pvFrame.size.height);
//        [sScrollView setContentOffset:CGPointMake(-108, 0)];
//    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    [self setFrame:pvFrame];
    [UIView setAnimationDidStopSelector:@selector(openAnimationEnded)];

    [sScrollView setContentOffset:CGPointMake(0, 0)];

    [UIView setAnimationDelegate:self ];
    [UIView commitAnimations];

}
- (void)openAnimationEnded
{
    isViewOpen = YES;
}

-(void)closeViewWithAnimation:(BOOL)animated
{
    isViewOpen = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(closeAnimationEnded)];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
//        pvFrame = CGRectMake(pvFrame.origin.x, pvFrame.origin.y, pvFrame.size.width, pvFrame.size.height);
        [sScrollView setContentOffset:CGPointMake(-60,0)];
    }
    else
    {
//        pvFrame =  CGRectMake(pvFrame.origin.x, pvFrame.origin.y, pvFrame.size.width, pvFrame.size.height);
        [sScrollView setContentOffset:CGPointMake(-108, 0)];
    }
//    [sScrollView setContentOffset:CGPointMake(-70, 0)];
    [UIView commitAnimations];
}

- (void)closeAnimationEnded
{
    isViewOpen = NO;
}


-(IBAction)setPriceButtonAction:(id)sender
{
   
    [[MCStoryBoardViewController _sharedObject].pricingView openView];
    
    [self viewOpenAndCloseAnimation];
    
}
-(IBAction)searchButtonAction:(id)sender
{
    
    [self viewOpenAndCloseAnimation];
}  

#pragma mark -
#pragma mark ScrollView delegates
      
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//	////NSLog(@"%s %d",__FUNCTION__, isLeafOpen);
////	if(!isLeafOpen) {
////		CGRect frm = self.frame;
////		[self setFrame:CGRectMake(frm.origin.x , frm.origin.y, frm.size.width, frm.size.height)];
////		[scrollView setContentOffset:CGPointMake(0, 344) animated:NO];
////	}
//}


@end
