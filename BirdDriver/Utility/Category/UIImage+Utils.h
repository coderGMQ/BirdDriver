//
//  UIImage+Utils.h
//  SmartLife
//
//  Created by han on 2017/4/24.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

+ (UIImage *)sl_imageWithColor:(UIColor *)color;

//修改图片方向
- (UIImage *)changeImageDirectionWithRotation:(UIImageOrientation)orientation;

@end
