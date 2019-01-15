//
//  ServiceManager.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "ServiceManager.h"
#import "HttpRequestService.h"
#import "HttpRequestTool.h"
#import "HttpResponseTool.h"
#import "iToast.h"
//#import <Bugly/Bugly.h>
#import "NSDate+Category.h"
//#import "SLLog.h"
#import "EmoreTool.h"
//#import "AppDelegatePad.h"
//#if iPhone
//    #import "SLAppManager.h"
//#else
//    #import "SLPadAppManager.h"
//#endif


NSString * const kWebServiceGlobal_Cookie = @"Cookie";                    //设置cookie
NSString * const kWebServiceGlobal_CookieArray = @"CookieArray";          //设置cookie 数组

@implementation ServiceManager

+ (ServiceManager *)sharedInstance {
    static ServiceManager *instance = nil;
    if(!instance){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[ServiceManager alloc] init];
        });
    }
    return instance;
}

- (id)init {
    self = [super init];
    if(self){
        _servicesDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return self;
}


+ (NSString *)getUUID
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref = CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

// 发出一个请求
- (WebServiceID *)request:(WebServiceType)serviceType param:(NSDictionary*)param method:(NSString*)method userInfo:(NSDictionary *)userInfo delegate:(id<ServiceManagerDelegate>)delegate suffixUrl:(NSString *)suffixUrl{
    NSString *serviceID = nil;
    NSString *requestUrl = nil;
    if (suffixUrl) {
        requestUrl = [[HttpRequestTool getBaseUrl] stringByAppendingString:suffixUrl];
    } else {
        requestUrl = [HttpRequestTool getRequestUUID:serviceType param:param method:method userInfo:userInfo];
    }
    serviceID = [NSString stringWithFormat:@"%@_%@",requestUrl,[[self class] getUUID]];
    HttpRequestService *service = [[HttpRequestService alloc] initWithServiceType:serviceType param:param delegate:self userInfo:userInfo];
    service.uuid = serviceID;
    service.requestUrl = requestUrl;
    service.managerDelegate = delegate;
    service.reqTime = [NSDate currentTimeDescription];
    service.reqMethod = method;
    @synchronized (_servicesDictionary) {
        [_servicesDictionary safeSetObject:service forKey:service.uuid];
    }
    [service startRequest:method];
    return service.requestUrl;
}

// 发出一个第三方的请求
- (WebServiceID *)request:(WebServiceType)serviceType url:(NSString *)url otherServiceType:(OtherServiceType)otherServiceType param:(NSDictionary*)param method:(NSString*)method userInfo:(NSDictionary *)userInfo delegate:(id<ServiceManagerDelegate>)delegate {
    NSString *serviceID = nil;
    NSString *requestUrl = url;
    serviceID = [NSString stringWithFormat:@"%@_%@",requestUrl,[[self class] getUUID]];
    HttpRequestService *service = [[HttpRequestService alloc] initWithServiceType:serviceType param:param delegate:self userInfo:userInfo];
    service.otherServiceType = otherServiceType;
    service.uuid = serviceID;
    service.requestUrl = requestUrl;
    service.managerDelegate = delegate;
    @synchronized (_servicesDictionary) {
        [_servicesDictionary safeSetObject:service forKey:service.uuid];
    }
    [service start3rdServerRequest:method];
    return service.requestUrl;
}

// 取消请求
- (void)cancelRequestWithID:(NSString *)serviceID{
    if(!serviceID){
        return;
    }
    HttpRequestService *service = _servicesDictionary[serviceID];
    if(!service){
        return;   
    }
    @synchronized (_servicesDictionary) {
        [_servicesDictionary safeRemoveObjectForKey:serviceID];
    }
}

#pragma mark - ServiceDelegate

//  回调成功
- (void)service:(WebServiceID *)serviceID requestFinished:(id)response userInfo:(NSDictionary *)userInfo{
    
    NSDictionary *userInfos = nil;
    NSString *errMessage = @"服务器错误";
    NSInteger statusCode = -1;

    HttpRequestService *service = _servicesDictionary[serviceID];
    ResponseType rt = ResponseType_Json;
    if ([service isKindOfClass:[HttpRequestService class]]) {
        rt = [HttpResponseTool getResponseType:service.serviceType];
    }
    
    if(serviceID){
        NSString *dataJson = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        // 记录日志
//        [self logWithService:service responseData:dataJson];
        
        if (dataJson && dataJson.length>0) {// response有值
            response = [NSJSONSerialization JSONObjectWithData:[dataJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            BOOL success = [[response safeValueForKey:@"success"] boolValue];// 用此判断请求是否成功
            if (service.otherServiceType == OtherService_yishi) {// 萤石的服务器
                NSInteger code = [[response safeObjectForKey:@"code"] integerValue];
                if (response && code == 200) {
                    statusCode = 1000;
                    userInfos = @{@"ServiceID": serviceID,
                                  @"Response": response,
                                  @"userInfo":userInfo};
                }else {
                    statusCode = code;
                    NSString *message = [response safeObjectForKey:@"msg"];
                    if (message && [message isKindOfClass:[NSString class]] && message.length>0) {
                        errMessage = message;
                    }
                    NSError *error = [[NSError alloc] initWithDomain:errMessage code:statusCode userInfo:nil];
                    userInfos = @{ @"ServiceID":serviceID,@"Error":error,@"userInfo":userInfo};
                }
            } else {// 其他服务器
                if (success) {
                    userInfos = @{@"ServiceID": serviceID,
                                  @"Response": response,
                                  @"userInfo":userInfo};
                } else {
                    NSString *message = [response safeObjectForKey:@"msg"];
                    if (message && [message isKindOfClass:[NSString class]] && message.length>0) {
                        errMessage = message;
                    }
                    NSError *error = [[NSError alloc] initWithDomain:errMessage code:statusCode userInfo:response];
                    userInfos = @{ @"ServiceID":serviceID,
                                   @"Error":error,
                                   @"userInfo":userInfo};
                }
            }
            
            
            // 代理回调出去，在外面进行相关数据解析
            if(success){
                NSString *msg = [response safeObjectForKey:@"msg"];
                if (msg && [msg isKindOfClass:[NSString class]] && msg.length>0) {
                    [[[iToast makeText:msg] setGravity:iToastGravityCenter] show];
                }
                if (service.managerDelegate && [service.managerDelegate respondsToSelector:@selector(service:sType:callbackWithData:userInfo:)]) {
                    [service.managerDelegate service:userInfos[@"ServiceID"] sType:service.serviceType callbackWithData:userInfos[@"Response"] userInfo:userInfos[@"userInfo"]];
                }
            } else {
                BOOL needToast = [HttpResponseTool popupToastWhenMeetError:service.serviceType];
                if (needToast) {
                    [[[iToast makeText:errMessage] setGravity:iToastGravityCenter] show];
                }
                if (service.managerDelegate && [service.managerDelegate respondsToSelector:@selector(service:sType:requestFailed:userInfo:)]) {
                    [service.managerDelegate service:userInfos[@"ServiceID"] sType:service.serviceType  requestFailed:userInfos[@"Error"] userInfo:userInfos[@"userInfo"]];
                }
                //            [Bugly reportError:userInfos[@"Error"]];
            }
            @synchronized (_servicesDictionary) {
                [_servicesDictionary safeRemoveObjectForKey:serviceID];
            }
        }else {// response 没有值
            response = nil;
            errMessage = @"response is null";
            NSLog(@"response is %@",response);
            NSError *error = [[NSError alloc] initWithDomain:errMessage code:statusCode userInfo:nil];
            userInfos = @{ @"ServiceID":serviceID,
                           @"Error":error,
                           @"userInfo":userInfo};
        }
    }
}

// 回调失败
- (void)service:(NSString *)serviceID requestFailed:(NSError*)error userInfo:(NSDictionary *)userInfo{
    NSDictionary *userInfos = @{@"ServiceID":serviceID,@"Error":error,@"userInfo":userInfo};
    HttpRequestService *service = _servicesDictionary[serviceID];
    BOOL needToast = [HttpResponseTool popupToastWhenMeetError:service.serviceType];
    if (needToast) {
        NSString *errorMessage = [error.userInfo safeObjectForKey:@"NSLocalizedDescription"];
        if (error.code == -1001) {
            errorMessage = @"请求超时";
        } else if (error.code == -1009) {
            errorMessage = @"网络连接异常，请检查网络后重试";
        }
        if (!errorMessage) {
            errorMessage = @"网络错误,请重试";
        }
        [[[iToast makeText:errorMessage] setGravity:iToastGravityCenter] show];
    }
//    [Bugly reportError:error];
//    [self logWithService:service responseData:error.description];
    if (service.managerDelegate && [service.managerDelegate respondsToSelector:@selector(service:sType:requestFailed:userInfo:)]) {
        [service.managerDelegate service:userInfos[@"ServiceID"] sType:service.serviceType  requestFailed:userInfos[@"Error"] userInfo:userInfos];
    }
    @synchronized (_servicesDictionary) {
        [_servicesDictionary safeRemoveObjectForKey:serviceID];
    }
}
@end
