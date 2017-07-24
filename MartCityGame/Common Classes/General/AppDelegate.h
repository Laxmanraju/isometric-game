//
//  AppDelegate.h
//  MartCityGame
//
//  Created by Laxman Raju on 07/12/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "MCGameEngineController.h"
#import "MCStoryBoardViewController.h"
#import "MCLoadingViewController.h"

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow			*window;
	RootViewController	*viewController;
    MCGameEngineController *gameController;
    MCLoadingViewController *loadingViewController;
    NSOperationQueue *   sharedOperationQueue;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) NSOperationQueue *   sharedOperationQueue;


/**
 * loading Game Play
 */

- (void)loadMaingamePlay:(id)sender;


@end
