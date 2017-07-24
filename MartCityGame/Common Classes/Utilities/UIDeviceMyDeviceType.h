//
//  UIDeviceMyDeviceType.h
//  MartCityGame
//
//  Created by Laxman Raju on 12/12/12.
//
//

#import <Foundation/Foundation.h>

@interface UIDevice (UIDeviceMyDeviceType)

+ (NSString *)myDevicetype;
+ (NSString *)runMode;
+ (NSString *)properNibFileNameForCurrentDevice:(NSString *)baseFileName;
+ (float)myDeviceScreenWidth;
+ (float)myDeviceScreenHeight;

@end
