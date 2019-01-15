//  UIView+Custom.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Custom)

//获取该View的父Controller--获取不到返回nil
- (UIViewController *)viewController;

/**
 *  设置view 的阴影
 *
 *  @param shadowSize  阴影偏移，默认(0, -3)  -3表示顶部有阴影  正数下部有阴影
 *  @param shadowColor 阴影色
 */
- (void)setShadowWithOffset:(CGSize)shadowSize andShadowColor:(UIColor *)shadowColor;

/**
 *  根据tag获取当前View的子View
 *
 *  @param adjoin  YES:只获取仅靠fatherView的子View,忽略子View的子View NO:等同于系统viewWithTag
 */
- (UIView *)viewWithTag:(NSInteger)tag adjoinFatherView:(BOOL)adjoin;

@end


