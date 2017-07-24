//
//  MCItemViewController.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 26/12/12.
//
//

#import "MCItemViewController.h"

@interface MCItemViewController ()

@end

@implementation MCItemViewController

//@synthesize categoriesScrollView;
//@synthesize itemsContentView;
@synthesize isViewOpen;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.userInteractionEnabled = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 0;
    self.view.userInteractionEnabled = YES;
    [self setContentViewbasedOnDevice];
    [self categorySelectedAction:food];
    [self itemInfoButtonAction:button];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [imageArray release];
    [itemsArray release];
    [super dealloc];
}

- (void)disableAllButtons
{
    if ([previousSelectedBtn tag] == 0) {
        [previousSelectedBtn setFrame:CGRectMake(previousSelectedBtn.frame.origin.x, previousSelectedBtn.frame.origin.y+25, 101, 82)];
    }else if ([previousSelectedBtn tag] == 9){
        [previousSelectedBtn setFrame:CGRectMake(previousSelectedBtn.frame.origin.x+20, previousSelectedBtn.frame.origin.y+25, 101, 82)];
    }else {
        [previousSelectedBtn setFrame:CGRectMake(previousSelectedBtn.frame.origin.x+10, previousSelectedBtn.frame.origin.y+25, 101, 82)];
    }
    [apparel setSelected:NO];
    [hygiene setSelected:NO];
    [hardware setSelected:NO];
    [electronics setSelected:NO];
    [food setSelected:NO];
    [button6 setSelected:NO];
    [button7 setSelected:NO];
    [button8 setSelected:NO];
    [button9 setSelected:NO];
    [button10 setSelected:NO];
    previousSelectedBtn = nil;
}
- (IBAction)categorySelectedAction:(id)sender;
{
    [self cleanItemsImagesScrollView];
    [self disableAllButtons];
    if (!previousSelectedBtn) {
         previousSelectedBtn = sender;
    }
   
    UIButton *selectedButton = nil;
    selectedButton = sender;
    if (selectedButton) {
        
        [categoryScrollView bringSubviewToFront:selectedButton];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1f];
        if ([selectedButton tag] == 0) {
           [selectedButton setFrame:CGRectMake(selectedButton.frame.origin.x, selectedButton.frame.origin.y-25, 121, 122)];
        }else if ([selectedButton tag] == 9){
            [selectedButton setFrame:CGRectMake(selectedButton.frame.origin.x-20, selectedButton.frame.origin.y-25, 121, 122)];
        }else {
            [selectedButton setFrame:CGRectMake(selectedButton.frame.origin.x-10, selectedButton.frame.origin.y-25, 121, 122)];
        }
        
        [UIView commitAnimations];
        [selectedButton setSelected:YES];
    }
    [self loadImageForItemImageView:[sender tag]];
    [self reloadItemsContentViewCategory:[sender tag]];
    [self loadLabelImageOfItem:[sender tag]];
}

- (void)loadLabelImageOfItem:(int)senderTag
{
    
    NSArray* subviews = [itemLabel subviews];
    for(id aObj in subviews) {
        [aObj removeFromSuperview];
    }
    
    UIImageView *labelImage = [[UIImageView alloc] init ];//WithImage:[UIImage imageNamed:@"af0.png"]];
    itemLabel.backgroundColor = [UIColor clearColor];
    switch (senderTag) {
        case 0:
            labelImage.frame = CGRectMake(20, 0, 154, 40);
            labelImage.image = [UIImage imageNamed:@"Apparel@2X.png"];
            break;
        case 1:
            labelImage.frame = CGRectMake(5, 0, 257, 40);
            labelImage.image = [UIImage imageNamed:@"Daily_Hygiene@2X.png"];

            break;
        case 2:
            labelImage.frame = CGRectMake(20, 0, 211, 40);
            labelImage.image = [UIImage imageNamed:@"Electronics@2X.png"];
            break;
        case 3:
            labelImage.frame = CGRectMake(20, 0, 211, 40);
            labelImage.image = [UIImage imageNamed:@"Hardware@2X.png"];
            break;
            
        case 4:
            labelImage.frame = CGRectMake(20, 0,106 , 40);
            labelImage.image = [UIImage imageNamed:@"af.png"];
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            break;
        case 9:
            break;
        default:
            break;
    }
     [itemLabel addSubview:labelImage];
    [labelImage release];
}
- (void)loadImageForItemImageView:(int)senderTag
{
        int imageTag = (senderTag%4);
        switch (imageTag) {
            case 0:itemsImageView.image = [UIImage imageNamed:@"Yellow@2X.png"];
                    
                break;
            case 1:itemsImageView.image = [UIImage imageNamed:@"Green@2X.png"];
                
                break;
            case 2:itemsImageView.image = [UIImage imageNamed:@"Blue@2X.png"];
                
                break;
            case 3:itemsImageView.image = [UIImage imageNamed:@"Red@2X.png"];
                
                break;
            default:
                break;
        }
    
    
}
-(void)setContentViewbasedOnDevice
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        ITEM_WIDTH = 314.0f;
        ITEM_HEIGHT = 381.0f;
        categoryScrollView.contentSize = CGSizeMake(1200,82);
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        ITEM_WIDTH = 140.0;
        ITEM_HEIGHT = 130.0;
    }
}
- (void)reloadItemsContentViewCategory:(int)categoryIndex
{
    if(itemsScrollView)
    {
        [self cleanItemsContentView];
    }
    itemsArray = (NSArray *)[[GameLogicLayer sharedObject]getEntityItems:categoryIndex]; //getItemsForCategoryIndex:categoryIndex];
    [itemsArray retain];
    NSLog(@"items :%@",itemsArray);
    int x_offset = 30;
    int itemsInfoButtonTag = 0;
    
    for (NSDictionary *itemsInfo in itemsArray) {
        
       
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x_offset, 5, 61, 48);
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[itemsInfo objectForKey:@"code"]]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        button.tag = itemsInfoButtonTag++;
        [button addTarget:self action:@selector(itemInfoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [itemsScrollView addSubview:button];
        x_offset += 96;
        
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(x_offset, 0, 5, 60)];
        lineImage.image = [UIImage imageNamed:@"Line@2X.png"];
        [itemsScrollView addSubview:lineImage];
        [lineImage release];
        
        x_offset += 34;
        
    }
}

