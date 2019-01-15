//
//  ServiceDefinition.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//
extern NSString * const kWebServiceGlobal_Cookie;
extern NSString * const kWebServiceGlobal_CookieArray;

/**
 *  接口类型枚举
 */
typedef NS_ENUM(NSInteger, WebServiceType) {

    ServiceType_Invalid,
    ServiceType_api_login,                  // 登录
    ServiceType_api_register,               // 个人注册
    ServiceType_api_sendCode,               // 获取验证码
    ServiceType_api_verifySecurityCode,     // 确认验证码
    ServiceType_api_resetPassword,          // 重置密码
    ServiceType_api_uploadPhoto,            // 图片上传
    ServiceType_api_registerCompany,        // 企业注册



    ServiceType_api_check_version,          // 版本更新
    ServiceType_api_check_auth,             // 检查权限
    ServiceType_api_submitChangePhone,      // 提交更新手机号码
    ServiceType_api_homePage,               // 首页
    ServiceType_api_homePageAlarmUnreadCount, // 首页未读告警个数
    ServiceType_api_homeInfo,               // 首页信息中心
    ServiceType_api_homePageFavCtrlProfiles,// 首页情景模式
    ServiceType_api_weather,                // 首页天气
    ServiceType_api_homeNotice,             // 小区公告
    ServiceType_api_homeNoticeDetail,       // 小区公告详情
    ServiceType_api_unread,                 // 小区公告未读
    ServiceType_api_subareas,               // 房间内区域
    ServiceType_api_subareas_deviceInfo,    // 房间内区域 传感器信息
    ServiceType_api_addSubareas,            // 添加房间内区域
    ServiceType_api_deleteSubareas,         // 删除房间内区域
    ServiceType_api_editSubareas,           // 编辑房间内区域
    ServiceType_api_updateSubareasOrder,    // 编辑房间内设备和情景模式顺序
    ServiceType_api_userProfile,            // 我的基本信息
    ServiceType_api_homeKeeperList,         // 私人管家列表
    ServiceType_api_homeKeeperInteraction,  // 管家互动列表
    ServiceType_api_logout,                 // 登出
    ServiceType_api_roomAllScenes,          // 当前房屋内内所有情景模式
    ServiceType_api_getHomeFavProfiles,     // 获取首页常用情景模式（ipad）
    ServiceType_api_setHomeFavProfiles,     // 设置首页常用情景模式（ipad）
    ServiceType_api_updateCommonSceneOrder, // 更新首页常用情景模式排序（ipad）
    ServiceType_api_allScenes,              // 当前区域内所有情景模式
    ServiceType_api_executeScenes,          // 执行一个情景模式
    ServiceType_api_homeKeeperRate,         // 管家互动服务评价
    ServiceType_api_roomPersons,            // 房屋内的人员
    ServiceType_api_userRooms,              // 用户所有住房信息
    ServiceType_api_roomAllDevice,          // 当前房屋内所有设备
    ServiceType_api_areaAllDevice,          // 某个区域内所有设备
    ServiceType_api_addSubareaDevice,       // 新增区域设备
    ServiceType_api_deleteSubareaDevice,    // 删除区域设备
    ServiceType_api_getFavDevices,          // 获取常用设备(同ipad)
    ServiceType_api_getCtrlDevices,         // 获取可控设备(同ipad)
    ServiceType_api_setFavDevices,         //  设置常用设备(同ipad)
    ServiceType_api_setFavDevicesOrder,    //  设置常用设备排序
    ServiceType_api_rankRemotesDevices,    //  遥控器排序
    ServiceType_api_bulkDeviceState,       // 获取某些设备状态根据设备ID(同ipad)
    ServiceType_api_updateCommonDeviceOrder, // 更新首页常用情景模式排序（ipad）
    ServiceType_api_oneDeviceDetail,        // 某一个设备详情
    ServiceType_api_oneDeviceState,         // 某一个设备状态
    ServiceType_api_areaAllDeviceState,     // 当前区域内所有设备状态
    ServiceType_api_roomAllDeviceState,     // 当前房间内所有设备状态
    ServiceType_api_mineInfo,               // 登录用户信息
    ServiceType_api_updateMineInfo,         // 更新用户信息
    ServiceType_api_homeKeeperRepair,       // 维修报单
    ServiceType_api_homeKeeperHelp,         // 帮忙报单
    ServiceType_api_complaint,              // 提交投诉
    ServiceType_api_praise,                 // 提交表扬
    ServiceType_api_homeKeeperInfo,         // 私人管家基本信息
    ServiceType_api_deviceControl,          // 设备控制
    ServiceType_api_deviceAllChildren,      // 某个设备下内所有设备
    ServiceType_api_roomNewDevice,          // 房间内所有新设备
    ServiceType_api_roomNewDeviceState,     // 房间内所有新设备状态
    ServiceType_api_getDeviceCategories,    // 获取设备分类
    ServiceType_api_editDevice,             // 编辑设备
    ServiceType_api_findDevice,             // 查找设备
    ServiceType_api_roomSubareas,           // 房屋内可选区域
    ServiceType_api_addRoomPerson,          // 添加房屋人员
    ServiceType_api_commonCities,           // 城市列表
    ServiceType_api_commonCityBlocks,       // 社区列表
    ServiceType_api_commonBlockBuildings,   // 楼栋列表
    ServiceType_api_commonBuildingRooms,    // 房屋列表
    ServiceType_api_visitorHistory,         // 访客历史
    ServiceType_api_deleteVisitorHistory,   // 删除访客历史
    ServiceType_api_sendAddRoomSms,         // 添加房屋时发送验证码
    ServiceType_api_addUserRoom,            // 添加房屋
    ServiceType_api_addVisitor,             // 增加访客邀请
    ServiceType_api_addOwnerUserRoom,       // 房主添加房屋
    ServiceType_api_deleteRoomPerson,       // 删除房屋人员
    ServiceType_api_updateRoomPerson,       // 修改房屋人员
    ServiceType_api_detailScene,            // 情景模式详情
    ServiceType_api_addScene,               // 添加一个情景模式
    ServiceType_api_updateScene,            // 修改一个情景模式
    ServiceType_api_armHomePage,            // 安防首页
    ServiceType_api_subareaArm,             // 区域布防
    ServiceType_api_subareaDisarm,          // 区域撤防
    ServiceType_api_awayArm,                // 外出布防
    ServiceType_api_stayArm,                // 在家布防
    ServiceType_api_disarm,                 // 撤防
    ServiceType_api_armRecord,              // 安防记录
    ServiceType_api_moreArmRecord,          // 安防记录更多
    ServiceType_api_armDevice,              // 安防设备详情
    ServiceType_api_robotList,              // 机器人列表
    ServiceType_api_checkIsRobotBound,      // 检查机器人是否绑定
    ServiceType_api_unBindRobot,            // 机器人解除绑定
    ServiceType_api_robotSettings,          // 机器人设置
    ServiceType_api_voice,                  // 语音控制命令
    ServiceType_api_voiceKeywords,          // 热词
    ServiceType_api_deleteScene,            // 删除一个情景模式
    ServiceType_api_getMangerScene,         // 获取管理的情景模式
    ServiceType_api_updateMangerScene,      // 更新管理的情景模式
    ServiceType_api_deviceArm,              // 设备安防
    ServiceType_api_deviceDisarm,           // 设备撤防
    ServiceType_api_getArmSetting,          // 获取安防设置
    ServiceType_api_updateArmSetting,       // 更新安防设置
    ServiceType_api_roomAllLinkages,        // 当前房屋内所有联动
    ServiceType_api_detailLinkage,          // 联动详情
    ServiceType_api_addLinkage,             // 添加联动
    ServiceType_api_updateLinkage,          // 更新联动
    ServiceType_api_deleteLinkage,          // 删除联动
    ServiceType_api_roomAllLocks,           // 当前房屋内所有门锁
    ServiceType_api_operateLinkage,         // 操作联动
    ServiceType_api_energyHomePage,         // 能耗管理首页
    ServiceType_api_energyDeviceState,      // 能耗设备实时功率
    ServiceType_api_deviceEnergyConsumption,// 能耗设备图表数据
    ServiceType_api_energyConsumptionHistorical,// 能耗历史数据
    ServiceType_api_environmentCenterOutdoor,   // 健康中心室外数据
    ServiceType_api_environmentCenterIndoorSubareas,   // 健康中心内部区域
    ServiceType_api_environmentCenterIndoorSubareaData,   // 健康中心内部区域数据
    ServiceType_api_improveEnvironmentCenterIndoorSubareaData,// 一键优化
    ServiceType_api_openEnvironmentCenterIndoorSubareaData,   // 一键开启
    ServiceType_api_getEnvironmentCenterSetting,   // 获取环境中心配置
    ServiceType_api_updateEnvironmentCenterSetting, // 更新环境中心配置
    ServiceType_api_multiControls,          //  多控开关列表
    ServiceType_api_addMultiControl,        //  添加多控
    ServiceType_api_updateMultiControl,     //  更新多控
    ServiceType_api_deleteMultiControl,     //  删除多控
    ServiceType_api_lockUsers,              //  门锁人员列表
    ServiceType_api_updateLockuser,         //  更新门锁人员信息
    ServiceType_api_unlockRecords,          //  开锁历史列表
    ServiceType_api_lockAlarms,             //  报警记录列表
    ServiceType_api_lockPasswordlessSettings,             //  免密开锁状态
    ServiceType_api_updateLockPasswordlessSettings,       //  更新免密开锁状态
    ServiceType_api_lockAlerms,             // 报警记录列表
    ServiceType_api_locks,                  // 门锁列表
    ServiceType_api_setAutoRearrange,       // 房屋是否开启自动排序
    ServiceType_api_setIntelligentPredict,  // 房屋智能预测学习
    ServiceType_api_messageTypeList,        // 消息类型
    ServiceType_api_messageList,            // 消息列表
    ServiceType_api_moreMessageList,        // 消息列表加载更多
    ServiceType_api_cameraList,             // 摄像头列表
    ServiceType_api_YSAccessToken,          // 获取莹石AccessToken
    ServiceType_api_addDevice,              // 添加摄像头
    ServiceType_api_infraredForwarders,     // 红外转发器列表
    ServiceType_api_remotes,                // 红外遥控器列表
    ServiceType_api_getMessageCount,        // 获取消息个数
    ServiceType_api_scanBarCodeLogin,       // 扫码登录设备
    ServiceType_api_confirmBarCodeLogin,    // 确认扫码登录设备
    ServiceType_api_getLoginBarCode,        // 获取扫码登录
    ServiceType_api_getLoginBarCodeState,   // 获取扫码登录状态信息
    ServiceType_api_getPrediction,          // 获取智能预测学习
    ServiceType_api_runPrediction,          // 执行智能预测学习
    ServiceType_api_getCamearCoverStatus,   // 获取摄像头遮蔽状态
    ServiceType_api_setCamearCoverStatus,   // 设置摄像头遮蔽状态
    ServiceType_api_getCommonBlocks,        // 获取常用模块
    ServiceType_api_setCommonBlocks,        // 设置常用模块
    ServiceType_api_getLinkageCapture,      // 获取摄像头联动截图
    ServiceType_api_handoverPermissionSendCode, // 移交权限中的发送验证码
    ServiceType_api_handoverPermissionValidateCode, // 移交权限中的确认验证码
    ServiceType_api_handoverOwnerPermission,    // 移交超管权限
    ServiceType_api_getMessageSettings,         // 获取消息推送开关状态
    ServiceType_api_setMessageSettings,         // 设置消息推送开关状态
    ServiceType_api_setTicket,                  // 设置意见反馈
    ServiceType_api_getSelfPostSplash,          // 获取自投递广告
    ServiceType_api_getStsLogToken,             // 获取log token
    ServiceType_api_getGlobalConfig,            // 获取全局配置
};


