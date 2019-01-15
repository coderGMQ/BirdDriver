//
//  SLServiceConfig.m
//  SmartLife
//
//  Created by Potter on 2018/7/24.
//

#import "SLServiceConfig.h"
#import "SLShareDefine.h"

//SL_appConfigIdentify SL_appConfigIdentifyValue = SL_appConfigIdentify_smartLife;
SL_DebugModel SL_CurrentDebugModelValue = SL_DebugModel_Release;
NSString* const SL_DebugModelValueUserDefault = @"SL_DebugModelValueUserDefault";

//是否展示设备更多信息
BOOL __showDeviceMoreInfo = NO;
NSString* const SL_ShowDeviceMoreInfoUserDefault = @"SL_ShowDeviceMoreInfoUserDefault";

@implementation SLServiceConfig

+ (SL_DebugModel)currentDebugModel {
#if kServiceDebug
//    return SL_CurrentDebugModelValue;
    return SL_DebugModel_Test;
#else
    return SL_DebugModel_Release;
#endif
}

+ (void)saveCurrentDebugModel:(SL_DebugModel)model {
#if kServiceDebug
    SL_CurrentDebugModelValue = model;
    [[NSUserDefaults standardUserDefaults] setInteger:model forKey:SL_DebugModelValueUserDefault];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    SceneModeSetShareTool(@(model), widgetShareDebugModeUserDefault);
#endif
}

+ (void)configCurrentDebugModel {
#if kServiceDebug
    SL_DebugModel model;
    #if sceneModelWidget
        NSNumber *modelNumber = SceneModeGetShareTool(widgetShareDebugModeUserDefault);
        model = [modelNumber integerValue];
    #else
        model = [[NSUserDefaults standardUserDefaults] integerForKey:SL_DebugModelValueUserDefault];
    #endif
    SL_CurrentDebugModelValue = model;
    
    // 是否展示设备更多信息
    __showDeviceMoreInfo = [[NSUserDefaults standardUserDefaults] boolForKey:SL_ShowDeviceMoreInfoUserDefault];
#endif
    NSDictionary *appConfigDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"appConfig" ofType:@"plist"]];
//    SL_appConfigIdentifyValue = [[appConfigDic objectForKey:@"appIdentify"] integerValue];
}

#pragma mark - 基本URL

+ (NSString *)serviceBaseUrl {
#if kServiceDebug
    SL_DebugModel debugModel = [SLServiceConfig currentDebugModel];
    if (debugModel == SL_DebugModel_Test) {
        return @"http://116.62.162.181:8980/";
    } else {
        return @"http://www.bnzyll.com/";
    }
#else
    return @"http://www.bnzyll.com/";
#endif
}

+ (NSString *)servicePushBaseUrl {
#if kServiceDebug
    SL_DebugModel debugModel = [SLServiceConfig currentDebugModel];
    if (debugModel == SL_DebugModel_Test) {
        return @"wss://push-dev.myiot360.com:48000/push";
    } else {
        return @"wss://push.myiot360.com:48000/push";
    }
#else
    return @"wss://push.myiot360.com:48000/push";
#endif
}

+ (BOOL)isProductionForJpush {
#if kServiceDebug
    SL_DebugModel debugModel = [SLServiceConfig currentDebugModel];
    if (debugModel == SL_DebugModel_Test) {
        return NO;
    } else {
        return YES;
    }
#else
    return YES;
#endif
}

+ (NSString *)serviceH5BaseUrl {
#if kServiceDebug
    SL_DebugModel debugModel = [SLServiceConfig currentDebugModel];
    if (debugModel == SL_DebugModel_Test) {
        return @"http://dev-service.myiot360.com";
    } else {
        return @"http://service.myiot360.com";
    }
#else
    return @"http://service.myiot360.com";
#endif
}

+ (NSString *)isProductionForRobotScan {
#if kServiceDebug
    SL_DebugModel debugModel = [SLServiceConfig currentDebugModel];
    if (debugModel == SL_DebugModel_Test) {
        return @"0";
    } else {
        return @"1";
    }
#else
    return @"1";
#endif
}

+ (void)saveShowDeviceMoreInfo:(BOOL)show {
#if kServiceDebug
    if (__showDeviceMoreInfo != show) {
        __showDeviceMoreInfo = show;
        [[NSUserDefaults standardUserDefaults] setBool:__showDeviceMoreInfo forKey:SL_ShowDeviceMoreInfoUserDefault];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:showDeviceMoreInfoChangeNotification object:nil];
    }
#else
    __showDeviceMoreInfo = NO;
#endif
}

+ (BOOL)showDeviceMoreInfo {
#if kServiceDebug
    return __showDeviceMoreInfo;
#else
    return NO;
#endif
}

+ (NSString *)hmacSha1Secret {
#if kServiceDebug
    SL_DebugModel debugModel = [SLServiceConfig currentDebugModel];
    if (debugModel == SL_DebugModel_Test) {
        return @"=4km30&3xb_w$8nvm#kkpm8#r-a(gzen4(-wuhp1*-he@+e2^j";
    } else {
        return @"08@-l@^vbc6okklz7xvo$2v&7909d)eaki$&%3rhrs_c@p%zbm";
    }
#else
    return @"08@-l@^vbc6okklz7xvo$2v&7909d)eaki$&%3rhrs_c@p%zbm";
#endif
}

+ (NSString *)buglyAppID {
#if kServiceDebug
    SL_DebugModel debugModel = [SLServiceConfig currentDebugModel];
    if (debugModel == SL_DebugModel_Test) {
        #if iPhone
            return @"c6e19801c9";
        #elif iPad
            return @"c14a344928";
        #else
            return @"";
        #endif
    } else {
        #if iPhone
            return @"e21eb6839e";
        #elif iPad
            return @"6ea91f5d59";
        #else
            return @"";
        #endif
    }
#else
    #if iPhone
        return @"e21eb6839e";
    #elif iPad
        return @"6ea91f5d59";
    #else
        return @"";
    #endif
#endif
}

+ (NSString *)baiduMobStatAppID {
#if kServiceDebug
    SL_DebugModel debugModel = [SLServiceConfig currentDebugModel];
    if (debugModel == SL_DebugModel_Test) {
        #if iPhone
            return @"2c15aeeaab";
        #elif iPad
            return @"363ee0c0ad";
        #else
            return @"";
        #endif
    } else {
        #if iPhone
            return @"ec84eba50e";
        #elif iPad
            return @"d767af0fb1";
        #else
            return @"";
        #endif
    }
#else
    #if iPhone
        return @"ec84eba50e";
    #elif iPad
        return @"d767af0fb1";
    #else
        return @"";
    #endif
#endif
}

//+ (SL_appConfigIdentify)appConfigIdentify {
//    return SL_appConfigIdentifyValue;
//}
@end
