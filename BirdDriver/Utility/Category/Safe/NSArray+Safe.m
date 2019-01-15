//
//  NSArray+Safe.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

#pragma mark 查询

- (id)safeObjectAtIndex:(NSUInteger)index{
    if(index < [self count]){
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}


- (id)safeValueForKey:(NSString *)key {
    NSArray *arrayObj = [self valueForKey:key];
    if ([arrayObj isKindOfClass:[NSArray class]]) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:arrayObj];
        for (id object in arrayObj) {
            if (object == [NSNull null] || [object isKindOfClass:[NSNull class]]) {
                [tempArray removeObject:object];
            }
        }
        return [NSArray arrayWithArray:tempArray];
    } else {
        return arrayObj;
    }
}

@end



