//
//  NSArray+Safe.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

#pragma mark 读取

/**
 *  安全获取一条数据
 *
 *  @param index 数组元素的下标
 *
 *  @return 如果成功获取数据，就返回这条数据，否则就返回nil
 */
- (id)safeObjectAtIndex:(NSUInteger)index;

/**
 *  如果返回值是数组,取出数组里为null的元素
 *
 *  @param key 具体的key
 *
 *  @return 如果返回值是数组,取出数组里为null的元素
 */
- (id)safeValueForKey:(NSString *)key;

@end
