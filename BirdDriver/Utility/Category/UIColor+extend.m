//
//  UIColor+extend.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "UIColor+extend.h"

@implementation UIColor(extend)

+ (UIColor *)hexChangeFloat:(NSString *) hexColor
{
    return [self hexChangeFloat:hexColor AndAlpha:1.0];
}

+ (UIColor *)hexChangeFloat:(NSString *)hexColor AndAlpha:(float)alpha{
    if (hexColor && [hexColor isKindOfClass:[NSString class]] && hexColor.length>0) {
        unsigned int redInt_, greenInt_, blueInt_;
        NSRange rangeNSRange_;
        rangeNSRange_.length = 2;  // 范围长度为2
        
        // 取红色的值
        rangeNSRange_.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
         scanHexInt:&redInt_];
        
        // 取绿色的值
        rangeNSRange_.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
         scanHexInt:&greenInt_];
        
        // 取蓝色的值
        rangeNSRange_.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
         scanHexInt:&blueInt_];
        if (alpha > 1.0f) {
            alpha = 1;
        }else if (alpha < 0.0f){
            alpha = 0;
        }
        return [UIColor colorWithRed:(float)(redInt_/255.0f)
                               green:(float)(greenInt_/255.0f)
                                blue:(float)(blueInt_/255.0f)
                               alpha:alpha];
    } else {
        return [UIColor colorWithRed:(float)(0/255.0f)
                               green:(float)(0/255.0f)
                                blue:(float)(0/255.0f)
                               alpha:alpha];
    }
}

+ (NSString *)hexFromUIColor:(UIColor*)color {
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    return [NSString stringWithFormat:@"%06x", rgb];
}

+ (UIColor *)lightRandom
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 );  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

/**
 *  线条颜色
 *
 *  @return color
 */
+ (UIColor *)lineColor{
    return [UIColor groupTableViewBackgroundColor];
}

/**
 *  标题颜色
 *
 *  @return color
 */
+(UIColor *)blackTitleColor{
    return [UIColor blackColor];
}

/**
 *  辅助性文字颜色，一般为内容等
 *
 *  @return color
 */
+(UIColor *)contentBlackColor{
    return [UIColor hexChangeFloat:@"000000" AndAlpha:0.5];
}

/**
 *  突出性文字，一般为红色。
 *
 *  @return color
 */
+(UIColor *)redTextColor{
    return [UIColor hexChangeFloat:@"FF3355"];
}

/**
 *  子重要性问题一般为青蓝色
 *
 *  @return color
 */
+(UIColor *)buleTextColor{
    return [UIColor hexChangeFloat:@"53A6A6"];
}

/**
 *  白色标题颜色
 *
 *  @return color
 */
+(UIColor *)whiteTitleColor{
    return [UIColor whiteColor];
}

/**
 *  深色背景上辅助性文字颜色50%白色
 *
 *  @return color
 */
+(UIColor *)whiteContentColor{
    return [UIColor hexChangeFloat:@"FFFFFF" AndAlpha:0.5];
}

/**
 *  tableView一般背景颜色
 *
 *  @return color
 */
+(UIColor *)tableViewBGColor{
    return [UIColor hexChangeFloat:@"eeeeee"];
}

/**
 *  常态按钮红色
 *
 *  @return 颜色
 */
+(UIColor *)normalRedBtnBg{
    return [UIColor hexChangeFloat:@"FF3355"];
}

/**
 *  高亮红色按钮
 *
 *  @return 颜色
 */
+(UIColor *)highlightRedBtnBg{
    return [UIColor hexChangeFloat:@"D92B2B"];
}

@end
