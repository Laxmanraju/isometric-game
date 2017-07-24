//
//  CustomProgressView.h
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 20/02/13.
//
//

#import <UIKit/UIKit.h>

@interface CustomProgressView : UIProgressView
{
    UIImage *backgroundImage;
    UIImage *progressImage;
    float progressValue;
    
}
@property (nonatomic, assign) float progressValue;

- (id)initWithFrame:(CGRect)frame aBackground:(UIImage *)backGround andProgress:(UIImage *)progressBar;
@end
