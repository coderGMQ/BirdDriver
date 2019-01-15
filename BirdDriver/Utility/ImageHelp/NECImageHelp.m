//
//  NECImageHelp.m
//  SmartLife
//
//  Created by Potter on 2017/3/21.
//
//

#import "NECImageHelp.h"
#import "UIImage+ImageCompress.h"

@interface NECImageHelp ()
@property (nonatomic,copy) UploadOneImageBlock uploadImageBlock;
@end

@implementation NECImageHelp

//图片上传 －－ 只上传一张图片
- (void)uploadImageWithImage:(UIImage *)image userInfo:(NSDictionary *)userInfo completed:(UploadOneImageBlock)finishBlock {
    self.uploadImageBlock = finishBlock;
    UIImage *newImage = [UIImage compressImage:image compressRatio:0.5];
    NSDictionary *params = [HttpRequestParam paramUploadPhotoWithImageData:newImage userInfo:userInfo];
//    [self makeRequestForType:ServiceType_api_uploadPhoto params:params method:@"POST" userInfo:params];
    NSString *suffixUrl = @"api/upload/android";
    [self makeRequestForType:ServiceType_api_uploadPhoto params:params method:@"POST" userInfo:nil suffixUrl:suffixUrl];
}

// 失败回调
- (void)service:(WebServiceID *)serviceID sType:(WebServiceType)sType requestFailed:(NSError*)error userInfo:(NSDictionary*)userInfo{
    if (sType == ServiceType_api_uploadPhoto)
    {
        NSDictionary *contentUserInfo = [[userInfo safeObjectForKey:@"userInfo"] safeObjectForKey:@"userInfo"];
        if (self.uploadImageBlock) {
            self.uploadImageBlock(nil,error,contentUserInfo);
        }
    }
}

// 成功回调
- (void)service:(WebServiceID *)serviceID sType:(WebServiceType)sType callbackWithData:(NSDictionary *)dic userInfo:(NSDictionary*)userInfo{
    if (sType == ServiceType_api_uploadPhoto) {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSDictionary *contentUserInfo = [userInfo safeObjectForKey:@"userInfo"];
//            NSDictionary *fileDic = [dic safeObjectForKey:@"data"];
             NSArray *fileArray = [dic safeObjectForKey:@"data"];
             NSDictionary *fileDic = [fileArray safeObjectAtIndex:0];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.uploadImageBlock) {
                    self.uploadImageBlock(fileDic,nil,contentUserInfo);
                }
            });
        });
    }
}
@end
