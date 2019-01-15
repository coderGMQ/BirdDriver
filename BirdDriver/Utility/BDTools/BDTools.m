//
//  BDTools.m
//  BirdDriver
//
//  Created by 甘明强 on 2018/12/28.
//  Copyright © 2018年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDTools.h"

@implementation BDTools

+ (BOOL)validateEmail:(NSString *)strEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:strEmail];
}

@end
