//
//  ENavigationView.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "ENavigationView.h"

@interface ENavigationView (){
    
}

@property (nonatomic, strong) UIImageView *ivBg;

@end

@implementation ENavigationView

- (void)dealloc {

}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) { 
    }
    return self;
}

- (void)initNavgationView {
    self.frame = CGRectMake(0, 0, __gScreenWidth, __gNavigationHeight+__gStatusBarHeight);
    self.backgroundColor = [UIColor hexChangeFloat:__gStyleColor];
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, __gStatusBarHeight, __gScreenWidth, __gNavigationHeight)];
        [self addSubview:_contentView];
    }
}

- (void)setNaviBgHidden:(BOOL)hidden {
    self.ivBg.hidden = hidden;
    _line.hidden = hidden;
}

- (void)setNavigationHidden:(BOOL)hidden animation:(BOOL)animation {
    CGFloat barHeight = __gStatusBarHeight;
    if (animation) {
        if (hidden) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = -barHeight - __gNavigationHeight;
                self.frame = frame;
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
            }];
        }else {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = -barHeight;
                self.frame = frame;
                self.alpha = 1.0f;
            } completion:^(BOOL finished) {
            }];
        }
    }else {
        if (hidden) {
            CGRect frame = self.frame;
            frame.origin.y = -barHeight - __gNavigationHeight;
            self.frame = frame;
            self.alpha = 0.0f;
        } else {
            CGRect frame = self.frame;
            frame.origin.y = -barHeight;
            self.frame = frame;
            self.alpha = 1.0f;
        }
    }
}

- (void)setNavLineHidden:(BOOL)hidden {
    _line.hidden = hidden;
}
@end
