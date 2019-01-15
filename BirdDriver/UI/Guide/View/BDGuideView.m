//
//  BDGuideView.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/7.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDGuideView.h"

@implementation BDGuideView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIImageView *guideImageView = [[UIImageView alloc]init];
    guideImageView.backgroundColor = [UIColor blueColor];
    guideImageView.image = [UIImage imageNamed:@"Guide_background"];
    [self addSubview:guideImageView];
    [guideImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    // 立即体验按钮
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickBtn setImage:[UIImage imageNamed:@"Guide_click_btn"] forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(85);
        make.right.mas_equalTo(-85);
        make.bottom.mas_equalTo(-70*(__gScreenHeight +20)/667 );
        make.height.mas_equalTo(45);
    }];}

#pragma mark - btnClick

- (void)btnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickUseAppRightNow)]) {
        [_delegate didClickUseAppRightNow];
    }
}
@end
