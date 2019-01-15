//
//  NSObject+ServiceManager.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDefinition.h"
#import "HttpRequestTool.h"
#import "HttpRequestParam.h"

@class HttpRequestService;

/**
 *  NSObject为ServiceManager的扩展
 */
@interface NSObject (ServiceManager)<ServiceManagerDelegate>

/**
 *  快速调用ServiceManager请求
 *
 *  @param type            请求的类型
 *  @param param           请求的字典
 *  @param method          请求的方法
 *  @param userInfo        请求的用户信息
 *
 *  @return serviceID，用于区分不同的接口实例
 */
- (WebServiceID *)makeRequestForType:(WebServiceType)type params:(NSDictionary *)param method:(NSString*)method userInfo:(NSDictionary*)userInfo;

// 和上面方法一样，此外如果URL需要外部组装 suffixUrl作为除基域名之外的URL（拼接的 部分）
- (WebServiceID *)makeRequestForType:(WebServiceType)type params:(NSDictionary *)param method:(NSString*)method userInfo:(NSDictionary*)userInfo suffixUrl:(NSString *)suffixUrl;

// 第三方服务器网络请求
- (WebServiceID *)makeRequestForType:(WebServiceType)type params:(NSDictionary *)param method:(NSString*)method userInfo:(NSDictionary*)userInfo serverUrl:(NSString *)serverUrl otherServiceType:(OtherServiceType)otherServiceType;

/**
 *  快速调用ServiceManager请求
 *  该方法用于请求参数中需要appSign的请求.
 */
- (WebServiceID *)makeRequestNeedAppSignForType:(WebServiceType)type params:(NSDictionary *)param method:(NSString*)method userInfo:(NSDictionary*)userInfo;

@end



