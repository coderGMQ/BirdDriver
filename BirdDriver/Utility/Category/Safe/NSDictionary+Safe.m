//
//  NSDictionary+Safe.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)

- (id)safeObjectForKey:(id<NSCopying>)aKey {
    id object = [self objectForKey:aKey];
    if (object == [NSNull null] || [object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return object;
}

//确保返回类型是String类型
- (id)safeObjectForKeyString:(id<NSCopying>)aKey
{
    id object = [self objectForKey:aKey];
    if (![object isKindOfClass:[NSString class]]) {
        return nil;
    }
    return object;
}

+ (instancetype)safeDictionaryWithObject:(id)object forKey:(id <NSCopying>)key {
    if (object && key) {
        return [[self class] dictionaryWithObject:object forKey:key];
    } else {
        return nil;
    }
}
@end
