//
//  NSString+Size.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//
#import "NSString+Size.h"

#define kUnknownWidth   16777215.0f
// the value to use if the height is unknown
#define kUnknownHeight  16777215.0f

@implementation NSString (Size)

+ (CGSize)fitSizeForText:(NSString*)text font:(UIFont*)font {
    return [self fitSizeForText:text font:font maxWidth:kUnknownWidth maxHight:kUnknownHeight];
}

+ (CGSize)fitSizeForText:(NSString*)text font:(UIFont*)font maxWidth:(CGFloat)maxWidth {
    return [self fitSizeForText:text font:font maxWidth:maxWidth maxHight:kUnknownHeight];
}

+ (CGSize)fitSizeForText:(NSString*)text font:(UIFont*)font maxHight:(CGFloat)maxHeight {
    return [self fitSizeForText:text font:font maxWidth:kUnknownWidth maxHight:maxHeight];
}

+ (CGSize)fitSizeForText:(NSString*)text font:(UIFont*)font maxWidth:(CGFloat)maxWidth maxHight:(CGFloat)maxHeight {
    if (__gSystemVersion>=7.0) {
        return [text boundingRectWithSize:CGSizeMake(maxWidth,maxHeight)
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{NSFontAttributeName:font}
                                  context:nil].size;
    }else
    {
        NSDictionary *attr = @{NSFontAttributeName: font};
        NSAttributedString *astr = [[NSAttributedString alloc] initWithString:text attributes:attr];
        return [astr boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    }
}

@end
