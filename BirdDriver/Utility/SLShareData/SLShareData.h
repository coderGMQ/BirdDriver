//
//  SLShareData.h
//  SmartLife
//
//  Created by Potter on 2017/12/29.
//

#import <Foundation/Foundation.h>

@interface SLShareData : NSObject

// 分享版本号
+ (void)shareAppVersionCode:(NSString *)value;

// 分享房屋ID
+ (void)shareRoomID:(NSString *)value;

// 分享authonToken
+ (void)shareAuthonToken:(NSString *)value;

// 分享首页情景模式
+ (void)shareHomeSceneMode:(NSString *)value;

@end
