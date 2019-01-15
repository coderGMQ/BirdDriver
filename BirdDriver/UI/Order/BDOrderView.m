//
//  BDOrderView.m
//  BirdDriver
//
//  Created by 甘明强 on 2018/12/28.
//  Copyright © 2018年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDOrderView.h"

@implementation BDOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.title = @"下单";
    self.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
}

@end
