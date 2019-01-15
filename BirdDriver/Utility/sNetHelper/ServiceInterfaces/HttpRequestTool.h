//
//  HttpRequestTool.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDefinition.h"

typedef NS_ENUM(NSInteger, RequestType){
    RequestType_Normal,
    RequestType_WebService,
    RequestType_Upload,   //上传文件
    RequestType_Json,     //json方式提交
    RequestType_Http,
};

typedef NS_ENUM(NSInteger, RequestContentEncodingType){
    RequestContentEncoding_None,   // 无任何编码方式
    RequestContentEncoding_gzip,   // gzip压缩
};

@interface HttpRequestTool : NSObject
/**
 *  获取api地址
 *
 *  @param type   请求类型
 *  @param params url附加参数
 *
 *  @return api地址
 */
+ (NSString*)getApiAddressWithParams:(WebServiceType)type params:(NSDictionary*)params;

/**
 *  GET请求的参数拼接
 *
 *  @param params 参数字典
 *  @param url    首URL
 *
 *  @return 拼接完成的请求url
 */
+ (NSString *)addParameters:(NSDictionary *)params toUrlString:(NSString *)url;

+ (NSString*)getRequestUUID:(WebServiceType)serviceType param:(NSDictionary*)param method:(NSString*)method userInfo:(NSDictionary*)userInfo;

/**
 *  加密appSign
 *
 *  @param params 除了appSign的值
 *
 *  @return 添加appSign的值
 */
+ (NSDictionary*)encryptAppSign:(NSDictionary*)params;

//获取请求类型
+ (RequestType)getRequestType:(WebServiceType)type;

// 获取请求编码方式
+ (RequestContentEncodingType)getRequestContentEncodingType:(WebServiceType)type;

//获取基地址
+ (NSString *)getBaseUrl;

@end
