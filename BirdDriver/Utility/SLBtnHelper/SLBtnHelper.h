//
//  SLBtnHelper.h
//  SmartLife
//
//  Created by han on 2017/3/23.
//
//

#import <Foundation/Foundation.h>

// smartLife常见按钮定义
typedef NS_ENUM(NSInteger, SLCommonButtonType) {
    SLButtonPageMainOperate = 0,          // 页面主操作
    SLButtonPageMinorOperate = 1,         // 页面次操作
    SLButtonBottomHover = 2,              // 底部悬停按钮
    SLButtonContentOperate = 3,           // 内容页操作按钮
};


@interface SLBtnHelper : NSObject

+ (UIButton *)rightNavBtnWithTitle:(NSString *)title;
+ (UIButton *)rightNavBtnWithImageStr:(NSString *)imageStr;
+ (UIButton *)slCommonStyleButtonWithType:(SLCommonButtonType)type;   //smartLife 常见样式按钮
@end
