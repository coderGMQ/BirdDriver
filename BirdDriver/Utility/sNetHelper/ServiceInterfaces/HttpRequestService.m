//
//  HttpRequestService.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "HttpRequestService.h"
#import "HttpRequestTool.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSData+GZIP.h"
#import "UIDeviceInfo.h"

@interface HttpRequestService ()
- (void)start;
@property (nonatomic,strong) NSDictionary *param;
@property (nonatomic,strong) NSDictionary *userInfo;
@end

@implementation HttpRequestService

- (void)dealloc{
    [self stop];
    requestOperation = nil;
}
//
- (id)initWithServiceType:(WebServiceType)serviceType param:(NSDictionary*)param delegate:(id<ServiceCallbackDelegate>)delegate userInfo:(NSDictionary*)userInfo{
    if(self = [super init]){
        self.param = param;
        self.delegate = delegate;
        self.serviceType = serviceType;
        self.userInfo  = userInfo;
    }
    return self;
}

- (void)startRequest:(NSString*)method{
    RequestType requestType = [HttpRequestTool getRequestType:self.serviceType];
    if (requestType == RequestType_Normal) {//正常请求
        AFHTTPRequestSerializer* requestSerializer = [AFHTTPRequestSerializer serializer];
        NSMutableURLRequest *request = nil;
        request = [requestSerializer requestWithMethod:method URLString:[HttpRequestTool getApiAddressWithParams:self.serviceType params:_userInfo] parameters:_param error:nil];
        request.timeoutInterval = __defaultTimeOutTime;
        //请求头部加上UserAgent
#if iPhone
        [requestSerializer setValue:@"ios" forHTTPHeaderField:@"X-ZHSQ-PLATFORM"];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
#else
        [requestSerializer setValue:@"ipad" forHTTPHeaderField:@"X-ZHSQ-PLATFORM"];
#endif
        [requestSerializer setValue:[UIDeviceInfo deviceModel] forHTTPHeaderField:@"X-ZHSQ-PHONE-MODEL"];
        [requestSerializer setValue:[UIDeviceInfo systemVersion] forHTTPHeaderField:@"X-ZHSQ-PHONE-OS-VERSION"];
        [requestSerializer setValue:[UIDeviceInfo appVersion] forHTTPHeaderField:@"X-ZHSQ-VERSION"];
        [requestSerializer setValue:@"" forHTTPHeaderField:@"User-Agent"];
        //设置cookie
        NSString * cookieStr = [self.userInfo objectForKey:kWebServiceGlobal_Cookie];
        if (cookieStr && cookieStr.length>0) {
            [requestSerializer setValue:cookieStr forHTTPHeaderField:@"Cookie"];
        }
        NSArray * cookieArray = [self.userInfo objectForKey:kWebServiceGlobal_CookieArray];
        if (cookieArray && cookieArray.count>0) {
            NSString * urlStr = [NSString stringWithString:self.uuid];
            urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookieArray forURL:[NSURL URLWithString:urlStr] mainDocumentURL:nil];
        }

        requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        __weak __typeof(self)weakSelf = self;
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;

            if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFinished:userInfo:)]){
                [strongSelf.delegate service:strongSelf.uuid requestFinished:responseObject userInfo:strongSelf.userInfo];
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFailed:userInfo:)]){
                [strongSelf.delegate service:strongSelf.uuid requestFailed:error userInfo:strongSelf.userInfo];
            }
        }];
        [self start];
    } else if (requestType == RequestType_WebService){ // webService
        NSString * urlStr = [NSString stringWithString:self.uuid];
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        __weak __typeof(self)weakSelf = self;
        AFHTTPResponseSerializer * reponseSerializer = [AFHTTPResponseSerializer serializer];
        reponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/xhtml+xml",@"text/html", nil];
        //设置cookie
        NSArray * cookieArray = [self.userInfo objectForKey:kWebServiceGlobal_Cookie];
        if (cookieArray && cookieArray.count>0) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookieArray forURL:[NSURL URLWithString:urlStr] mainDocumentURL:nil];
        }

        float system = [[UIDevice currentDevice].systemVersion floatValue];
        if (system>=7.0) {
            AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
            manager.responseSerializer = reponseSerializer;

            [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFinished:userInfo:)]){
                    [strongSelf.delegate service:strongSelf.uuid requestFinished:responseObject userInfo:strongSelf.userInfo];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFailed:userInfo:)]){
                    [strongSelf.delegate service:strongSelf.uuid requestFailed:error userInfo:strongSelf.userInfo];
                }
            }];
        }//7.0以上
        else {
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = reponseSerializer;
            [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFinished:userInfo:)]){
                    [strongSelf.delegate service:strongSelf.uuid requestFinished:responseObject userInfo:strongSelf.userInfo];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFailed:userInfo:)]){
                    [strongSelf.delegate service:strongSelf.uuid requestFailed:error userInfo:strongSelf.userInfo];
                }
            }];
        }//6.0

    } else if (requestType == RequestType_Upload) {// 上传文件
        UIImage * image = [self.param objectForKey:@"imgFile"];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.4);