- (void)itemInfoButtonAction:(id)sender
{
  
    if (itemsImagesScrollView) {
        [self cleanItemsImagesScrollView];
    }
    NSDictionary *aDict = [itemsArray objectAtIndex:[sender tag]];
    imageArray = [[aDict objectForKey:@"tiers"] retain];
    NSLog(@"imageArray :%@",imageArray);
    int x_offset = 12;
    int y_offset = 10;
    int imageTagCount = 0;
    for (NSDictionary *anItemInfo in imageArray) {
       
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            MCitemView *anItem = [[MCitemView alloc] initWithFrame:CGRectMake(x_offset, y_offset, ITEM_WIDTH, ITEM_HEIGHT) itemInfo:anItemInfo andTag:imageTagCount];
//            [anItem setDelegate:self];          // this is scroll view delegate now not using
            [anItem setTag:imageTagCount++];
            [itemsImagesScrollView addSubview:anItem];
             x_offset += ITEM_WIDTH;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x_offset, 0, 4, ITEM_HEIGHT+5)];
            [imageView setImage:[UIImage imageNamed:@"Line.png"]];
            [itemsImagesScrollView addSubview:imageView];
            [imageView release];
            
            [anItem release];
        }
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            MCItemView_iPhone *anItem = [[MCItemView_iPhone alloc] initWithFrame:CGRectMake(x_offset, y_offset, ITEM_WIDTH, ITEM_HEIGHT) itemInfo:anItemInfo];
//            [anItem setDelegate:self];        // this is scroll view delegate now not using
            [anItem setTag:imageTagCount++];
            [itemsImagesScrollView addSubview:anItem];
            
            [anItem release];
        }
       
        x_offset += 20;
        [itemsImagesScrollView setContentSize:CGSizeMake(x_offset, 300)];
    }
}
- (void)cleanItemsContentView
{
    // remove all subviews from items Scrollview
    [itemsArray release];
    itemsArray = NULL;
    NSArray* subviews = [itemsScrollView subviews];
    for(id aObj in subviews) {
        [aObj removeFromSuperview];
    }
    [itemsScrollView setContentOffset:CGPointMake(0,0)];
}

- (void)cleanItemsImagesScrollView {
    // remove all subviews from items Scrollview
    NSArray* subviews = [itemsImagesScrollView subviews];
    for(id aObj in subviews) {
        [aObj removeFromSuperview];
    }
    [itemsImagesScrollView setContentOffset:CGPointMake(0,0)];
}


- (void)purchaseButtonAction:(id)sender
{
    isViewOpen = NO;
    NSDictionary *imageDict =[imageArray objectAtIndex:[sender tag]];
    NSLog(@"imageDict :%@",imageDict);
    [[GameLogicLayer sharedObject]placeObjectInCorrectPos:imageDict];
    [self.view removeFromSuperview];
}

//#pragma mark -
//#pragma mark Delegates Implementation
//#pragma mark -
//
//- (void)itemTouchBeganWithTouches:(MCItemView_iPhone *)details
//{
//   
//}
//
//- (void)itemTouchMovedWithTouches:(MCItemView_iPhone *)details
//{
//    
//}
//
//- (void)itemTouchEndedWithTouches:(MCItemView_iPhone *)details
//{
//    NSDictionary *imageDict = [itemsArray objectAtIndex:[details tag]];
////    NSString *codeString = [imageDict objectForKey:@"code"];
//    
//    [[GameLogicLayer sharedObject]placeObjectInCorrectPos:imageDict];
//    
//    [self.view removeFromSuperview];
//}
//
//
//#pragma mark ScrollView Delegates
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
//{
//	
//	//[[GameLogicLayer sharedObject] showAvatar:YES];
//}
//
//-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//	
//	[[MCGameEngineController sharedObject] enableGestures];
//}
//
//-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//
//	[[MCGameEngineController sharedObject] disableGestures];
//}

@end
