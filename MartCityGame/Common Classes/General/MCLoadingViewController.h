//
//  MCLoadingViewController.h
//  MCLoadingView
//
//  Created by Laxman Raju on 07/12/12.
//
//

#import <UIKit/UIKit.h>

@interface MCLoadingViewController : UIViewController
{
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UIImageView *backGroundView;
    IBOutlet UILabel *loadingLabel;
    
    IBOutlet UIImageView *loadingIndicatorBar;
    IBOutlet UIImageView *loadingIndicator;
    IBOutlet UIView *progressIndicatorView;
    
    
    int  oldPercent;
    int  percent;
    int  LOADING_BAR_WIDTH;

}

/**
 *  loading percentage
 **/


- (void)setLoadingPercentage:(int)percentage;
- (void)setLoadingIndicatorFrame;
@end
