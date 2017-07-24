//
//  MCEmpView.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 19/02/13.
//
//

#import "MCEmpView.h"

@implementation MCEmpView

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
    UIImageView *anItemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(105, 30, 78, 174)];
    [anItemImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_1.png",[anItemInfo objectForKey:@"code"]]]];
    [self addSubview:anItemImageView];
    [anItemImageView release];
    
    UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(70, 200, 150, 50)];
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
    CustomProgressView *efficiencyBar = [[CustomProgressView alloc] initWithFrame:CGRectMake(30.0f, 250.0f, 80.0f, 20.0f) aBackground:backGround andProgress:greenBar];
    efficiencyBar.progressValue = [[dict objectForKey:@"Efficiency"] floatValue]/100;
    [self addSubview:efficiencyBar];
    [efficiencyBar release];
    
    
    UIImage *redBar = [UIImage imageNamed:@"RedBar.png"];
    CustomProgressView *hardworkerBar = [[CustomProgressView alloc] initWithFrame:CGRectMake(115, 250, 80, 20) aBackground:backGround andProgress:redBar];
    hardworkerBar.progressValue = [[dict objectForKey:@"HardWorker"] floatValue]/100;
    [self addSubview:hardworkerBar];
    [hardworkerBar release];
    
    
    UIImage *orangeBar = [UIImage imageNamed:@"OrangeBar.png"];
    CustomProgressView *peopleSkilsBar = [[CustomProgressView alloc] initWithFrame:CGRectMake(200, 250, 80, 20) aBackground:backGround andProgress:orangeBar];
    peopleSkilsBar.progressValue = [[dict objectForKey:@"PeopleSkils"] floatValue]/100;
    [self addSubview:peopleSkilsBar];
    [peopleSkilsBar release];
    
    
    
    UIButton *hireButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hireButton addTarget:self.superview action:@selector(hireButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    hireButton.frame = CGRectMake(85, 298, 162, 55);
    hireButton.backgroundColor = [UIColor clearColor];
    hireButton.tag = hireButtonTag++;
    [hireButton setImage:[UIImage imageNamed:@"Hire_button@2X.png"] forState:UIControlStateNormal];
    [self addSubview:hireButton];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-4, self.frame.size.height/8, 4, 200)];
    [lineImage setImage:[UIImage imageNamed:@"Line.png"]];
    [self addSubview:lineImage];
    [lineImage release];
}

@end
