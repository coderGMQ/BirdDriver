//
//  NSObject+ServiceManager.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "NSObject+ServiceManager.h"
#import "ServiceManager.h"
#import <objc/runtime.h>
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

@implementation NSObject (ServiceManager)

// 快速调用ServiceManager请求
- (WebServiceID *)makeRequestForType:(WebServiceType)type params:(NSDictionary *)param method:(NSString*)method userInfo:(NSDictionary*)userInfo{
    if(!userInfo){
        userInfo = @{};
    }
    WebServiceID *sid = [[ServiceManager sharedInstance] request:type param:param method:method userInfo:userInfo delegate:self suffixUrl:nil];
    NSLog(@"Request URL:%@ \n Method:%@",sid,method);
    return sid;
}

// 和上面方法一样,此外如果URL需要外部组装,suffixUrl作为除基域名之外的URL(拼接的部分)
- (WebServiceID *)makeRequestForType:(WebServiceType)type params:(NSDictionary *)param method:(NSString*)method userInfo:(NSDictionary*)userInfo suffixUrl:(NSString *)suffixUrl{
    if(!userInfo){
        userInfo = @{};
    }
    WebServiceID *sid = [[ServiceManager sharedInstance] request:type param:param method:method userInfo:userInfo delegate:self suffixUrl:suffixUrl];
    NSLog(@"Request URL:%@ \n Method:%@",sid,method);
    return sid;
}

// 第三方服务器网络请求
- (WebServiceID *)makeRequestForType:(WebServiceType)type params:(NSDictionary *)param method:(NSString*)method userInfo:(NSDictionary*)userInfo serverUrl:(NSString *)serverUrl otherServiceType:(OtherServiceType)otherServiceType{
    if(!userInfo){
        userInfo = @{};
    }
    WebServiceID *sid = [[ServiceManager sharedInstance] request:type url:serverUrl otherServiceType:otherServiceType param:param method:method userInfo:userInfo delegate:self];
    NSLog(@"Request URL:%@ \n Method:%@",sid,method);
    return sid;
}

// 该方法针对请求参数中需要appSign的请求。
- (WebServiceID *)makeRequestNeedAppSignForType:(WebServiceType)type params:(NSDictionary *)param method:(NSString*)method userInfo:(NSDictionary*)userInfo{
    //param参数中添加一个md5加密的appSign
    [HttpRequestTool encryptAppSign:param];
    return [self makeRequestForType:type params:param method:method userInfo:userInfo];
}

// 失败回调
- (void)service:(WebServiceID *)serviceID requestFailed:(NSError *)error userInfo:(NSDictionary *)userInfo{
}

// 成功回调
- (void)service:(WebServiceID *)serviceID callbackWithData:(id)data userInfo:(NSDictionary *)userInfo{
}

// 失败回调
- (void)service:(WebServiceID *)serviceID sType:(WebServiceType)sType requestFailed:(NSError*)error userInfo:(NSDictionary*)userInfo{
}

// 成功回调
- (void)service:(WebServiceID *)serviceID sType:(WebServiceType)sType callbackWithData:(id)data userInfo:(NSDictionary*)userInfo{
}
@end



