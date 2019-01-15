//
//  RootViewController.m
//  Nec
//
//  Created by 甘明强 on 2018/11/22.
//  Copyright © 2018年 com.zhihundaohe.WLDS. All rights reserved.
//

#import "RootViewController.h"
#import "BDHomeView.h"
#import "BDOrderView.h"
#import "BDServiceView.h"
#import "BDMineView.h"
#import "BDLoginViewController.h"
#import "MLNavigationController.h"

@interface RootViewController ()<TabbarViewDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) BDHomeView *homeView;
@property (nonatomic, strong) BDOrderView *orderView;
@property (nonatomic, strong) BDServiceView *serviceView;
@property (nonatomic, strong) BDMineView *mineView;
@property (nonatomic, strong) TabbarView *tabbarView;
@end

@implementation RootViewController

- (BOOL)needFullScreen {
    return YES;
}

- (BOOL)needBackButton {
    return NO;
}

- (BOOL)needNavigation {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

    BDLoginViewController *vc = [[BDLoginViewController alloc] init];
    MLNavigationController *navigationController = [[MLNavigationController alloc] initWithRootViewController:vc];
    navigationController.navigationBarHidden = YES;
    [self presentViewController:navigationController animated:NO completion:nil];
}

- (void)initUI {
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __gScreenWidth, __gScreenHeight+__gStatusBarHeight-__gBottomSafeHeight-50)];
    [self showContentViewWithType:TabbarHome enterType:TabbarEnterClick];
    [self.__contentView addSubview:_contentView];
    
    TabbarBean *homeBean = [[TabbarBean alloc] initWithIcon:@"tab_button_home_normal" slectIcon:@"tab_button_home_selected" title:@"首页" type:TabbarHome];
    TabbarBean *orderBean = [[TabbarBean alloc] initWithIcon:@"tab_button_peihuo_normal" slectIcon:@"tab_button_peihuo_selected" title:@"配货" type:TabbarOrder];
    TabbarBean *messageBean = [[TabbarBean alloc] initWithIcon:@"tab_button_service_normal" slectIcon:@"tab_button_service_selected" title:@"服务" type:TabbarMessage];
     TabbarBean *mineBean = [[TabbarBean alloc] initWithIcon:@"tab_button_mine_normal" slectIcon:@"tab_button_mine_selected" title:@"我的" type:TabbarMine];
    NSArray *dataSource = @[homeBean, orderBean, messageBean, mineBean];
    _tabbarView = [[TabbarView alloc] initWithFrame:CGRectMake(0, __gScreenHeight+ __gStatusBarHeight-__gBottomSafeHeight - 50, __gScreenWidth, 50) dataArray:dataSource];
    _tabbarView.delegate = self;
    _tabbarView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    [self.__contentView addSubview:_tabbarView];
}

- (void)showContentViewWithType:(TabbarType)type enterType:(TabbarEnterType)enterType {
    switch (type) {
        case TabbarHome: {// 首页
            if (self.homeView) {
                self.homeView.hidden = NO;
                [self.contentView bringSubviewToFront:self.homeView];
            } else {
                self.homeView = [[BDHomeView alloc] initWithFrame:self.contentView.bounds];
                //                self.homeView.rootViewController = self;
                [self.contentView addSubview:self.homeView];
            }
            break;
        }
        case TabbarOrder: {// 下单
            if (self.orderView) {
                self.orderView.hidden = NO;
                [self.contentView bringSubviewToFront:self.orderView];
            } else {
                self.orderView = [[BDOrderView alloc] initWithFrame:self.contentView.bounds];
                //                self.familyView.rootViewController = self;
                [self.contentView addSubview:self.orderView];
            }
            break;
        }
        case TabbarMessage: {// 服务
            if (self.serviceView) {
                self.serviceView.hidden = NO;
                [self.contentView bringSubviewToFront:self.serviceView];
            } else {
                self.serviceView = [[BDServiceView alloc] initWithFrame:self.contentView.bounds];
                //                self.serviceView.rootViewController = self;
                [self.contentView addSubview:self.serviceView];
            }
            break;
        }
        case TabbarMine: {// 我的
            if (self.mineView) {
                self.mineView.hidden = NO;
                [self.contentView bringSubviewToFront:self.mineView];
            } else {
                self.mineView = [[BDMineView alloc] initWithFrame:self.contentView.bounds];
                self.mineView.rootViewController = self;
                [self.contentView addSubview:self.mineView];
            }
            break;
        }
        default:
            break;
    }
    //    [self refreshStatusBar];
    //    [self refreshUI];
}

#pragma mark - TabbarViewDelegate

- (void)didClickItemWithType:(TabbarType)type enterType:(TabbarEnterType)enterType {
    [self showContentViewWithType:type enterType:enterType];
}
@end
