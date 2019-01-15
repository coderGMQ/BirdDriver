//
//  HttpResponseTool.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDefinition.h"

@interface HttpResponseTool : NSObject

typedef NS_ENUM(NSInteger, ResponseType){
    ResponseType_Html,
    ResponseType_Json,
    ResponseType_Data,
    ResponseType_Xml
};

+ (id)parseResponse:(NSDictionary*)response withType:(WebServiceType)type;
/**
 *  获取各个接口的返回类型是什么
 *
 *  @param type 接口类型
 *
 *  @return 返回数据的格式
 */
+ (ResponseType)getResponseType:(WebServiceType)type;

/**
 *  当遇到错误是否弹出错误提示
 *
 *  @param type 接口类型
 *
 *  @return 返回是否弹出
 */
+ (BOOL)popupToastWhenMeetError:(WebServiceType)type;

@end



