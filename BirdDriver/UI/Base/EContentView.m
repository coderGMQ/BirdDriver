//
//  EContentView.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "EContentView.h"

@implementation EContentView

- (void)dealloc{
    
}

- (void)initContentView {
    self.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
}

- (void)setContentViewToTop:(BOOL)top animation:(BOOL)animation
{
    if (animation) {
        if (top) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = 0;
                frame.size.height = __gScreenHeight;
                self.frame = frame;
            } completion:^(BOOL finished) {
                
            }];
        }else
        {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = __gNavigationHeight;
                frame.size.height = __gScreenHeight-__gNavigationHeight;
                self.frame = frame;
            } completion:^(BOOL finished) {
                
            }];
        }
    }else
    {
        if (top) {
            CGRect frame = self.frame;
            frame.origin.y = 0;
            frame.size.height = __gScreenHeight;
            self.frame = frame;
        }else
        {
            CGRect frame = self.frame;
            frame.origin.y = __gNavigationHeight;
            frame.size.height = __gScreenHeight-__gNavigationHeight;
            self.frame = frame;
        }
    }
}

@end
