//
//  BDGuideViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/7.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDGuideViewController.h"
#import "BDGuideView.h"

static NSString * const _hasShowedGuideViewUserDefault = @"hasShowedGuideViewUserDefault";

@interface BDGuideViewController ()<BDGuideViewDelegate>

@end

@implementation BDGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    BDGuideView *guideView = [[BDGuideView alloc]initWithFrame:self.view.bounds];
    guideView.delegate = self;
    [self.view addSubview:guideView];
    [kUserStore setObject:@(YES) forKey:_hasShowedGuideViewUserDefault];
    [kUserStore synchronize];
}

+ (BOOL)needShowGuideView {
    BOOL hasShowed = [[kUserStore objectForKey:_hasShowedGuideViewUserDefault]boolValue];
    return !hasShowed;
}

#pragma mark - BDGuideViewDelegate

- (void)didClickUseAppRightNow {
    if (self.finishBlock) {
        self.finishBlock();
    }
}
@end
