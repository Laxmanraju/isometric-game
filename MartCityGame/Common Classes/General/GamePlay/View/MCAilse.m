//
//  MCAilse.m
//  MartCityGame
//
//  Created by Sudhakar Tharigoppula on 18/12/12.
//
//

#import "MCAilse.h"
#import "Character.h"

@implementation MCAilse
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        [[CCTextureCache sharedTextureCache] addImageAsync:@"Ailse.png" target:self selector:@selector(createAsyncSprite:)];
//        
//    }
//    return self;
//}

- (id)initWithObject:(NSDictionary *)objectDict andIndex:(int)index
{
    self = [super init];
    
    if (self) {
        [self createAisleSpriteWithData:objectDict andIndex:index];
    }
    return  self;
}

- (void)dealloc
{
    
    [super dealloc];
}

- (void)ObjectStatusUpdate
{
    if (++timerCounts >=8)
    {
        timerCounts = 0;
        [self updatePerSecondEvents];
    }
}

- (void)updatePerSecondEvents
{
    
    if (self.itemsQuantity > 1)
    {
        self.itemsQuantity -=  self.consumptionRate;
         self.depletingLabel.string = [NSString stringWithFormat:@"%d",self.itemsQuantity ] ;
        NSLog(@"%d", self.itemsQuantity);
    }
    
}





@end
