//
//  MCEmpManagementView.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 16/02/13.
//
//

#import "MCEmpManagementView.h"
#import "MCStoryBoardViewController.h"

@implementation MCEmpManagementView
@synthesize isViewOpen;




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        CGAffineTransform tr = CGAffineTransformScale(self.transform, 1.8, 1.7);
//        self.transform = tr;
         self.userInteractionEnabled = YES;
        empButtonsImageView.userInteractionEnabled = YES;
        
        
    }
    return self;
}

- (void)dealloc
{
    [aItems release];
    [super dealloc];
}
-(void)awakeFromNib
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [self  setFrame:CGRectMake(25, self.frame.size.height+self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        assistanceView.hidden = YES;
        confirmAlertView.hidden = YES;
    }else {
        [self  setFrame:CGRectMake(0, self.frame.size.height+ self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        assistanceView.hidden = YES;
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)showEmpManagementView
{
   
    isViewOpen = YES;
    CGRect empFrame = self.frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [self setFrame:empFrame];
    [UIView setAnimationDelegate:self];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self cleanItemsContentView];
        [self  setFrame:CGRectMake(25,self.frame.size.height-self.frame.size.height+62, self.frame.size.width, self.frame.size.height)];
        
    }else{
        [self cleanItemsContentView];
        [self  setFrame:CGRectMake(10,self.frame.size.height-self.frame.size.height+31, self.frame.size.width, self.frame.size.height)];
        
    }
    [UIView commitAnimations];
    [self empInfoImplementation:1];
    self.userInteractionEnabled = YES;
    
}

- (void)hideEmpManagementView
{
    isViewOpen = NO;
    CGRect empFrame = self.frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [self setFrame:empFrame];
    [UIView setAnimationDelegate:self];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self  setFrame:CGRectMake(25,self.frame.size.height+self.frame.size.height/1.2, self.frame.size.width, self.frame.size.height)];
        assistanceView.hidden = YES;
        confirmAlertView.hidden = YES;
    }else{
        [self  setFrame:CGRectMake(10,self.frame.size.height+self.frame.size.height+31, self.frame.size.width, self.frame.size.height)];
        assistanceView.hidden = YES;
    }
    [UIView commitAnimations];
}


- (NSArray *)getTheSelectedEmpInfo:(int)tag
{
    NSArray *empInfo = [GameSession getTheEmpManagementInfo];
    NSDictionary *aDict = [empInfo objectAtIndex:(tag-1)];
    NSArray *aArr = [aDict objectForKey:[aDict objectForKey:@"label"]];
    return aArr;
}

- (IBAction)empManagementButtonAction:(id)sender
{
     selectedTag = [sender tag];
    if (selectedTag == 1) {
         [self empInfoImplementation:selectedTag]; 
    }
    [self addSelectedImage:sender];
    
}
- (void)addSelectedImage:(UIButton*)button
{
    if (button.tag == 1) {
        empButtonsImageView.image = [UIImage imageNamed:@"Asst_Manager@2X.png"];
        empInfoBgImageView.image = [UIImage imageNamed:@"Asst_Manager_Background@2X.png"];
        [self cleanItemsContentView];
    }else if (button.tag == 2) {
        empButtonsImageView.image = [UIImage imageNamed:@"Franchise@2X.png"];
        empInfoBgImageView.image = [UIImage imageNamed:@"Franchise_Background@2X.png"];
        empInfoButtonsImageView.image = [UIImage imageNamed:@"Expand@2X.png"];
        [self cleanItemsContentView];
    }else if (button.tag == 3) {
        empButtonsImageView.image =[UIImage imageNamed:@"Social@2X.png"];
        empInfoBgImageView.image = [UIImage imageNamed:@"Social_Background@2X.png"];
        empInfoButtonsImageView.image = [UIImage imageNamed:@"Social_Bar@2X.png"];
        [self cleanItemsContentView];
    }else {
        empButtonsImageView.image = [UIImage imageNamed:@"Stats@2X.png"];
        empInfoBgImageView.image = [UIImage imageNamed:@"Stats_Background@2X.png"];
        empInfoButtonsImageView.image = [UIImage imageNamed:@"Stats_Bar@2X.png"];
        [self cleanItemsContentView];
    }
    
}

- (IBAction)empInfoButtonAction:(id)sender
{
    
    int senderTag = [sender tag];
    [self empInfoImplementation:senderTag];
}

