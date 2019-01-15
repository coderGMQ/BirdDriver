//
//  NSMutableArray+Shuffling.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "NSMutableArray+Shuffling.h"

@implementation NSMutableArray (Shuffling)

- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSUInteger n = (arc4random() % (count - i)) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
