//
//  AppDelegate.m
//  MartCityGame
//
//  Created by Laxman Raju on 07/12/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"

#import "RootViewController.h"

@implementation AppDelegate

@synthesize window,sharedOperationQueue;

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

	CC_ENABLE_DEFAULT_GL_STATES();
	CCDirector *director = [CCDirector sharedDirector];
	CGSize size = [director winSize];
	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
	sprite.position = ccp(size.width/2, size.height/2);
	sprite.rotation = -90;
	[sprite visit];
	[[director openGLView] swapBuffers];
	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}
- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    sharedOperationQueue = [[NSOperationQueue alloc] init];
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
//	[window addSubview: viewController.view];
    
    NSString *reqSysVer = @"6.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
    {
        [window setRootViewController:viewController];
        
    
    } else
    {
        [window addSubview: viewController.view];
    }
   
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	
	// Removes the startup flicker
	[self removeStartupFlicker];
    [self loadLoadingViewController];
//    [self loadMaingamePlay];
    [self performSelector:@selector(setLoadingPercentage:) withObject:self afterDelay:0.8];
    
   
	// Run the intro Scene
//	[[CCDirector sharedDirector] runWithScene: [HelloWorldLayer scene]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}



/**
 *  Loading the ProgressBar
 **/


- (void)loadLoadingViewController
{
    
    loadingViewController = [[MCLoadingViewController alloc] initWithNibName:[UIDevice properNibFileNameForCurrentDevice:@"MCLoadingViewController"] bundle:nil];
	[viewController.view addSubview:loadingViewController.view];
    
}


/**
 * setting the  Loading percentage to the ProgressBar
 **/


- (void)setLoadingPercentage:(id)sender
{
    [loadingViewController setLoadingPercentage:100];
    
    [self performSelector:@selector(loadMaingamePlay:) withObject:self afterDelay:0.8];
}

/**
 * loading Game Play
 */

- (void)loadMaingamePlay:(id)sender
{
    loadingViewController.view.hidden = YES;
    gameController = [[MCGameEngineController alloc] init];
    
    [viewController.view addSubview:[MCStoryBoardViewController _sharedObject].view];
    [gameController runGame];
    [gameController startGameFromOwnerFolder];
    
}

//- (void)loadBuyButton
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button setFrame:CGRectMake(400, 30, 50, 30)];
//    [button setTitle:@"BUY" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
//  
//    [viewController.view addSubview:button];
////    NSLog(@"%@",NSStringFromCGRect(button.frame));
//}
//
//- (void)myAction:(id)sender
//{
//    [[GameLogicLayer sharedObject] placeObjectInCorrectPos];
//}
@end
