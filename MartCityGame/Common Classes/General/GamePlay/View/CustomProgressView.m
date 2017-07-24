//
//  CustomProgressView.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 20/02/13.
//
//

#import "CustomProgressView.h"

@implementation CustomProgressView
@synthesize progressValue;

- (id)initWithFrame:(CGRect)frame aBackground:(UIImage *)backGround andProgress:(UIImage *)progressBar
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        backgroundImage = backGround;
        progressImage = progressBar;
        
    }
    return self;
}
- (void)dealloc
{
    
    [super dealloc];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    
    [backgroundImage drawInRect:rect];
    NSInteger maxWidth = rect.size.width;
    NSInteger curWidth = floor([self progressValue] * maxWidth);
    CGRect fillRect = CGRectMake(rect.origin.x+1,
                                 rect.origin.y,
                                 curWidth,
                                 rect.size.height);
    [progressImage drawInRect:fillRect];
    
}


@end
