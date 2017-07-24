//
//  MCitemView.m
//  MartCityGame
//
//  Created by Laxman Raju on 08/01/13.
//
//

#import "MCitemView.h"
#import "GameConstants.h"

#define COINS_ICON	 @"TS_Coins_s.png"

@implementation MCitemView
//@synthesize delegate;                // this is scroll view delegate now not using

- (id)initWithFrame:(CGRect)frame itemInfo:(NSDictionary *)itemDict andTag:(int)imageTag
{
    self = [super initWithFrame:frame];
    if (self)
    {
    
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
         MCItemImageView *itemImageView = [[MCItemImageView alloc]initWithFrame:CGRectMake(17, 24, 262, 206)];
        [itemImageView setBackgroundColor:[UIColor clearColor]];
         NSString *imageName = [itemDict objectForKey:@"code"];
//        NSLog(@"imageName :%@",imageName);
        itemImageView.contentMode = UIViewContentModeScaleAspectFit;
        [itemImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_0",imageName]]];
        [self addSubview:itemImageView];
        self.userInteractionEnabled = YES;
        
        UIButton *purchaseButton = [UIButton buttonWithType:UIControlStateNormal];
        purchaseButton.frame = CGRectMake(65, 290, 165, 55);
        [purchaseButton setImage:[UIImage imageNamed:@"Purchase@2X.png"] forState:UIControlStateNormal];
        purchaseButton.backgroundColor = [UIColor clearColor];
        purchaseButton.tag =  imageTag;
        [purchaseButton addTarget:self.superview action:@selector(purchaseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:purchaseButton];
        
        [self displayCost:itemDict];
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

- (void)displayCost:(NSDictionary *)itemDict
{
    UIView *costView = [[UIView alloc] initWithFrame:CGRectMake(90, 245, 100, 35)];
    [costView setBackgroundColor:[UIColor clearColor]];
    NSString *coinsImage;
    coinsImage = COINS_ICON;
    
    int cashVal = [[itemDict objectForKey:ITEMCOST]intValue];
    
    UIImageView *costIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 28, 31)];
    [costIcon setImage:[UIImage imageNamed:coinsImage]];
    [costView addSubview:costIcon];
    [costIcon release];
    
    UILabel *costLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 50, 31)];
    [costLabel setBackgroundColor:[UIColor clearColor]];
    [costLabel setText:[NSString stringWithFormat:@"%d", cashVal]];
    [costLabel setTextAlignment:NSTextAlignmentCenter];
    [costLabel setTextColor:[UIColor brownColor]];
    [costView addSubview:costLabel];
    [costLabel release];
    [self addSubview:costView];
    
}



// this is scroll view delegate now not using

//#pragma mark -
//#pragma mark - Touch Delegate Methods.
//#pragma mark -
//
//
//
//
//- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(itemTouchBeganWithTouches:)])
//    {
//        [self.delegate itemTouchBeganWithTouches:self];
//    }
//}
//
//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(itemTouchMovedWithTouches:)])
//    {
//        [self.delegate itemTouchMovedWithTouches:self];
//    }
//}
//
//- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(itemTouchEndedWithTouches:)])
//    {
//        [self.delegate itemTouchEndedWithTouches:self];
//    }
//}


@end
