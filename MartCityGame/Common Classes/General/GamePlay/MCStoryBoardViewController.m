//
//  MCStoryBoardViewController.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 20/12/12.
//
//

#import "MCStoryBoardViewController.h"
#import "GameLogicLayer.h"


@interface MCStoryBoardViewController ()

@end

@implementation MCStoryBoardViewController


@synthesize managementView, purchaseView, statisticsBoard,pricingView;
@synthesize categoriesController;
@synthesize empMgmtViewController;

static MCStoryBoardViewController *_sharedObject= nil;


+(MCStoryBoardViewController *)_sharedObject
{
	if (!_sharedObject) {
        _sharedObject = [[MCStoryBoardViewController alloc] init];
	}
	return _sharedObject;
}

/**
 *  initialization
 **/

- (id)init
{
    self = [super initWithNibName:[UIDevice properNibFileNameForCurrentDevice:@"MCStoryBoardViewController"] bundle:nil];
    if (self) {
        // Custom initialization
		_sharedObject = self;
//        categoriesController = nil;
      
    }
    return self;
}

/**
 * dealloc method
 */

- (void)dealloc
{
    [purchaseView release];
    [managementView release];
    [_sharedObject release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Expand:(id)sender
{
    [[GameLogicLayer sharedObject] ToggleExpandButtons];
}

- (IBAction)empMngmtButtonAction:(id)sender
{
    if (empManagementView.isViewOpen) {
          [empManagementView hideEmpManagementView];
        [[MCGameEngineController sharedObject]enableGestures];
    }else {    
        [empManagementView showEmpManagementView];
        [[MCGameEngineController sharedObject]disableGestures];
    }
    if (empMgmtViewController.isViewOpen)
    {
         empMgmtViewController.isViewOpen = NO;
        [empMgmtViewController.view removeFromSuperview];
        [[MCGameEngineController sharedObject]enableGestures];
        
    }else {
        [[MCGameEngineController sharedObject]disableGestures];
        empMgmtViewController = [[MCEmpMgmtViewController alloc]initWithNibName:[UIDevice properNibFileNameForCurrentDevice:@"MCEmpMgmtViewController"] bundle:nil];
        [empMgmtViewController.view setUserInteractionEnabled:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:8];
        [UIView setAnimationDelay:2];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [self.view  setFrame:CGRectMake(0, 0, 480, 320)];
            
        }else{
           
            [self.view  setFrame:CGRectMake(0, 0, 1024, 768)];
        }
        [UIView setAnimationTransition:UIViewAnimationOptionTransitionFlipFromBottom forView:empMgmtViewController.view cache:NO];
        [UIView commitAnimations];
        [self.view  addSubview:empMgmtViewController.view];
        [self.view bringSubviewToFront:sender];
         empMgmtViewController.isViewOpen = YES;
    }
    
}

#pragma  mark -
#pragma  mark buttonActions
- (IBAction)buyButtonAction:(id)sender
{
    if (categoriesController.isViewOpen) {
         categoriesController.isViewOpen = NO;
        [categoriesController.view removeFromSuperview];
        [[MCGameEngineController sharedObject]enableGestures];
        
    }else {
        [[MCGameEngineController sharedObject]disableGestures];
        if(categoriesController != nil)
        {
            [categoriesController release];
            categoriesController = nil;
        }
        categoriesController = [[MCItemViewController alloc] initWithNibName:[UIDevice properNibFileNameForCurrentDevice:@"MCItemViewController"] bundle:nil];
        [categoriesController.view setUserInteractionEnabled:YES];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [self.view setFrame:CGRectMake(0, 320, 480, 320)];
            [self.view  setFrame:CGRectMake(0, 0, 480, 320)];
            
        }else{
            [self.view setFrame:CGRectMake(0, 768, 1024, 768)];
            [self.view  setFrame:CGRectMake(0, 0, 1024, 768)];
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.8];
        [UIView setAnimationDelay:0.1];
        [UIView commitAnimations];
        [self.view  addSubview:categoriesController.view];
        [self.view bringSubviewToFront:sender];
        categoriesController.isViewOpen = YES;
    }

    
}

@end
