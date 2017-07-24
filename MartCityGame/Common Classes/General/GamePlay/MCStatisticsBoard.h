//
//  MCStatisticsBoard.h
//  MartCityGame
//
//  Created by Laxman Raju on 21/01/13.
//
//

#import <UIKit/UIKit.h>

@interface MCStatisticsBoard : UIView
{
    IBOutlet UILabel        *coinsLabel;
}

-(void) updateLevel:(int)levelsToUpdate coins:(int)coinsToUpdate;
@end
