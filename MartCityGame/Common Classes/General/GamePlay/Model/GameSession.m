//
//  GameSession.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 18/02/13.
//
//

#import "GameSession.h"

@implementation GameSession

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


+ (NSArray *)getTheEmpManagementInfo
{
    NSArray *empManagementInfo;
//    NSFileManager *fileManger = [[NSFileManager alloc] init];
//    if([fileManger fileExistsAtPath:GAMEINFOPLIST])
//    {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"GameInfo" ofType:@"plist"];
        empManagementInfo = [[NSDictionary dictionaryWithContentsOfFile:plistPath]objectForKey:EMP_MANGEMENT];
//    }

    return empManagementInfo;

}
@end
