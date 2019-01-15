//
//  NSString+Size.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

+ (CGSize)fitSizeForText:(NSString*)text font:(UIFont*)font;

+ (CGSize)fitSizeForText:(NSString*)text font:(UIFont*)font maxWidth:(CGFloat)maxWidth;

+ (CGSize)fitSizeForText:(NSString*)text font:(UIFont*)font maxHight:(CGFloat)maxHeight;

@end
