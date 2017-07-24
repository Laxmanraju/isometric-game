//
//  MCItemView_iPhone.m
//  MartCityGame
//
//  Created by Laxman Raju on 08/01/13.
//
//

#import "MCItemView_iPhone.h"
#import "GameConstants.h"
#define COINS_ICON	 @"TS_Coins_s.png"

@implementation MCItemView_iPhone

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame itemInfo:(NSDictionary *)itemDict
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor grayColor]];
        itemImageView = [[MCItemImageView alloc]initWithFrame:CGRectMake(43, 43, 221, 187)];
        [itemImageView setBackgroundColor:[UIColor clearColor]];
        [itemImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_0",[itemDict objectForKey:@"code"]]]];
        [self addSubview:itemImageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 100, 30)];
        [label setBackgroundColor:[UIColor clearColor]];
        [itemImageView addSubview:label];
        [label setText:[itemDict objectForKey:@"label"]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor brownColor]];
        [label release];
        
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
    costView = [[UIView alloc] initWithFrame:CGRectMake(15, 85, 100, 30)];
    [costView setBackgroundColor:[UIColor clearColor]];
    NSString *coinsImag ;
    coinsImag = COINS_ICON;
    

    int cashVal=[[itemDict objectForKey:ITEMCOST]intValue];
    
    UIImageView *costIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, -2, 25, 25)];
    [costIcon setImage:[UIImage imageNamed:coinsImag]];
    [costView addSubview:costIcon];
    [costIcon release];
    
    UILabel *costLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 50, 20)];
    [costLabel setBackgroundColor:[UIColor clearColor]];
    
    [costLabel setText:[NSString stringWithFormat:@"%d",cashVal]];
    [costLabel setTextAlignment:NSTextAlignmentCenter];
    [costLabel setTextColor:[UIColor brownColor]];
    [costView addSubview:costLabel];
    [costLabel release];
    [itemImageView addSubview:costView];
    
}

#pragma mark -
#pragma mark - Touch Delegate Methods.
#pragma mark -


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemTouchBeganWithTouches:)])
    {
        [self.delegate itemTouchBeganWithTouches:self];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemTouchMovedWithTouches:)])
    {
        [self.delegate itemTouchMovedWithTouches:self];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemTouchEndedWithTouches:)])
    {
        [self.delegate itemTouchEndedWithTouches:self];
    }
}
@end
