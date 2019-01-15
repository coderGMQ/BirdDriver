//
//  ETRequestParam.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <UIKit/UIKit.h>
//#import "NECSelectCardTypeCell.h"

@interface HttpRequestParam : NSObject

// 基本param
+ (NSDictionary*)param_api_base;
// 登录
+ (NSDictionary *)paramLoginWithLoginName:(NSString *)loginName password:(NSString *)password deviceID:(NSString *)deviceID registrationID:(NSString *)registrationID platform:(NSString *)platform;
// 个人注册
+ (NSDictionary *)paramRegisterWithidCard:(NSString *)idCard loginName:(NSString *)loginName password:(NSString *)password phone:(NSString *)phone userName:(NSString *)userName;
// 发送验证码
+ (NSDictionary *)paramSendCodeForgetPasswordWithPhone:(NSString *)phoneNum;
// 确认验证码
+ (NSDictionary *)paramVerifySecurityCodeWithCheckNum:(NSString *)checkNum key:(NSString *)key;
// 重置密码
+ (NSDictionary *)paramResetPasswordWithLoginName:(NSString *)loginName password:(NSString *)password returnKey:(NSString *)returnKey type:(NSInteger)type;
// 上传图片
+ (NSDictionary *)paramUploadPhotoWithImageData:(UIImage *)ImageData userInfo:(NSDictionary *)userInfo;
// 企业注册
//+ (NSDictionary *)paramRegisterWithLoginName:(NSString *)loginName password:(NSString *)password surePassword:(NSString *)surePassword orgName:(NSString *)orgName legalPerson:(NSString *)legalPerson selectCardType:(NECRegisterSelectCardItem)selectCardType licenseCode:(NSString *)licenseCode organizationCode:(NSString *)organizationCode taxCode:(NSString *)taxCode creditCode:(NSString *)creditCode address:(NSString *)address orgPhone:(NSString *)orgPhone principal:(NSString *)principal phone:(NSString *)phone eMail:(NSString *)eMail license:(NSString *)license organizationCodePic:(NSString *)organizationCodePic taxCodePic:(NSString *)taxCodePic certificatesPic:(NSString *)certificatesPic;

@end


@interface HttpRequestParam (Other)

@end


@interface HttpRequestParam (forum)

@end






