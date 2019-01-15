//
//  AuthorizationHelper.m
//  SmartLife
//
//  Created by han on 2017/3/24.
//
//

#import "AuthorizationHelper.h"
#import <AssetsLibrary/ALAsset.h>
#import "SLAlertView.h"
@import AVFoundation;

@implementation AuthorizationHelper

+ (BOOL)checkPhotoLibraryAuthorizationStatus {
    if ([ALAssetsLibrary respondsToSelector:@selector(authorizationStatus)]) {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (ALAuthorizationStatusDenied == authStatus ||
            ALAuthorizationStatusRestricted == authStatus) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
            return NO;
        }
    }
    return YES;
}

+ (BOOL)checkCameraAuthorizationStatus {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        kTipAlert(@"该设备不支持拍照");
        return NO;
    }
    
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus ||
            AVAuthorizationStatusRestricted == authStatus) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
            return NO;
        }
    }
    
    return YES;
}

+ (BOOL)checkMicAuthorizationStatus {
    __block BOOL bCanRecord = YES;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                bCanRecord = YES;
            }
            else {
                bCanRecord = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showSettingAlertStr:@"检测到麦克风权限未打开 \n请到 设置-隐私-麦克风 启用麦克风"];
                });
            }
        }];
    }
    return bCanRecord;
}

+ (void)showSettingAlertStr:(NSString *)tipStr {
    //iOS8+系统下可跳转到‘设置’页面，否则只弹出提示窗即可
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        
        SLAlertView *alertView = [[SLAlertView alloc] initWithTitle:@"提示" message:tipStr customView:nil textAttArray:@[@[@"取消",@"999999"],@[@"设置",@"4285f4"]] delegate:nil alertViewType:SLAlertViewTitleType];
        alertView.clickBlock = ^(NSInteger clickIndex){
            if (clickIndex == 1) {
                UIApplication *app = [UIApplication sharedApplication];
                NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([app canOpenURL:settingsURL]) {
                    [app openURL:settingsURL];
                }
            }
        };
        [alertView show];
        
    }else{
        kTipAlert(@"%@", tipStr);
    }
}
@end
