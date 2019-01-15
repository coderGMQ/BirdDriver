//
//  HttpResponseTool.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "HttpResponseTool.h"

@implementation HttpResponseTool

+ (id)parseResponse:(NSDictionary *)response withType:(WebServiceType)type {
    id ret = nil;
    switch (type) {
        default:
            ret = response;
            break;
    }
    return ret;
}

+ (ResponseType)getResponseType:(WebServiceType)type {
    ResponseType rt = ResponseType_Json;
    switch (type) {
        default:
            rt = ResponseType_Json;
            break;
    }
    return rt;
}

+ (BOOL)popupToastWhenMeetError:(WebServiceType)type {
    BOOL result = YES;
    switch (type) {
        case ServiceType_api_homeInfo:
        case ServiceType_api_check_auth:
        case ServiceType_api_unread:
        case ServiceType_api_checkIsRobotBound:
        case ServiceType_api_voice:
        case ServiceType_api_getCamearCoverStatus:
        case ServiceType_api_setCamearCoverStatus:
        case ServiceType_api_getGlobalConfig:
        case ServiceType_api_getStsLogToken:
        case ServiceType_api_getPrediction:
        case ServiceType_api_getSelfPostSplash:
        case ServiceType_api_getLoginBarCodeState:{
            result = NO;
            break;
        }
        default: {
            result = YES;
            break;
        }
    }
    return result;
}

@end
