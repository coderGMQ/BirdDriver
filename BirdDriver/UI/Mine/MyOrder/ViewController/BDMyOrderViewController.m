//
//  BDMyOrderViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/11.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDMyOrderViewController.h"
#import "SLBtnHelper.h"
#import "MLCommonScroolView.h"
#import "BDMyOrderItemView.h"

@interface BDMyOrderViewController ()
{
    UIButton *_selectBtn;
    MLCommonScroolView *_commonScroolView;
}
@end

@implementation BDMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"我的运输单";
    self.__navigationView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    
    _selectBtn = [SLBtnHelper rightNavBtnWithTitle:@"筛选"];
    [_selectBtn setTitleColor:[UIColor hexChangeFloat:__kSL_Black_02] forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.__navigationView.contentView addSubview:_selectBtn];
    
    
    NSArray *titleArray = @[@"待确认",@"运输中",@"已完成",@"已取消"];
    NSMutableArray *itemArray = [NSMutableArray array];
    for (int i = 0; i<titleArray.count; i++) {
        BDMyOrderItemView *itemView = [[BDMyOrderItemView alloc]initWithFrame:CGRectMake(0, 0, __gScreenWidth, __gScreenHeight-__gNavigationHeight-44)];
        [itemArray addObject:itemView];
    }
    _commonScroolView = [[MLCommonScroolView alloc]initWithFrame:self.__contentView.bounds andType:MLCommonScroolHeadBlueUnderline defaultPage:0];
    _commonScroolView.scrollEnabled = YES;
    _commonScroolView.titleArr = titleArray;
    _commonScroolView.contentViewArr = itemArray;
    [self.__contentView addSubview:_commonScroolView];
}

- (void)btnClick:(UIButton *)btn {
    if (btn == _selectBtn) {
    }
}



@end