- (void)empInfoImplementation:(int)senderTag
{
    if (!selectedTag) {
        selectedTag = 1;
    }
    int ITEM_WIDTH;
    int ITEM_HEIGHT;
    int x_offset;
    int y_offset;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        ITEM_WIDTH = 308;
        ITEM_HEIGHT = 400;
        x_offset = 10;
        y_offset = 10;
    }else {
        ITEM_WIDTH = 134;
        ITEM_HEIGHT = 155;
        x_offset = 6;
        y_offset = 6;
    }
    
    NSArray *empManagementInfo = [self getTheSelectedEmpInfo:selectedTag];
    [self updatingButtonImages:senderTag];
    aItems = [[[empManagementInfo objectAtIndex:senderTag-1] objectForKey:[[empManagementInfo objectAtIndex:senderTag-1] objectForKey:@"label"]] retain];
    int hireButtonTag =1;
    
    for (NSDictionary *anItemInfo in aItems) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
           
            MCEmpView *anItemView = [[MCEmpView alloc] initWithFrame:CGRectMake(x_offset, y_offset, ITEM_WIDTH, ITEM_HEIGHT) anItemInfo:anItemInfo andTag:hireButtonTag];
            [anItemView setBackgroundColor:[UIColor clearColor]];
           
            [empMngmtScrollView addSubview:anItemView];
            [anItemView release];
             x_offset += 10;
            [empMngmtScrollView setContentSize:CGSizeMake(x_offset, 385)];
            
        }else {
            
            MCEmpView *anItemView = [[MCEmpView alloc] initWithFrame:CGRectMake(x_offset, y_offset, ITEM_WIDTH, ITEM_HEIGHT)];
            [anItemView setBackgroundColor:[UIColor clearColor]];
            [empMngmtScrollView addSubview:anItemView];
            [anItemView release];
             x_offset += 6;
            [empMngmtScrollView setContentSize:CGSizeMake(x_offset, 151)];
        }

        x_offset += ITEM_WIDTH;

    }
    
    
}

- (void)updatingButtonImages:(int)senderTag
{
    if (selectedTag == 1) {
        if (senderTag == 1) {
            [empInfoButtonsImageView setImage:[UIImage imageNamed:@"Employees@2X.png"]];
            [self cleanItemsContentView];
        }else if (senderTag == 2){
            [empInfoButtonsImageView setImage:[UIImage imageNamed:@"Floorspace@2X.png"]] ;
            [self cleanItemsContentView];
        }else {
            [empInfoButtonsImageView setImage:[UIImage imageNamed:@"Security@2X.png"]];
            [self cleanItemsContentView];
        }
        
    }else if (selectedTag == 2){
        
        if (senderTag == 1) {
            [empInfoButtonsImageView setImage:[UIImage imageNamed:@"Expand@2X.png"]];
            [self cleanItemsContentView];
        }else if (senderTag == 2){

        }else {
            [empInfoButtonsImageView setImage:[UIImage imageNamed:@"TakeOver@2X.png"]];
            [self cleanItemsContentView];
        }
    }else if (selectedTag == 3){
        
    }else{
        
    }

}
- (void)cleanItemsContentView {
    // remove all subviews from items Scrollview
   
    
    NSArray* subviews = [empMngmtScrollView subviews];
    for(id aObj in subviews) {
        [aObj removeFromSuperview];
    }
    [empMngmtScrollView setContentOffset:CGPointMake(0,0)];
}

- (void)hireButtonSelected :(id)sender
{
    characterName =   [[aItems objectAtIndex:[sender tag]-1]objectForKey:@"code"];
    assistanceView.hidden = NO;
    [self cleanItemsContentView];
    [assistanceView setFrame:CGRectMake(34, 225, assistanceView.frame.size.width, assistanceView.frame.size.height)];
    self.userInteractionEnabled = NO;
}

// assistanceView

- (IBAction)acceptButtonAction:(id)sender
{
    if ([sender tag] == 1) {
        [self generateConfirmAlert];
        [self assignAssistantRole];
    }else if ([sender tag] == 2) {
        [self generateConfirmAlert];
        [self assignCashierRole];
    }else{
        [self generateConfirmAlert];
        [self assignMaintainanceRole];
    }
    
}

- (void)assignAssistantRole
{
    NSLog(@"characterName :%@",characterName);
    [[GameLogicLayer sharedObject] fetchCharacterOfKind:@"1_122" atGrid:ccp(8, 3) withAction:LOOK_ACTION andDirection:RIGHT];
   

}

- (void)assignCashierRole
{
     NSLog(@"characterName :%@",characterName);
    [[GameLogicLayer sharedObject]fetchCharacterOfKind:@"1_133" atGrid:ccp(0,3) withAction:LOOK_ACTION andDirection:DOWN];
}

- (void)assignMaintainanceRole
{
     NSLog(@"characterName :%@",characterName);
    [[GameLogicLayer sharedObject]fetchCharacterOfKind:@"1_111" atGrid:ccp(0,8) withAction:LOOK_ACTION andDirection:LEFT];
}

- (void)generateConfirmAlert
{
    confirmAlertView.hidden = NO;
    
}


- (IBAction)confirmButtonAction:(id)sender
{
    [self hideEmpManagementView];
    self.userInteractionEnabled = YES;
    [[MCGameEngineController sharedObject]enableGestures];
}
- (IBAction)cancelButtonAction:(id)sender
{
    
}
@end
