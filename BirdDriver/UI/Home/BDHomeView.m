//
//  BDHomeView.m
//  BirdDriver
//
//  Created by 甘明强 on 2018/12/28.
//  Copyright © 2018年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDHomeView.h"
#import "BDHomeNavView.h"
#import "BDHomeTopView.h"
#import "BDSubscribeSourceView.h"

@interface BDHomeView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) BDHomeNavView *navView;
@property (nonatomic, strong) BDHomeTopView *topView;
@property (nonatomic, strong) BDSubscribeSourceView *subscribeSourceView;
@end

@implementation BDHomeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.title = @"笨鸟智运";
    self.__titleLabel.textColor = [UIColor hexChangeFloat:__kSL_Red];
    
    self.__navigationViewLine.hidden = YES;
    
    self.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];

    _navView = [[BDHomeNavView alloc] initWithFrame:CGRectMake(0, __gStatusBarHeight, __gScreenWidth, 50)];
    _navView.backgroundColor = [UIColor clearColor];
    [self addSubview:_navView];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(__gStatusBarHeight+50);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    _topView = [[BDHomeTopView alloc]initWithFrame:CGRectMake(0, 0, __gScreenWidth, 310)];
    [_scrollView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(__gScreenWidth);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(310);
    }];
    
    _subscribeSourceView = [[BDSubscribeSourceView alloc]init];
    [_scrollView addSubview:_subscribeSourceView];
    [_subscribeSourceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(__gScreenWidth);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(10);
        make.height.mas_equalTo(245);
    }];
}

@end
