//
//  MCEmpView_iPhone.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 25/02/13.
//
//

#import "MCEmpView_iPhone.h"

@implementation MCEmpView_iPhone

- (id)initWithFrame:(CGRect)frame anItemInfo:(NSDictionary *)anItemInfo andTag:(int)hireButtonTag
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addItemInfoContent:anItemInfo andTag:hireButtonTag];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)addItemInfoContent:(NSDictionary *)anItemInfo andTag:(int)hireButtonTag
{
    UIImageView *anItemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(51, 11, 42, 77)];
    [anItemImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_1.png",[anItemInfo objectForKey:@"code"]]]];
    [self addSubview:anItemImageView];
    [anItemImageView release];
    
    UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(40, 93, 63, 15)];
    [label setBackgroundColor:[UIColor clearColor]];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    label.text = [anItemInfo objectForKey:@"empName"];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    [label release];
    NSDictionary *dict = [anItemInfo objectForKey:@"role"];
    
    UIImage *backGround = [UIImage imageNamed:@"Stats_bar_BG.png"];
    UIImage *greenBar = [UIImage imageNamed:@"GreenBar.png"];
    CustomProgressView *efficiencyBar = [[CustomProgressView alloc] initWithFrame:CGRectMake(20.0f, 99.0f, 33.0f, 10.0f) aBackground:backGround andProgress:greenBar];
    efficiencyBar.progressValue = [[dict objectForKey:@"Efficiency"] floatValue]/100;
    [self addSubview:efficiencyBar];
    [efficiencyBar release];
    
    
    UIImage *redBar = [UIImage imageNamed:@"RedBar.png"];
    CustomProgressView *hardworkerBar = [[CustomProgressView alloc] initWithFrame:CGRectMake(55, 99.0f, 33.0f, 10.0f) aBackground:backGround andProgress:redBar];
    hardworkerBar.progressValue = [[dict objectForKey:@"HardWorker"] floatValue]/100;
    [self addSubview:hardworkerBar];
    [hardworkerBar release];
    
    
    UIImage *orangeBar = [UIImage imageNamed:@"OrangeBar.png"];
    CustomProgressView *peopleSkilsBar = [[CustomProgressView alloc] initWithFrame:CGRectMake(91, 99.0f, 33.0f, 10.0f) aBackground:backGround andProgress:orangeBar];
    peopleSkilsBar.progressValue = [[dict objectForKey:@"PeopleSkils"] floatValue]/100;
    [self addSubview:peopleSkilsBar];
    [peopleSkilsBar release];
    
    
    
    UIButton *hireButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hireButton addTarget:self action:@selector(hireButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    hireButton.frame = CGRectMake(36, 122, 72, 24);
    hireButton.backgroundColor = [UIColor clearColor];
    [hireButton setImage:[UIImage imageNamed:@"Hire_button@2X.png"] forState:UIControlStateNormal];
    [self addSubview:hireButton];
    
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-4, self.frame.size.height/8, 4, 75)];
    [lineImage setImage:[UIImage imageNamed:@"Line.png"]];
    [self addSubview:lineImage];
    [lineImage release];
}
@end
