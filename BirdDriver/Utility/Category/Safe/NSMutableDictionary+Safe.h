//
//  NSMutableDictionary+Safe.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safe)

/**
 *  安全向字典里加入一条数据，不管这条数据是否为nil
 *
 *  @param anObject 一条需要增加的数据
 *  @param key key值
 *
 *  @return 返回是否增加成功  YES:成功  NO:失败
 */
- (BOOL)safeSetObject:(id)anObject forKey:(id<NSCopying>)key;


/**
 *  安全从字典里移除一条数据，不管这条数据是否为nil,如果是nil 就什么都不作
 *
 *  @param aKey key值
 *
 *  @return 返回是否增加成功  YES:成功  NO:失败
 */
- (BOOL)safeRemoveObjectForKey:(id)aKey;

@end


