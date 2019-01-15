//
//  UITextField+LimitLength.m
//  ECalendar-Pro
//
//  Created by B.E.N on 15/5/6.
//  Copyright (c) 2015年 etouch. All rights reserved.
//

#import "UITextField+LimitLength.h"
#import <objc/runtime.h>

@implementation UITextField (LimitLength)
static const void *kLimitTextLengthKey = &kLimitTextLengthKey;
- (void)setLimitTextLength:(NSInteger)length
{
    objc_setAssociatedObject(self, kLimitTextLengthKey, [NSNumber numberWithInteger:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
    
}

- (BOOL)isPhoneNum {
    BOOL flag = NO;
    NSString *phoneRegEx = @"^0?(1)[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
    if ([phoneTest evaluateWithObject:self.text]){
        flag = YES;
    }
    return flag;
}

- (BOOL)isCheckNum {
    BOOL flag = NO;
    NSString *phoneRegEx = @"^[0-9]{6}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
    if ([phoneTest evaluateWithObject:self.text]){
        flag = YES;
    }
    return flag;
}

- (BOOL)isSLPassword {
    BOOL flag = NO;
    NSString *phoneRegEx = @"^[A-Za-z0-9]{6,16}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
    if ([phoneTest evaluateWithObject:self.text]){
        flag = YES;
    }
    return flag;
}

- (void)textFieldTextLengthLimit:(id)sender
{
    NSNumber *lengthNumber = objc_getAssociatedObject(self,kLimitTextLengthKey);
    int length = [lengthNumber intValue];
    bool isChinese;//判断当前输入法是否是中文
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    if ([current.primaryLanguage isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
    
    if(sender == self) {
        // length是自己设置的位数
        NSString *str = [[self text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        if (isChinese) { //中文输入法下
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if ( str.length>=length) {
                    NSString *strNew = [NSString stringWithString:str];
                    [self setText:[strNew substringToIndex:length]];
                }
            }
            else
            {
            }
        }else{
            if ([str length]>=length) {
                NSString *strNew = [NSString stringWithString:str];
                [self setText:[strNew substringToIndex:length]];
            }
        }
    }
}

//- (void)scroolSuperViewToUpWithSuperView:(UIView *)superView {
//
//    CGPoint point = [self convertPoint:CGPointZero toView:superView];
//    CGFloat tempY = (__gScreenHeight - 216 - CGRectGetHeight(self.frame));//键盘高度216
//    CGFloat moveDistance = point.y+CGRectGetHeight(self.frame)-tempY;
//    CGFloat targetY = __gNavigationHeight-moveDistance-35;
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect frame = superView.frame;
//        frame.origin.y = targetY;
//        superView.frame = frame;
//    } completion:^(BOOL finished) {
//        CGRect frame = superView.frame;
//        frame.origin.y = targetY;
//        superView.frame = frame;
//    }];
//}

//- (void)scroolSuperViewToNormalWithSuperView:(UIView *)superView {
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect frame = superView.frame;
//        frame.origin.y = __gNavigationHeight+20;
//        superView.frame = frame;
//    } completion:^(BOOL finished) {
//        CGRect frame = superView.frame;
//        frame.origin.y = __gNavigationHeight+20;
//        superView.frame = frame;
//    }];
//}

@end
