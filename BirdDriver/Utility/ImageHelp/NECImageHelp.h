//
//  NECImageHelp.h
//  SmartLife
//
//  Created by Potter on 2017/3/21.
//
//

#import <Foundation/Foundation.h>

typedef void (^UploadOneImageBlock)(NSDictionary * fileDic,NSError * error,NSDictionary *userInfo);

@interface NECImageHelp : NSObject

//图片上传 －－ 只上传一张图片
- (void)uploadImageWithImage:(UIImage *)image userInfo:(NSDictionary *)userInfo completed:(UploadOneImageBlock)finishBlock;
@end
