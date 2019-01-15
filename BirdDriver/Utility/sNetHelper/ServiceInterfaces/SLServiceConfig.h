//
//  SLServiceConfig.h
//  SmartLife
//
//  Created by Potter on 2018/7/24.
//

#import <Foundation/Foundation.h>

#ifndef __OPTIMIZE__
    #define kServiceDebug 1
#else
    #define kServiceDebug 0
#endif

/**
 定义调试模式
 */
typedef enum : NSUInteger {
    SL_DebugModel_Test,   //测试模式
    SL_DebugModel_Release //发布模式，正式地址
} SL_DebugModel;


static NSString *showDeviceMoreInfoChangeNotification = @"showDeviceMoreInfoChangeNotification";

@interface SLServiceConfig : NSObject

/**
 *  获取当前调试模式
 */
+ (SL_DebugModel)currentDebugModel;

/**
 *  保存当前调试模式
 */
+ (void)saveCurrentDebugModel:(SL_DebugModel)model;

/**
 *  配置当前的调试模式
 *
 */
+ (void)configCurrentDebugModel;

/**
 *  获取当前模式下的服务器基地址
 *
 *  @return 返回服务器基地址
 */
+ (NSString *)serviceBaseUrl;

/**
 *  获取当前模式下的推送服务器基地址
 *
 *  @return 返回服务器基地址
 */
+ (NSString *)servicePushBaseUrl;

/**
 *  Jpush是否是Production环境
 *
 *  @return Jpush是否是Production环境
 */
+ (BOOL)isProductionForJpush;

/**
 *  获取当前模式下的H5服务器基地址
 *
 *  @return 获取当前模式下的H5服务器基地址
 */
+ (NSString *)serviceH5BaseUrl;

/**
 *  机器人扫描是否是Production环境
 *
 *  @return 机器人扫描是否是Production环境
 */
+ (NSString *)isProductionForRobotScan;

/**
 *  保存是否展示设备更多信息，如ID
 */
+ (void)saveShowDeviceMoreInfo:(BOOL)show;

/**
 *  获取是否展示设备更多信息，如ID
 *
 *  @return 是否展示设备更多信息
 */
+ (BOOL)showDeviceMoreInfo;

/**
 *  sha1 secret
 *
 *  @return sha1 secret
 */
+ (NSString *)hmacSha1Secret;

/**
 *  bugly appID
 *
 *  @return bugly appID
 */
+ (NSString *)buglyAppID;

/**
 *  baiduMobStatAppID appID
 *
 *  @return baiduMobStatAppID appID
 */
+ (NSString *)baiduMobStatAppID;
@end
