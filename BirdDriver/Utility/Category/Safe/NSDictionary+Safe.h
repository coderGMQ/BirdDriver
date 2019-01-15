//
//  NSDictionary+Safe.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safe)

- (id)safeObjectForKey:(id<NSCopying>)aKey;

//确保返回类型是String类型
- (id)safeObjectForKeyString:(id<NSCopying>)aKey;

+ (instancetype)safeDictionaryWithObject:(id)object forKey:(id <NSCopying>)key;

@end
