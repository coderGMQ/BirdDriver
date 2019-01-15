//
//  ServiceManager.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDefinition.h"

/**
 *  接口管理类
 */
@interface ServiceManager : NSObject<ServiceCallbackDelegate>
{
    NSMutableDictionary *_servicesDictionary;
}

+ (ServiceManager *)sharedInstance;

/**
 *  发出一个请求
 *
 *  @param serviceType 请求类型
 *  @param param       请求参数
 *  @param method      请求方法
 *  @param userInfo    用户信息
 *  @param suffixUrl   url后缀 除了根URl之外的部分
 *
 *  @return 返回该请求的标示
 */
- (WebServiceID *)request:(WebServiceType)serviceType param:(NSDictionary*)param method:(NSString*)method userInfo:(NSDictionary *)userInfo delegate:(id<ServiceManagerDelegate>)delegate suffixUrl:(NSString *)suffixUrl;


- (WebServiceID *)request:(WebServiceType)serviceType url:(NSString *)url otherServiceType:(OtherServiceType)otherServiceType param:(NSDictionary*)param method:(NSString*)method userInfo:(NSDictionary *)userInfo delegate:(id<ServiceManagerDelegate>)delegate;

/**
 *  取消请求
 *
 *  @param serviceID 接口的ID
 */
- (void)cancelRequestWithID:(NSString *)serviceID;

@end

