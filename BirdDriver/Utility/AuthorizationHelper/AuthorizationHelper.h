//
  //  AuthorizationHelper.h
//  SmartLife
//
//  Created by han on 2017/3/24.
//
//

#import <Foundation/Foundation.h>

@interface AuthorizationHelper : NSObject

/**
 * 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkPhotoLibraryAuthorizationStatus;

/**
 * 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkCameraAuthorizationStatus;

/**
 * 检查系统"麦克风"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkMicAuthorizationStatus;

@end
