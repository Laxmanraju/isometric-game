//
//  MCStatisticsBoard.m
//  MartCityGame
//
//  Created by Laxman Raju on 21/01/13.
//
//

#import "MCStatisticsBoard.h"

@implementation MCStatisticsBoard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

-(void)awakeFromNib
{
    [self updateLevel:0 coins:100];
}

-(void) updateLevel:(int)levelsToUpdate coins:(int)coinsToUpdate
{
    if (levelsToUpdate)
    {
        
    }
    
    if (coinsToUpdate)
    {
        int currentValue = [coinsLabel.text intValue];
        int valueToBeUpdated = currentValue + coinsToUpdate;
        
        if (valueToBeUpdated >= 0)
        {
            [coinsLabel setText:[NSString stringWithFormat:@"%d", valueToBeUpdated]];
        }
    }
}

@end
