//
//  MCImageCache.m
//  MartCityGame
//
//  Created by Laxman Raju on 05/02/13.
//
//

#import "MCImageCache.h"
#import "Constant_iPhone.h"

@implementation MCImageCache
static MCImageCache* sharedImageCache;

+(MCImageCache *)sharedMCImageCache
{
    if (sharedImageCache == nil)
    {
        sharedImageCache = [[self alloc] init];
    }
    return sharedImageCache;
}

- (id)init
{
    self = [super init];
    if (self) {
        characterImageStorage = [[NSMutableDictionary alloc]init];
        localImageCache = [[NSMutableDictionary alloc]init];
        bundleString = [[[NSBundle mainBundle] resourcePath]retain];
        gridObjectsCache = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)dealloc
{
    [characterImageStorage release];
    [localImageCache release];
    [bundleString release];
    [gridObjectsCache release];
    [super dealloc];
}

- (NSMutableArray *)getCharacterImageSetWithName:(NSString *)charName actionType:(int)actionType actionSubType:(int)subType totImgCnt:(int)totImgCnt
{
    NSMutableDictionary *aImageSet = [characterImageStorage objectForKey:charName];
    NSString *actTypeString = [NSString stringWithFormat:@"%d", actionType];
    NSString *subActionTypeStr = [NSString stringWithFormat:@"%d_Dir", subType];
    if (aImageSet != NULL)
    {
        NSMutableDictionary *action = [aImageSet objectForKey:actTypeString];
        if (action!= NULL)
        {
            NSMutableDictionary *actionDirection = [action objectForKey:subActionTypeStr];
            if (actionDirection != NULL)
            {
                int count = [[actionDirection objectForKey:@"Count"] intValue];
                count ++;
                [actionDirection setObject:[NSNumber numberWithInt:count] forKey:@"Count"];
                return [[[[characterImageStorage objectForKey:charName] objectForKey:actTypeString]objectForKey:subActionTypeStr]objectForKey:@"ImageArr"];
            }
            else
            {
                actionDirection = [[NSMutableDictionary alloc]init];
                NSString *aString = [[NSString alloc] initWithFormat:@"%@_%d", charName, actionType];
                
                [self storeAnimationImgsWithName:aString subType:subType inDict:actionDirection maxImgCnt:totImgCnt];
                [aString release];
				
				[action setObject:actionDirection forKey:[NSString stringWithFormat:@"%d_Dir",subType]];
				[aImageSet setObject:action forKey:[NSString stringWithFormat:@"%d",actionType]];
				[actionDirection release];
                
				return [[[[characterImageStorage objectForKey:charName] objectForKey:actTypeString]  objectForKey:subActionTypeStr] objectForKey:@"ImageArr"];
            }
        }
        else
        {
            
			NSMutableDictionary *actionDirection;
			
			action = [[NSMutableDictionary alloc]init];
			actionDirection = [[NSMutableDictionary alloc]init];
			
			NSString *aString = [[NSString alloc] initWithFormat:@"%@_%d",charName,actionType];
			
			[self storeAnimationImgsWithName:aString subType:subType inDict:actionDirection maxImgCnt:totImgCnt];
			[aString release];
			[action setObject:actionDirection forKey:[NSString stringWithFormat:@"%d_Dir",subType]];
			[aImageSet setObject:action forKey:[NSString stringWithFormat:@"%d",actionType]];
			[action release];
			[actionDirection release];
			
            
			return [[[[characterImageStorage objectForKey:charName ] objectForKey:actTypeString]  objectForKey:subActionTypeStr] objectForKey:@"ImageArr"];
        }
    
    }
    else
	{
		aImageSet = [[NSMutableDictionary alloc]init];
		
		NSMutableDictionary *action = [[NSMutableDictionary alloc]init];
		NSMutableDictionary *actionDirection = [[NSMutableDictionary alloc]init];
		
		NSString *aString = [[NSString alloc] initWithFormat:@"%@_%d",charName,actionType];
		
		[self storeAnimationImgsWithName:aString subType:subType inDict:actionDirection maxImgCnt:totImgCnt];
		[aString release];
		[action setObject:actionDirection forKey:[NSString stringWithFormat:@"%d_Dir",subType]];
		[aImageSet setObject:action forKey:[NSString stringWithFormat:@"%d",actionType]];
		[action release];
		[actionDirection release];
		[characterImageStorage setObject:aImageSet forKey:charName];
		[aImageSet release];

		return [[[[characterImageStorage objectForKey:charName] objectForKey:actTypeString]  objectForKey:subActionTypeStr] objectForKey:@"ImageArr"];
	}
}

- (void)storeAnimationImgsWithName:(NSString*)imgName subType:(int)subType inDict:(NSMutableDictionary*)aDict maxImgCnt:(int)totImgCnt
{
    
    NSLog(@"imagname =%@, suybType = %d", imgName, subType);
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
	NSString *plistName;
	NSString *pathForImageFile ;
	plistName = [[NSString alloc] initWithFormat:@"%@/%@_%d.plist",IMAGES_PATH,imgName,subType];
	if([[NSFileManager defaultManager] fileExistsAtPath:plistName])
		pathForImageFile = [[NSString alloc] initWithString:plistName];//[[NSString alloc] initWithString:[bundleString stringByAppendingPathComponent:plistName]];
	else{
		if(plistName){
			[plistName release];
			plistName = nil;
		}
		plistName = [[NSString alloc] initWithFormat:@"%@_%d.plist",imgName,subType];
		pathForImageFile = [[NSString alloc] initWithString:[bundleString stringByAppendingPathComponent:plistName]];
	}
    
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:pathForImageFile];  /// lx doing this we parse the plist and keep track of where all images  of the sprites are
	for (int i = 0;i<totImgCnt;i++)
	{
		NSString *aImgName = [[NSString alloc]initWithFormat:@"%@_%d_%d.png",imgName,subType,i];
		CCSpriteFrame *aImage = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:aImgName];//lx geting image from local cache
		if(aImage)
			[imageArr addObject:aImage];
		[aImgName release];
	}
	[aDict setObject:imageArr forKey:@"ImageArr"];
	[aDict setObject:[NSNumber numberWithInt:1] forKey:@"Count"];
	[pathForImageFile release];
	[plistName release];
	[imageArr release];
}

