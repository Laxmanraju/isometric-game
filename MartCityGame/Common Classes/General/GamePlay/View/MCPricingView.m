//
//  MCPricingView.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 23/01/13.
//
//

#import "MCPricingView.h"
#import "GameLogicLayer.h"

@implementation MCPricingView
@synthesize isViewOpen, currentCost;


static MCPricingView *_sharedObject= nil;

+ (MCPricingView *)_sharedObject
{
	if (!_sharedObject) {
        _sharedObject = [[MCPricingView alloc] init];
	}
	return _sharedObject;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _sharedObject = self;
       
    }
    return self;
}
-(void)awakeFromNib
{
    [self closeViewWithAnimation:YES];
//    priceValue.text = nil;
    
}
-(void)getCostPriceOfObject
{
    tempCost = 0;
    if (!tempCost)
    {
        tempCost = [GameLogicLayer sharedObject].selectedObject.costPrice;
        currentCost = tempCost;
        [self updatePricingView];
    }
}

       

- (void)updatePricingView
{
    NSLog(@"%d",currentCost);
   [priceValue setText:[NSString stringWithFormat:@"%d",currentCost]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)openView
{
    isViewOpen = YES;
    
   
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self setFrame:CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height)];
    }
    else{
        [self setFrame:CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height)];
    }
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}


- (void)openAnimationEnded
{
    isViewOpen = YES;
}


- (void)closeViewWithAnimation:(BOOL)animated
{
    isViewOpen = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(closeAnimationEnded)];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self setFrame:CGRectMake(self.frame.origin.x, -180, self.frame.size.width, self.frame.size.height)];
    }
    else{
        [self setFrame:CGRectMake(self.frame.origin.x, -200, self.frame.size.width, self.frame.size.height)];
    }
    
    [UIView commitAnimations];
}

- (void)closeAnimationEnded
{
    isViewOpen = NO;
}

- (IBAction)doneButtonAction:(id)sender
{
    [self closeViewWithAnimation:YES];
    [[GameLogicLayer sharedObject].selectedObject setSellingPrice:[priceValue.text intValue]];
    [[GameLogicLayer sharedObject].selectedObject updateAisleConsumptionRate];
}

- (IBAction)up_ButtonClicked:(id)sender
{

    NSLog(@"tempCost :%d",tempCost);
    if (currentCost < 2*[GameLogicLayer sharedObject].selectedObject.costPrice-1) {
        currentCost = ++tempCost;
    }
    
    
    [self updatePricingView];
    
}
- (IBAction)down_ButtonClicked:(id)sender
{
    if (currentCost > 1) {
        currentCost = --tempCost;
    }
    [self updatePricingView];
}
@end
