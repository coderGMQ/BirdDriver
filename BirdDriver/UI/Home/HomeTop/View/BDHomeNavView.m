//
//  BDHomeNavView.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/8.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDHomeNavView.h"

@interface BDHomeNavView ()
@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UIButton *serviceBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@end

@implementation BDHomeNavView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initData];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    
    // 定位
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locationBtn setTitle:@"南京" forState:UIControlStateNormal];
    [_locationBtn setImage:[UIImage imageNamed:@"home_top_location"] forState:UIControlStateNormal];
    _locationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:__kSL_Text_13];
    [_locationBtn setTitleColor:[UIColor hexChangeFloat:__kSL_Blue_02] forState:UIControlStateNormal];
    [_locationBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_locationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [self addSubview:_locationBtn];
    [_locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(7);
        make.width.mas_equalTo(58);
        make.height.mas_equalTo(30);
    }];
    
    // 客服
    _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_serviceBtn setTitle:@"客服" forState:UIControlStateNormal];
    [_serviceBtn setImage:[UIImage imageNamed:@"home_top_service"] forState:UIControlStateNormal];
    _serviceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:__kSL_Text_13];
    [_serviceBtn setTitleColor:[UIColor hexChangeFloat:__kSL_Blue_02] forState:UIControlStateNormal];
    [_serviceBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_serviceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [self addSubview:_serviceBtn];
    [_serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.locationBtn.mas_centerY);
        make.width.mas_equalTo(58);
        make.height.mas_equalTo(30);
    }];

    // 消息
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [_messageBtn setImage:[UIImage imageNamed:@"home_top_message"] forState:UIControlStateNormal];
    _messageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:__kSL_Text_13];
    [_messageBtn setTitleColor:[UIColor hexChangeFloat:__kSL_Blue_02] forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_messageBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [self addSubview:_messageBtn];
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.serviceBtn.mas_left).offset(-10);
        make.centerY.mas_equalTo(self.locationBtn.mas_centerY);
        make.width.mas_equalTo(58);
        make.height.mas_equalTo(30);
    }];
}

- (void)btnClick:(UIButton *)btn {
    
}

- (void)initData {
    
}

@end
