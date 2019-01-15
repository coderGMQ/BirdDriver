//
//  BDMyOrderDetailViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/11.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDMyOrderDetailViewController.h"

@interface BDMyOrderDetailViewController ()

@end

@implementation BDMyOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"运单详情";
    self.__navigationView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    self.__contentView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
}

@end
