//
//  NSMutableDictionary+Safe.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)

- (BOOL)safeSetObject:(id)anObject forKey:(id<NSCopying>)key{
    if(anObject && key){
        [self setObject:anObject forKey:key];
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)safeRemoveObjectForKey:(id)aKey{
    if(aKey){
        [self removeObjectForKey:aKey];
        return YES;
    }else{
        return NO;
    }
}

@end



