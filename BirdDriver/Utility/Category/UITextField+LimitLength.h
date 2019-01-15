//
//  UITextField+LimitLength.h
//  ECalendar-Pro
//
//  Created by B.E.N on 15/5/6.
//  Copyright (c) 2015年 etouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LimitLength)
// 限制UITextField的文字字数
- (void)setLimitTextLength:(NSInteger)length;
// 是否是以1开头的11位手机号
- (BOOL)isPhoneNum;
// 是否是六位数字验证码
- (BOOL)isCheckNum;
// 是否smartLife密码规则
- (BOOL)isSLPassword;
//整体上移 superView要为self.__contentView
//- (void)scroolSuperViewToUpWithSuperView:(UIView *)superView;
//移动到正常
//- (void)scroolSuperViewToNormalWithSuperView:(UIView *)superView;
@end
