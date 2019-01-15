//
//  SLShareDefine.h
//  SmartLife
//
//  Created by Potter on 2017/12/29.
//

#ifndef SLShareDefine_h
#define SLShareDefine_h

/* 共享组ID*/
static NSString *__sceneModeShareDataGroupID = @"group.com.zywulian.smartlife.sceneModeWidget";

#define SceneModeSetShareTool(value,key) NSUserDefaults *shareTool = [[NSUserDefaults alloc] initWithSuiteName:__sceneModeShareDataGroupID]; [shareTool setObject:value forKey:key]; [shareTool synchronize];

#define SceneModeGetShareTool(key) [[[NSUserDefaults alloc] initWithSuiteName:__sceneModeShareDataGroupID] objectForKey:key];


#pragma mark 具体存储的Key

// App version code
static NSString *widgetShareAppVersionCodeUserDefault = @"widgetShareAppVersionCodeUserDefault";

// 当前房屋ID
static NSString *widgetShareRoomIDUserDefault = @"widgetShareRoomIDUserDefault";

// 登录的authonToken
static NSString *widgetShareAuthonTokenUserDefault = @"widgetShareAuthonTokenUserDefault";

// 首页情景模式
static NSString *widgetShareHomeSceneModeUserDefault = @"widgetShareHomeSceneModeUserDefault";




#endif /* SLShareDefine_h */