/**
 *  三方服务器类型
 */
typedef NS_ENUM(NSInteger, OtherServiceType) {
    OtherService_zydh,         // 智运道合服务器，默认
    OtherService_zhongyi,      // 中一服务器
    OtherService_yishi,        // 萤石服务器
};

typedef NSString WebServiceID;

@protocol ServiceCallbackDelegate <NSObject>

/**
 *  请求回调 - 成功
 *
 *  @param serviceID 接口ID
 *  @param response  服务器响应的数据
 *  @param userInfo  用户信息
 *
 */
- (void)service:(WebServiceID *)serviceID requestFinished:(id)response userInfo:(NSDictionary *)userInfo;

/**
 *  请求回调 - 失败
 *
 *  @param serviceID 接口ID
 *  @param error     错误信息
 */
- (void)service:(WebServiceID *)serviceID requestFailed:(NSError *)error userInfo:(NSDictionary *)userInfo;

@end

@protocol ServiceManagerDelegate <NSObject>
// 成功回调
- (void)service:(WebServiceID *)serviceID sType:(WebServiceType)sType callbackWithData:(id)data userInfo:(NSDictionary *)userInfo;
// 失败回调
- (void)service:(WebServiceID *)serviceID sType:(WebServiceType)sType requestFailed:(NSError *)error userInfo:(NSDictionary *)userInfo;
@end
