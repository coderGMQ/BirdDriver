//
//  HttpRequestService.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDefinition.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLRequestSerialization.h"
/**
 *  Http请求的接口类
 
 不建议直接作为请求使用，使用ServiceManager进行管理请求
 */
@interface HttpRequestService : NSObject{
    AFHTTPRequestOperation* requestOperation;
}

@property (nonatomic,strong) NSString *uuid; // 作为接口唯一标识
@property (nonatomic,strong) NSString *requestUrl; // 请求的url
@property (nonatomic,assign) WebServiceType serviceType;                  // 业务请求的类型,用于区分不同请求
@property (nonatomic,assign) OtherServiceType otherServiceType;           // 三方服务器类型
@property (nonatomic,weak) id <ServiceCallbackDelegate> delegate;
@property (nonatomic,weak) id <ServiceManagerDelegate> managerDelegate;
@property (nonatomic,strong) NSString *reqTime; // 发起请求时间
@property (nonatomic,strong) NSString *reqMethod; // 发起请求的方法

- (id)initWithServiceType:(WebServiceType)serviceType param:(NSDictionary*)param delegate:(id<ServiceCallbackDelegate>)delegate userInfo:(NSDictionary*)userInfo;

/**
 *  发送请求 GET
 */
- (void)startRequest:(NSString*)method;

- (void)start3rdServerRequest:(NSString*)method;

/**
 *  取消请求
 */
- (void)stop;

@end

