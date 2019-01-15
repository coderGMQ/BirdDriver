//
//  GlobalData.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

// define global variable or data
#import <UIKit/UIKit.h>
#import <Foundation/NSObjCRuntime.h>

#pragma mark - global variable
extern CGFloat __gWidthRatio;        // 屏幕宽度与设计稿(iPhone 6S)(375 points)比例
extern float __gBottomSafeHeight;    // 底部安全高度
extern NSString *__gStyleColor;      // 样式颜色
extern float __gNavigationHeight;    // 导航栏高度
extern CGFloat __gScreenHeight;      // 屏幕高
extern CGFloat __gScreenWidth;       // 屏幕宽
extern float __gStatusBarHeight;     // statusBar高度
extern CGFloat __gSystemVersion;     // 设备系统版本
extern NSString *__zhsqAuthonToken;  // 服务器返回的token,每个请求都要添加(除登录请求)
static NSInteger const __defaultTimeOutTime = 200;                                // 超时

#pragma mark - color
static NSString * const __kSL_Blue_01 = @"4d76fd";
static NSString * const __kSL_Blue_02 = @"4285f4";    /**< RGB:56,172,255 4285f4 突出文字 按钮描边色*/
static NSString * const __kSL_Black = @"000000";   
static NSString * const __kSL_Black_01 = @"333333";   /**< RGB:51,51,51 333333 重要的文字信息*/
static NSString * const __kSL_Black_02 = @"666666";   /**< RGB:102,102,102 666666 普通级别段落信息*/
static NSString * const __kSL_Black_03 = @"999999";   /**< RGB:153,153,153 999999 辅助次要的信息*/
static NSString * const __kSL_Line_01 = @"e6e6e6";    /**< RGB:230,230,230 e6e6e6 分割线 列表分割*/
static NSString * const __kSL_Line_ = @"e3e3e3";    /**< RGB:230,230,230 e6e6e6 分割线 列表分割*/
static NSString * const __kSL_Background = @"f4f4f4"; // f4f4f4 背景色*/
static NSString * const __kSL_Red = @"d7000f";     /**< RGB:251,13,1 ff0d01 退出 删除 错误 严重警告*/
static NSString * const __kSL_Red_01 = @"ff0d01";     /**< RGB:251,13,1 ff0d01 退出 删除 错误 严重警告*/
static NSString * const __kSL_Light_01 = @"ff7301";   /**< RGB:255,115,1  ff7301 音乐电台模块 */
static NSString * const __kSL_White_01 = @"ffffff";   /**< RGB:255,255,255  ffffff 封装的按钮颜色 */
static NSString * const __kSL_Green_01 = @"1cc835";   /**< RGB:28,200,53  1cc835 绿色 空气质量 */
static NSString * const __kSL_Orange_01 = @"fe953d";   /**< RGB:254,149,61  fe953d 橘黄色 空气质量 */
static NSString * const __kSL_Gray_01 = @"d5d5d5";   /**< RGB:213,213,213  d5d5d5 灰色 空气质量 */
static NSString * const __kSL_DarkBlue_01 = @"333649";   /**< RGB:51,54,73  333649 深蓝色 空气质量 */

#pragma mark - text
static NSInteger const __kSL_Text_24 = 24;             /**< ipad主标题*/
static NSInteger const __kSL_Text_22 = 22;             /**< 主标题*/
static NSInteger const __kSL_Text_21 = 21;             /**< 主标题*/
static NSInteger const __kSL_Text_20 = 20;             /**< 主标题*/
static NSInteger const __kSL_Text_19 = 19;             /**< 主标题*/
static NSInteger const __kSL_Text_18 = 18;             /**< 主标题*/
static NSInteger const __kSL_Text_16 = 16;             /**< 副标题*/
static NSInteger const __kSL_Text_15 = 15;             /**< 一般文字*/
static NSInteger const __kSL_Text_14 = 14;             /**< 一般文字 小*/
static NSInteger const __kSL_Text_13 = 13;             /**< 数字辅助文字*/
static NSInteger const __kSL_Text_12 = 12;             /**< 离线/时间备*/
static NSInteger const __kSL_Text_11 = 11;             /**< 离线/时间备*/
static NSInteger const __kSL_Text_10 = 10;             /**< 很小字体*/

#pragma mark - notification name
//static NSString * const __loginSuccessNotification = @"loginSuccessNotification";         // 登录成功
//static NSString * const __logoutNotification = @"logoutNotification";                     // 退出成功
//static NSString * const __selectCurrentRoomNotification = @"selectCurrentRoomNotification";        // 选择当前房间通知


