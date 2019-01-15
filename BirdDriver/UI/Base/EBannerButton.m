//
//  EBannerButton.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "EBannerButton.h"

@interface EBannerButton()
{
}

@end

@implementation EBannerButton

@synthesize __title;

- (void)dealloc {
  
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)initWithType:(ETBannerButtonType)buttonType
{
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-20)/2, (self.frame.size.height-20)/2, 20, 20)];
    _iconView.userInteractionEnabled = NO;
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconView];
    if (ETBannerButtonBack == buttonType) {
        _iconView.image = [UIImage imageNamed:@"fun_btn_back"];
    }else if(ETBannerButtonWhite == buttonType){
        _iconView.image = [UIImage imageNamed:@"fun_btn_back_white"];
        self.showsTouchWhenHighlighted = YES;
    }else if(ETBannerButtonFinished == buttonType){
        _iconView.image = [UIImage imageNamed:@"fun_btn_done"];
        self.showsTouchWhenHighlighted = YES;
    }else if(ETBannerButtonAdd == buttonType){
        _iconView.image = [UIImage imageNamed:@"fun_ic_add@3x"];
        self.showsTouchWhenHighlighted = YES;
    }
    else if (ETBannerButtonCancel == buttonType) {
        _iconView.image = nil;
        [self setTitle:@"取消" forState:UIControlStateNormal];
        [self onSetProperties];
    }else if (ETBannerButtonOther == buttonType) {
        [self onSetProperties];
    }
}

- (void)onSetProperties
{
    [self setBackgroundImage:[[UIImage imageNamed:@"nav_btn_bg"]
                              stretchableImageWithLeftCapWidth:20 topCapHeight:20] forState:UIControlStateNormal];
    [self setBackgroundImage:[[UIImage imageNamed:@"nav_btn_sel"]
                              stretchableImageWithLeftCapWidth:20 topCapHeight:20] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
}

- (void)setTitle:(NSString *)title
{
    if (title != __title) {
        __title = title;
    }
    [self setTitle:__title forState:UIControlStateNormal];
    [self setTitle:__title forState:UIControlStateHighlighted];
    [self setTitle:__title forState:UIControlStateSelected];
}

@end