- (void)removeImageSet:(NSString*)characterName action:(int)actionType direction:(int)direction
{
    @synchronized ([UIApplication sharedApplication])
    {
        NSMutableDictionary *aImageSet = [characterImageStorage objectForKey:characterName];
        NSString *actionTypeString = [[NSString alloc]initWithFormat:@"%d",actionType];
        NSString *SubActionTypeStr = [[NSString alloc] initWithFormat:@"%d_Dir",direction];
        if (aImageSet != NULL)
        {
            NSMutableDictionary *action =[aImageSet objectForKey:actionTypeString];
            if (action != NULL)
            {
                NSMutableDictionary *actionDirection = [aImageSet objectForKey:SubActionTypeStr];
                if ( actionDirection != NULL)
                {
                    int count = [[actionDirection objectForKey:@"Count"] intValue];
                    if (count == 0)
                    {
                        [actionTypeString release];
                        [SubActionTypeStr release];
                        return;
                    }
                    if (count>0)
                        count--;
                    [actionDirection setObject:[NSNumber numberWithInt:count] forKey:@"Count"];
                    if (count == 0)
                    {
                        int framesCount = [[actionDirection objectForKey:@"ImageArr"] count];
                        [action removeObjectForKey:SubActionTypeStr];
                        NSString *removeName = [[NSString alloc] initWithFormat:@"%@/%@_%d_%d.pvr.ccz",IMAGES_PATH, characterName, actionType,direction];
                        if ([[NSFileManager defaultManager] fileExistsAtPath:removeName] == NO)
                        {
                            [removeName release];
                            removeName = nil;
                            removeName = [[NSString alloc] initWithFormat:@"%@/%@_%d_%d.png",IMAGES_PATH,characterName,actionType,direction];    
                        }
                        
                        for (int i=1; i<=framesCount; i++)
                        {
                            NSString *removableFrame = [[NSString alloc]initWithFormat:@"%@_%d_%d_%d.png", characterName, actionType, direction,i];
                            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrameByName:removableFrame];
                            [removableFrame release];
                        }
                        
                        [removeName release];
                        removeName = nil;
                        [action removeObjectForKey:SubActionTypeStr];
                        
                    }

                }
            }
        }
        
        [SubActionTypeStr release];
        [actionTypeString release];
        
    }
}
@end
