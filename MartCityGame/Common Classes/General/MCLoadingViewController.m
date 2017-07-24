//
//  MCLoadingViewController.m
//  MCLoadingView
//
//  Created by Laxman Raju on 07/12/12.
//
//

#import "MCLoadingViewController.h"

@interface MCLoadingViewController ()

@end

@implementation MCLoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    percent = 5;
    oldPercent = 5;

    if(UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPhone)
	{
        [backGroundView setFrame:CGRectMake(0, 0, 480, 320)];
        [backGroundView setImage:[UIImage imageNamed:@"Title_Screen.png"]];
         LOADING_BAR_WIDTH = 132;
    }
    else
    {
        [backGroundView setFrame:CGRectMake(0, 0, 1024, 768)];
        [backGroundView setImage:[UIImage imageNamed:@"Title_Screen.png"]];
         LOADING_BAR_WIDTH = 268;
    }
   
    float widthToBeSet = (percent * LOADING_BAR_WIDTH * 1.0) / 100;
    CGRect frm = loadingIndicator.frame;
    
    [loadingIndicator setFrame:CGRectMake(frm.origin.x, frm.origin.y, widthToBeSet, frm.size.height)];

    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [super dealloc];
}


/**
 *  loading percentage
 */
- (void)setLoadingPercentage:(int)percentage
{
	percent = percentage;
	[self setLoadingIndicatorFrame];
    
}

/**
 *  loading the complete bar
 */
- (void)setLoadingIndicatorFrame
{
	CGRect frm = loadingIndicator.frame;
    float widthToBeSet = (percent * LOADING_BAR_WIDTH * 1.0) / 100;
    [loadingIndicator setFrame:CGRectMake(frm.origin.x, frm.origin.y, widthToBeSet, frm.size.height)];
}

#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	////NSLog(@"%s",__FUNCTION__);
}




@end
