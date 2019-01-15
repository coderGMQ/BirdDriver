//
//  EBaseViewController.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "EBannerButton.h"
#import "EBackgroundView.h"
#import "ENavigationView.h"
#import "EContentView.h"

enum {
    ETBaseViewCtrlerMove,       // view moved aniated
    ETBaseViewCtrlerPop,        // normaly pop view controller
    ETBaseViewCtrlerDismiss     // normary dismiss view controller
};

typedef NSInteger ETBaseViewCtrlerHideType;


@interface EBaseViewController : UIViewController {
    // @private
    UILabel *__titleLabel;
    UIView *__statusBarView;
}

// default nil
@property (nonatomic,assign,setter = setBannerType:) ETBannerButtonType __bannerType;
@property (nonatomic,assign,setter = setCtrlerHideType:) ETBaseViewCtrlerHideType __ctrlerHideType;
@property (nonatomic,strong) IBOutlet EBannerButton *__leftBannerBt;    // may be nil
@property (nonatomic,strong) IBOutlet EBannerButton *__leftWhiteBannerBt;    // may be nil
@property (nonatomic,strong) IBOutlet ENavigationView *__navigationView;
@property (nonatomic,strong) IBOutlet EBackgroundView *__backgroundView;
@property (nonatomic,strong) UILabel *__titleLabel;
@property (nonatomic,strong) IBOutlet EBannerButton *__finishBannerBt;  // may be nil
@property (nonatomic,strong) IBOutlet EBannerButton *__cancelBannerBt;  // may be nil
@property (nonatomic,strong) IBOutlet EBannerButton *__addBannerBt;  // may be nil
@property (nonatomic,strong) IBOutlet EContentView * __contentView;
@property (nonatomic,strong) UIView *__navigationLine;   // 导航栏线
@property (nonatomic,strong,setter = setTitle:) NSString *__title;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *__navigationHeight;

// 点击返回按钮
- (IBAction)onTouchBackBt:(EBannerButton *)button;
//标识该controller是否使用手势退出功能 默认YES
-(BOOL)isUserGestureBack;
//标记该controller是否需要直接返回到根controller 默认NO
-(BOOL)isNeedBackToRoot;
//当controller被pop出来时均会触发该方法
-(void)viewWillBePopToDisappear;
//返回上一页面 controller present 会dismis 出去  push 会pop 出去
-(void)goBack;
//当前侧滑是否符合特定条件 默认YES
-(BOOL)validLocationWithGesture:(UIGestureRecognizer *)gesture;
//是否需要全屏 默认NO
- (BOOL)needFullScreen;
//是否需要返回按钮 默认:YES
- (BOOL)needBackButton;
//返回按钮样式
- (ETBannerButtonType)backBtuttonType;
//设置IOS 7 stausbar 颜色
-(void)setStatusBarColor:(UIColor *)color;
//多个scrollview 点击状态栏 当前的scrollview 回到顶部
-(void)addScrollToTopActionBlock:(dispatch_block_t)block;
//处理主题色发生变化
- (void)handleThemeDidChanged;
//添加滚动ScroolView 导航栏背景色跟着变换  maxLength:滚动的最大距离 需要在scrollViewDidScroll 方法里调用
- (void)addScroolNavigationAdaptActionWithScroolView:(UIScrollView *)scrollView maxLength:(CGFloat)maxLength scroolBlock:(void (^)(BOOL beforeMaxLength))scroolBlock;
// 点击返回按钮判断显示弹窗
- (void)showAlertView;

// 是否需要把StatusBar颜色改成白色的  默认NO
- (BOOL)needChangeWhiteStatusBarStyle;

@end
