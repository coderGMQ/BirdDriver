//
//  UIDeviceInfo.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIDeviceInfo : NSObject

//唯一标识
+ (NSString *)UDID;

+ (BOOL)isiPhoneX;

// 设备型号
+ (NSString*)deviceModel;

// 设备型号具体描述 e.g iphone6
+ (NSString *)deviceModelDesc;

// 系统版本
+ (NSString *)systemVersion;

// app版本
+ (NSString *)appVersion;

// 应用ID
+ (NSString *)boundleID;

@end
