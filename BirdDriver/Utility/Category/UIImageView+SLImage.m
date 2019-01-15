//
//  UIImageView+SLImage.m
//  SmartLife
//
//  Created by Potter on 2017/3/3.
//
//

#import "UIImageView+SLImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (SLImage)

// 设置图片
- (void)slSetImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder {
    if (url && [url isKindOfClass:[NSString class]] && url.length>0) {
        if ([url hasPrefix:@"http"]) {  // 网络图片
            [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
        } else {
            [self slSetImageWithName:url];
        }
    } else if(placeholder) {
        self.image = placeholder;
    } else {
        self.image = nil;
    }
}

// 设置图片
- (void)slSetImageWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    if (image) {
        self.image = image;
    } else {
        self.image = [UIImage imageNamed:@"AppIcon60x60"];
    }
}


@end
