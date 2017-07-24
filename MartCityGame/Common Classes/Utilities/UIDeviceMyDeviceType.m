//
//  UIDeviceMyDeviceType.m
//  MartCityGame
//
//  Created by Laxman Raju on 12/12/12.
//
//

#import "UIDeviceMyDeviceType.h"
#import "cocos2d.h"

@implementation UIDevice (UIDeviceMyDeviceType)
static NSString *sMyDeviceType = nil;
static NSString *sRunMode = nil;
static float screenWidth = 0;
static float screenHeight= 0;

/***
** figure out what data is for the first time, and stash results in
**/
+(void) setUpMyData
{
    NSRange textRange;
    NSString *sModel = [UIDevice currentDevice].model;
    textRange = [sModel rangeOfString:@"iPhone"];
    CGSize winsize =[[CCDirector sharedDirector]winSize];
    if (winsize.width == 1024.0f)
    {
        sMyDeviceType = @"iPad"; // 2147483647
        screenWidth = 1024.0f;
        screenHeight = 768.0f;
        
    }
    else if(winsize.width == 480.0f)
    {
        sMyDeviceType = @"iPhone"; 
        screenWidth = 480.0f;
        screenHeight = 320.0f;
    }
    else {
        sMyDeviceType = @"iPhone 5";
        screenWidth = 568.0f;
        screenHeight = 320.0f;
        
    }
    
    textRange = [sModel rangeOfString:@"Simulator"];
    if (textRange.location != NSNotFound)
    {
        sRunMode = @"Simulator";
    }
    else
    {
    sRunMode = @"ActulDevice";
    }
}// end of setUp data member/method


/**
 * returns iPad or iPhone depending on what it is currently running on:
 **/
+ (NSString *)myDevicetype
{
       if (sMyDeviceType==nil)
            [self setUpMyData];
        return sMyDeviceType;
}

/**
 * returns the type of device runnig the game i.e "Simulator" or "ActualDevice"
 **/
+ (NSString *)runMode
{
    if (sMyDeviceType == nil)
        [self setUpMyData];
    return sRunMode;
}

/**
 Build our nib file name for the use with initWithNibName: when creating a viewController object. 
 This makes the assumption that we are using a naming convention of iPad or iPhone at the end of the file name.
 It is also making the assumption that we are not inclusing the file extention(same assumptio that init with nib name makes
 )**/
+ (NSString *)properNibFileNameForCurrentDevice:(NSString *)baseFileName
{
    NSString *fileName = baseFileName;
    if (sMyDeviceType==nil)
        [self setUpMyData];
    fileName = [fileName stringByAppendingString:@"_"];
    fileName = [fileName stringByAppendingString:sMyDeviceType];
    return fileName;
}

/**
 * return the current active device screen width
 **/
+ (float)myDeviceScreenWidth
{
    if (sMyDeviceType == nil)
        [self setUpMyData];
    return  screenWidth;
}

/**
 * return the current active device screen height
 **/
+ (float)myDeviceScreenHeight
{
    if (sMyDeviceType == nil)[self setUpMyData];
    return screenHeight;
}
@end
