//
//  SLShareData.m
//  SmartLife
//
//  Created by Potter on 2017/12/29.
//

#import "SLShareData.h"
#import "SLShareDefine.h"

@implementation SLShareData

+ (void)shareAppVersionCode:(NSString *)value
{
    SceneModeSetShareTool(value,widgetShareAppVersionCodeUserDefault);
}

+ (void)shareRoomID:(NSString *)value
{
    SceneModeSetShareTool(value,widgetShareRoomIDUserDefault);
}

+ (void)shareAuthonToken:(NSString *)value
{
    SceneModeSetShareTool(value,widgetShareAuthonTokenUserDefault);
}

+ (void)shareHomeSceneMode:(NSString *)value
{
    SceneModeSetShareTool(value,widgetShareHomeSceneModeUserDefault);
}

@end
