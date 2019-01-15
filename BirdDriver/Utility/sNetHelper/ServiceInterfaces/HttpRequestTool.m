//
//  HttpRequestTool.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "HttpRequestTool.h"
#import "SLServiceConfig.h"

@implementation HttpRequestTool

+ (NSString*)getApiAddressWithParams:(WebServiceType)type params:(NSDictionary*)params {
    NSString* address = nil;
    switch (type){
        // 更新
        case ServiceType_api_check_version:
        {
            address = [NSString stringWithFormat:@"%@app/check_update/",[SLServiceConfig serviceBaseUrl]];
            break;
        }
        // 登录
        case ServiceType_api_login:
        {
            address = [NSString stringWithFormat:@"%@user/login/",[SLServiceConfig serviceBaseUrl]];
            break;
        }
        // 验证码
        case ServiceType_api_sendCode:
        {
            address = [NSString stringWithFormat:@"%@sms/send-code/",[SLServiceConfig serviceBaseUrl]];
            break;
        }
        // 注册
        case ServiceType_api_register:
        {
            address = [NSString stringWithFormat:@"%@user/signup/",[SLServiceConfig serviceBaseUrl]];
            break;
        }
        // 重置密码
        case ServiceType_api_resetPassword:
        {
            address = [NSString stringWithFormat:@"%@user/forgot-password/",[SLServiceConfig serviceBaseUrl]];
            break;
        }
        // 首页
        case ServiceType_api_homePage:
        {
            address = [NSString stringWithFormat:@"%@room/%@/",[SLServiceConfig serviceBaseUrl],[params safeObjectForKey:@"roomID"]];
            break;
        }
        // 图片上传
        case ServiceType_api_uploadPhoto:
        {
            address = [NSString stringWithFormat:@"%@file/upload/",[SLServiceConfig serviceBaseUrl]];
            break;
        }

        default:
        {
            address = [self getApiAddress:type];
            break;
        }
    }
    return address;
}

+ (NSString *)getApiAddress:(WebServiceType)type {
    NSString *address = nil;
    return address;
}

// GET请求的参数拼接
+ (NSString *)addParameters:(NSDictionary *)params toUrlString:(NSString *)url {
    NSMutableString *sRet = [[NSMutableString alloc] initWithString:url];
    for(NSUInteger i=0; i<[params count]; i++){
        NSString *sKey = [params.allKeys objectAtIndex:i];
        NSString *sValue = params[sKey];
        if([sValue isKindOfClass:[NSNumber class]]){
            NSNumber *value = (NSNumber *)sValue;
            sValue = [value stringValue];
        }
        if(i == 0){
            [sRet appendString:@"?"];
        }else{
            [sRet appendString:@"&"];
        }
        [sRet appendFormat:@"%@=%@", sKey, sValue];
    }
    return sRet;
}

+ (NSString*)getRequestUUID:(WebServiceType)serviceType param:(NSDictionary*)param method:(NSString*)method userInfo:(NSDictionary*)userInfo{
    NSString* address = [[self class] getApiAddressWithParams:serviceType params:userInfo];
    if ([method isEqualToString:@"POST"] || [method isEqualToString:@"post"]) {
        return address;
    } else {
        return [self addParameters:param toUrlString:address];
    }
}

//获取基地址
+ (NSString *)getBaseUrl {
    return [SLServiceConfig serviceBaseUrl];
}

/**
 *  加密appSign
 *
 *  @param params 除了appSign的值
 *
 *  @return 添加appSign的值
 */
+ (NSDictionary*)encryptAppSign:(NSDictionary*)params{
    NSArray * array = [params allKeys];
    SEL sel = @selector(compare:);
    array = [array sortedArrayUsingSelector:sel];
    NSMutableString * appSign = [NSMutableString string];
    for (int i = 0; i < array.count ; i++){
        NSString * key = [array objectAtIndex:i];
        NSString * value = [params objectForKey:key];
        [appSign appendFormat:@"%@%@",key,value];
    }
    return params;
}

/**
 *  获取各个接口的返回类型
 *
 *  @param type 接口类型
 *
 *  @return 返回数据的格式
 */
+ (RequestType)getRequestType:(WebServiceType)type {
//    RequestType rt = RequestType_Json;
    RequestType rt = RequestType_Http;
    switch (type) {
        case ServiceType_api_uploadPhoto:
        {
            rt = RequestType_Upload;
            break;
        }
        default:
            break;
    }
    return rt;
}

// 获取请求编码方式
+ (RequestContentEncodingType)getRequestContentEncodingType:(WebServiceType)type {
    RequestContentEncodingType rt = RequestContentEncoding_None;
    if (type == ServiceType_api_complaint ||
        type == ServiceType_api_addSubareaDevice) {
        rt = RequestContentEncoding_gzip;
    }
    return rt;
}
@end