#pragma mark - userDefault key
//static NSString * const __zhsqAuthonTokenUserDefault = @"zhsqAuthonTokenUserDefault";   // 服务器Token
//static NSString * const _lastSuccessLoginPhoneNumUserDefault = @"lastSuccessLoginPhoneNumUserDefault";    // 上次成功登录的手机号

// 通用设备控制器
#warning 添加新的枚举类型 需要在 SLDeviceBean 内instanceWithDic 对应添加上
typedef NS_ENUM(NSInteger,SLFamilyDeviceType) {
    SLFamilyDeviceLRInductor = 1000,                // 红外感应器
    SLFamilyDeviceDoorMagnetInductor = 1001,        // 门磁感应器
    SLFamilyDeviceUrgentButton = 1002,              // 紧急按钮
    SLFamilyDeviceLeakDetector = 1003,              // 漏水检测器
    SLFamilyDeviceGasDetector = 1004,               // 可燃气检测器
    SLFamilyDevicePasswordDoor = 1005,              // 密码门锁
    SLFamilyDeviceSmogDetector = 1006,              // 烟雾检测器
    SLFamilyDeviceDoorbellAcoustoOptic = 1007,      // 门铃声光器
    SLFamilyDeviceSoundAcoustoOpticAlarm = 1008,    // 声光报警器
    SLFamilyDeviceHumitureDetector = 2000,          // 温湿度检测器
    SLFamilyDeviceLightBrightnessDetector = 2001,   // 光强检测器
    SLFamilyDeviceTemperatureDetector = 2002,       // 温度检测器
    SLFamilyDeviceHumidityDetector = 2003,          // 湿度检测器
    SLFamilyDeviceLRForward = 3000,                 // 红外转发器
    SLFamilyDeviceRobotHand = 3001,                 // 机械手
    SLFamilyDeviceSocket = 3002,                    // 插座
    SLFamilyDeviceCurtain = 3003,                   // 窗帘
    SLFamilyDeviceMoveCalculateSocket = 3004,       // 移动计量插座
    SLFamilyDeviceMoveAdjustableCurtain = 3005,     // 移动可调窗帘
    SLFamilyDeviceRadio = 3006,                     // 电台 (梦想之花和炫彩灯虚拟设备)
    SLFamilyDeviceWindowOpener = 3007,              // 推窗器
    SLFamilyDeviceColorLight = 4000,                // 炫彩灯
    SLFamilyDeviceLight = 4001,                     // 照明开关
    SLFamilyDeviceLEDColorLight = 4004,             // LED炫彩灯
    SLFamilyDeviceNoiseDetector = 5000,             // 噪音检测器(梦想之花虚拟设备)
    SLFamilyDeviceDustDetector = 5001,              // 粉尘检测器(梦想之花虚拟设备)
    SLFamilyDeviceVOCDetector = 5002,               // VOC检测器(梦想之花虚拟设备)
    SLFamilyDeviceCO2Detector = 5003,               // CO2检测器(梦想之花虚拟设备)
    SLFamilyDeviceDustDetectorAlone = 5004,         // 粉尘检测器(独立)pm2.5
    SLFamilyDeviceCO2DetectorAlone = 5005,          // CO2检测器(独立)
    SLFamilyDeviceHCHODetectorAlone = 5006,         // 甲醛检测器(独立)
    SLFamilyDeviceCommonLRProjector = 6001,         // 通用红外控制投影仪
    SLFamilyDeviceCommonLRTV = 6002,                // 通用红外控制电视
    SLFamilyDeviceCommonLRAirCondition = 6003,      // 通用红外控制空调
    SLFamilyDeviceCommonLRCleanRobot = 6004,        // 通用红外控制扫地机器人
    SLFamilyDeviceUniversalRemote = 6005,           // 通用红外万能遥控器
    SLFamilyDeviceAirCleaner = 6100,                // 空气净化器
    SLFamilyDeviceMusic = 6101,                     // 音乐主机
    SLFamilyDeviceCentralAirCondition = 6202,       // 中央空调
    SLFamilyDeviceFlowerOfDream = 7000,             // 梦想之花
    SLFamilyDeviceScenePanel = 8000,                // 情景面板
    SLFamilyDeviceCamera = 9000,                    // 摄像头
};

#pragma mark - macro
#define kUserStore [NSUserDefaults standardUserDefaults]
