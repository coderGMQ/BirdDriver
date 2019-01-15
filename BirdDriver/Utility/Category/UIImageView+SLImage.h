//
//  UIImageView+SLImage.h
//  SmartLife
//
//  Created by Potter on 2017/3/3.
//
//

#import <UIKit/UIKit.h>

@interface UIImageView (SLImage)

// 设置图片 网络图片
- (void)slSetImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;

// 设置图片 本地图片
- (void)slSetImageWithName:(NSString *)name;

@end
