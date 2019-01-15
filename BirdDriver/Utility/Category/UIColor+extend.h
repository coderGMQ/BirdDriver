//
//  UIColor+extend.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor(extend)

+ (UIColor *)hexChangeFloat:(NSString *) hexColor;

+ (UIColor *)hexChangeFloat:(NSString *) hexColor AndAlpha:(float)alpha;

+ (NSString *)hexFromUIColor:(UIColor*)color;


+ (UIColor *)lightRandom;
/**
 *  线条颜色
 *
 *  @return color
 */
+ (UIColor *)lineColor;

/**
 *  黑标题颜色
 *
 *  @return color
 */
+(UIColor *)blackTitleColor;

/**
 *  辅助性文字颜色，一般为内容等
 *
 *  @return color
 */
+(UIColor *)contentBlackColor;

/**
 *  突出性文字，一般为红色。
 *
 *  @return color
 */
+(UIColor *)redTextColor;

/**
 *  子重要性问题一般为青蓝色
 *
 *  @return color
 */
+(UIColor *)buleTextColor;

/**
 *  白色标题颜色
 *
 *  @return color
 */
+(UIColor *)whiteTitleColor;

/**
 *  深色背景上辅助性文字颜色50%白色
 *
 *  @return color
 */
+(UIColor *)whiteContentColor;

/**
 *  tableView一般背景颜色
 *
 *  @return color
 */
+(UIColor *)tableViewBGColor;

@end