//        NSString * urlStr = [HttpRequestTool getApiAddressWithParams:self.serviceType params:_userInfo];
        NSString * urlStr = [NSString stringWithString:self.requestUrl];// 加的
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager * manger = [[AFHTTPRequestOperationManager alloc] init];
        AFHTTPResponseSerializer * response = [AFHTTPResponseSerializer serializer];
        response.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"text/plain",@"application/json", nil];
        manger.responseSerializer = response;
        AFJSONRequestSerializer* requestSerializer = [AFJSONRequestSerializer serializer];
#if iPhone
        [requestSerializer setValue:@"ios" forHTTPHeaderField:@"X-ZHSQ-PLATFORM"];
#else
        [requestSerializer setValue:@"ipad" forHTTPHeaderField:@"X-ZHSQ-PLATFORM"];
#endif
        [requestSerializer setValue:[UIDeviceInfo deviceModel] forHTTPHeaderField:@"X-ZHSQ-PHONE-MODEL"];
        [requestSerializer setValue:[UIDeviceInfo systemVersion] forHTTPHeaderField:@"X-ZHSQ-PHONE-OS-VERSION"];
        [requestSerializer setValue:[UIDeviceInfo appVersion] forHTTPHeaderField:@"X-ZHSQ-VERSION"];
        [requestSerializer setValue:@"" forHTTPHeaderField:@"User-Agent"];
        manger.requestSerializer = requestSerializer;
        __weak __typeof(self)weakSelf = self;
        [manger POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            [formData appendPartWithFileData:imageData name:@"file" fileName:@"11.jpg" mimeType:@"image/jpeg"];
            [formData appendPartWithFileData:imageData name:@"imgFile" fileName:@"11.jpg" mimeType:@"image/jpeg"];// 加的
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFinished:userInfo:)]){
                [strongSelf.delegate service:strongSelf.uuid requestFinished:responseObject userInfo:strongSelf.userInfo];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFailed:userInfo:)]){
                [strongSelf.delegate service:strongSelf.uuid requestFailed:error userInfo:strongSelf.userInfo];
            }
        }];
    } else if (requestType == RequestType_Json) {// 以json方式提交
        RequestContentEncodingType contentEncodingType = [HttpRequestTool getRequestContentEncodingType:self.serviceType];

        AFJSONRequestSerializer* requestSerializer = [AFJSONRequestSerializer serializer];
        AFHTTPResponseSerializer * reponseSerializer = [AFHTTPResponseSerializer serializer];
        reponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/xhtml+xml",@"text/html", nil];
        //请求头部加上UserAgent
#if iPhone
        [requestSerializer setValue:@"ios" forHTTPHeaderField:@"X-ZHSQ-PLATFORM"];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
#else
        [requestSerializer setValue:@"ipad" forHTTPHeaderField:@"X-ZHSQ-PLATFORM"];
#endif
        [requestSerializer setValue:[UIDeviceInfo deviceModel] forHTTPHeaderField:@"X-ZHSQ-PHONE-MODEL"];
        [requestSerializer setValue:[UIDeviceInfo systemVersion] forHTTPHeaderField:@"X-ZHSQ-PHONE-OS-VERSION"];
        [requestSerializer setValue:[UIDeviceInfo appVersion] forHTTPHeaderField:@"X-ZHSQ-VERSION"];
        [requestSerializer setValue:@"" forHTTPHeaderField:@"User-Agent"];
        if (contentEncodingType == RequestContentEncoding_gzip) {
            [requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        }
        NSMutableURLRequest *request = nil;
        if (!self.requestUrl) {
            self.requestUrl = [HttpRequestTool getApiAddressWithParams:self.serviceType params:_userInfo];
        }
        request = [requestSerializer requestWithMethod:method URLString:self.requestUrl parameters:_param error:nil];
        request.timeoutInterval = __defaultTimeOutTime;

        // 压缩上传
        if (contentEncodingType == RequestContentEncoding_gzip) {
            NSData *data = request.HTTPBody;
            NSData *zipData = [data gzippedData];
            [request setHTTPBody:zipData];
        }

        //设置cookie
        NSString * cookieStr = [self.userInfo objectForKey:kWebServiceGlobal_Cookie];
        if (cookieStr && cookieStr.length>0) {
            [requestSerializer setValue:cookieStr forHTTPHeaderField:@"Cookie"];
        }
        requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        __weak __typeof(self)weakSelf = self;
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;

            if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFinished:userInfo:)]){
                [strongSelf.delegate service:strongSelf.uuid requestFinished:responseObject userInfo:strongSelf.userInfo];
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFailed:userInfo:)]){
                [strongSelf.delegate service:strongSelf.uuid requestFailed:error userInfo:strongSelf.userInfo];
            }
        }];
        [self start];
    } else if (requestType == RequestType_Http){
        NSString * urlStr = [NSString stringWithString:self.requestUrl];
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        __weak __typeof(self)weakSelf = self;
        AFHTTPResponseSerializer * reponseSerializer = [AFHTTPResponseSerializer serializer];
        reponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-www-form-urlencoded",@"application/json", nil];
        
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        manager.responseSerializer = reponseSerializer;
        
        if ([method isEqualToString:@"POST"]) {
            [manager POST:urlStr parameters:_param success:^(NSURLSessionDataTask *task, id responseObject) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFinished:userInfo:)]){
                    [strongSelf.delegate service:strongSelf.uuid requestFinished:responseObject userInfo:strongSelf.userInfo];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFailed:userInfo:)]){
                    [strongSelf.delegate service:strongSelf.uuid requestFailed:error userInfo:strongSelf.userInfo];
                }
            }];
        } else if ([method isEqualToString:@"GET"]) {
            [manager GET:urlStr parameters:_param success:^(NSURLSessionDataTask *task, id responseObject) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFinished:userInfo:)]){
                    [strongSelf.delegate service:strongSelf.uuid requestFinished:responseObject userInfo:strongSelf.userInfo];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFailed:userInfo:)]){
                    [strongSelf.delegate service:strongSelf.uuid requestFailed:error userInfo:strongSelf.userInfo];
                }
            }];
        }
    }
}

- (void)start3rdServerRequest:(NSString*)method {
    NSString * urlStr = [NSString stringWithString:self.requestUrl];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    __weak __typeof(self)weakSelf = self;
    AFHTTPResponseSerializer * reponseSerializer = [AFHTTPResponseSerializer serializer];
    reponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-www-form-urlencoded",@"application/json", nil];

    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = reponseSerializer;

    [manager POST:urlStr parameters:_param success:^(NSURLSessionDataTask *task, id responseObject) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFinished:userInfo:)]){
            [strongSelf.delegate service:strongSelf.uuid requestFinished:responseObject userInfo:strongSelf.userInfo];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(service:requestFailed:userInfo:)]){
            [strongSelf.delegate service:strongSelf.uuid requestFailed:error userInfo:strongSelf.userInfo];
        }
    }];
}

#pragma mark - Private

- (void)start {
    if (requestOperation) {
        [requestOperation start];
    }
}

- (void)stop {
    if (requestOperation) {
        [requestOperation setCompletionBlockWithSuccess:NULL failure:NULL];
        if(requestOperation.isExecuting){
            [requestOperation cancel];
        }
    }
}
@end
