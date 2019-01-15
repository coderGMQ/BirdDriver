//
//  EBaseViewController.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "EBaseViewController.h"
//#import "SLAlertView.h"

@interface EBaseViewController ()

@property(nonatomic,copy)dispatch_block_t scrollTopAction;
@property (nonatomic,assign)UIStatusBarStyle oldStatusBarStyle;
@end

@implementation EBaseViewController

@synthesize __backgroundView;
@synthesize __bannerType;
@synthesize __ctrlerHideType;
@synthesize __leftBannerBt;
@synthesize __leftWhiteBannerBt;
@synthesize __finishBannerBt,__cancelBannerBt,__addBannerBt;
@synthesize __title;
@synthesize __navigationView;
@synthesize __titleLabel;
@synthesize __navigationLine;

- (void)viewDidUnload {
    __leftBannerBt      = nil;
    __navigationView    = nil;
    __backgroundView    = nil;
    __finishBannerBt    = nil;
    __cancelBannerBt    = nil;
    __addBannerBt       = nil;
    __leftWhiteBannerBt = nil;
    [super       viewDidUnload];
    NSLog(@"====viewDidUnload====%@",self);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.__leftBannerBt = nil;
    self.__finishBannerBt = nil;
    self.__leftWhiteBannerBt = nil;
    self.__cancelBannerBt = nil;
    self.__addBannerBt    = nil;
    self.__navigationView = nil;
    self.__backgroundView =  nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"====didReceiveMemoryWarning====%@",self);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if (![self needFullScreen] ) {
        BOOL isHidde = [[UIApplication sharedApplication] isStatusBarHidden];
        if (isHidde) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.autoresizesSubviews = YES;
    [self initBackgroundView];
    [self initContentView];
    [self initNavigationView];
    if ([self needChangeWhiteStatusBarStyle]) {
        self.oldStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    [self modifyXibLayoutConstraint];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self needChangeWhiteStatusBarStyle]) {
        [[UIApplication sharedApplication] setStatusBarStyle:self.oldStatusBarStyle];
    }
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)modifyXibLayoutConstraint {
    self.__navigationHeight.constant = __gStatusBarHeight + __gNavigationHeight;
}

- (void)initBackgroundView{
    if (!self.__backgroundView) {
        self.__backgroundView = [[EBackgroundView alloc] init];
        [self.view addSubview:__backgroundView];
    }
    [self refreshBackgroundViewFrame];
    __backgroundView.userInteractionEnabled = YES;
    [__backgroundView initBackgroundView];
}

- (void)initNavigationView{

    if([self needNavigation])
    {
        if (!self.__navigationView) {
            self.__navigationView = [[ENavigationView alloc] init];
            [self.__backgroundView addSubview:self.__navigationView];
        }
        [__navigationView initNavgationView];
        
        __navigationLine = [[UIView alloc] initWithFrame:CGRectMake(0, __gNavigationHeight-0.5, __gScreenWidth, 0.5)];
        if ([self needFullScreen]) {
            __navigationView.contentView.backgroundColor = [UIColor clearColor];
            __navigationView.backgroundColor = [UIColor clearColor];
            __navigationLine.backgroundColor = [UIColor hexChangeFloat:__kSL_Line_01 AndAlpha:0];
        } else {
            __navigationLine.backgroundColor = [UIColor hexChangeFloat:__kSL_Line_01];
        }
        __navigationView.line = __navigationLine;
        [__navigationView.contentView addSubview:__navigationLine];
        
        if ([self needBackButton]) {
            
            switch ([self backBtuttonType]) {
                case ETBannerButtonBack:
                {
                    if (!__leftBannerBt) {
                        __leftBannerBt = [[EBannerButton alloc] initWithFrame:CGRectMake(0, 2, 40, 40)];
                        [__leftBannerBt addTarget:self action:@selector(onTouchBackBt:) forControlEvents:UIControlEventTouchUpInside];
                        [self.__navigationView.contentView addSubview:__leftBannerBt];
                    }
                    break;
                }
                case ETBannerButtonFinished:
                {
                    if (!__finishBannerBt) {
                        __finishBannerBt = [[EBannerButton alloc] initWithFrame:CGRectMake(0, 2, 40, 40)];
                        [__finishBannerBt addTarget:self action:@selector(onTouchBackBt:) forControlEvents:UIControlEventTouchUpInside];
                        [self.__navigationView.contentView addSubview:__finishBannerBt];
                    }
                    break;
                }
                case ETBannerButtonCancel:
                {
                    if (!__cancelBannerBt) {
                        __cancelBannerBt = [[EBannerButton alloc] initWithFrame:CGRectMake(0, 2, 40, 40)];
                        [__cancelBannerBt addTarget:self action:@selector(onTouchBackBt:) forControlEvents:UIControlEventTouchUpInside];
                        [self.__navigationView.contentView addSubview:__cancelBannerBt];
                    }
                    break;
                }
                case ETBannerButtonAdd:
                {
                    if (!__addBannerBt) {
                        __addBannerBt = [[EBannerButton alloc] initWithFrame:CGRectMake(0, 2, 40, 40)];
                        [__addBannerBt addTarget:self action:@selector(onTouchBackBt:) forControlEvents:UIControlEventTouchUpInside];
                        [self.__navigationView.contentView addSubview:__addBannerBt];
                    }
                    break;
                }
                case ETBannerButtonWhite:
                {
                    if (!__leftWhiteBannerBt) {
                        __leftWhiteBannerBt = [[EBannerButton alloc] initWithFrame:CGRectMake(0, 2, 40, 40)];
                        [__leftWhiteBannerBt addTarget:self action:@selector(onTouchBackBt:) forControlEvents:UIControlEventTouchUpInside];
                        [self.__navigationView.contentView addSubview:__leftWhiteBannerBt];
                    }
                    break;
                }
                default:
                    break;
            }
            
            if (nil != __leftBannerBt) {
                [__leftBannerBt initWithType:ETBannerButtonBack];
                [__navigationView bringSubviewToFront:__leftBannerBt];
            }
            if (nil != __leftWhiteBannerBt) {
                [__leftWhiteBannerBt initWithType:ETBannerButtonWhite];
                [__navigationView bringSubviewToFront:__leftWhiteBannerBt];
            }
            if (nil != __finishBannerBt) {
                [__finishBannerBt initWithType:ETBannerButtonFinished];
                [__navigationView bringSubviewToFront:__finishBannerBt];
            }
            if (nil != __cancelBannerBt) {
                [__cancelBannerBt initWithType:ETBannerButtonCancel];
                [__navigationView bringSubviewToFront:__cancelBannerBt];
            }
            if (nil != __addBannerBt) {
                [__addBannerBt initWithType:ETBannerButtonAdd];
                [__navigationView bringSubviewToFront:__addBannerBt];
            }
        }
        __titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f,0.0f,__gScreenWidth-100,__gNavigationHeight)];
        __titleLabel.backgroundColor = [UIColor clearColor];
        __titleLabel.textColor = [UIColor blackColor];
        __titleLabel.textAlignment = NSTextAlignmentCenter;
        __titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [__navigationView.contentView addSubview:__titleLabel];
        [__navigationView.superview bringSubviewToFront:__navigationView];
    }
}

- (void)initContentView{
    if (!self.__contentView) {
        self.__contentView = [[EContentView alloc] init];
        [self.__backgroundView addSubview:self.__contentView];
    }
    [self.__contentView initContentView];
    if ([self needFullScreen]) {
        self.__contentView.frame = CGRectMake(0, 0, __gScreenWidth, __gScreenHeight+20);
    } else {
        self.__contentView.frame = CGRectMake(0, __gNavigationHeight+__gStatusBarHeight, __gScreenWidth, __gScreenHeight-__gNavigationHeight-__gBottomSafeHeight);
    }
}

- (void)refreshBackgroundViewFrame {
    if ([self isTopLevel]) {
        CGRect viewFrame = [UIScreen mainScreen].bounds;
        __backgroundView.frame = viewFrame;
    }
}

#pragma mark - Private Method

- (void)handleThemeDidChanged{
    __statusBarView.backgroundColor = [UIColor hexChangeFloat:__gStyleColor];
    __navigationView.backgroundColor = [UIColor hexChangeFloat:__gStyleColor];
}

- (void)onTouchBackBt:(EBannerButton *)button{
    if (ETBannerButtonBack  == __bannerType) {
        if (ETBaseViewCtrlerPop  == __ctrlerHideType) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if(ETBaseViewCtrlerDismiss == __ctrlerHideType){
            
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        }else {
            [self goBack];
        }
    }else {
    }
}

-(void)goBack{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)addScrollToTopActionBlock:(dispatch_block_t)block{
    UITapGestureRecognizer *tap =
    [[__statusBarView gestureRecognizers] safeObjectAtIndex:0];
    if (tap == nil) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollCurScrollViewToTop:)];
        [__statusBarView addGestureRecognizer:tap];
    }
}

#pragma mark Public Method

//标识该controller是否使用手势退出功能,默认YES
- (BOOL)isUserGestureBack{
    return YES;
}

//标记该controller是否需要直接返回到根controller
- (BOOL)isNeedBackToRoot{
    return NO;
}

//当controller被pop出来时均会触发该方法
- (void)viewWillBePopToDisappear{
    
}

//当前侧滑是否符合特定条件
- (BOOL)validLocationWithGesture:(UIGestureRecognizer *)gesture{
    return YES;
}

- (void)setStatusBarColor:(UIColor *)color{
    __statusBarView.backgroundColor = color;
}

- (BOOL)needChangeWhiteStatusBarStyle {
    return NO;
}

/**
 *  控制器的展示方式，有时候控制器是嵌套显示在其他控制器之中的
 *
 *  @return YES：没有被嵌套到其他控制器里面；NO：被嵌套了其他控制器的view中
 默认是YES
 */
- (BOOL)isTopLevel{
    return YES;
}

- (BOOL)needFullScreen{
    return NO;
}

- (BOOL)needNavigation {
    return YES;
}

- (BOOL)needBackButton
{
    return YES;
}

- (ETBannerButtonType)backBtuttonType{
    return ETBannerButtonBack;
}

- (void)scrollCurScrollViewToTop:(UITapGestureRecognizer *)tap{
    if (self.scrollTopAction) {
        self.scrollTopAction();
    }
}

// 在crollViewDidScroll 方法里调用
- (void)addScroolNavigationAdaptActionWithScroolView:(UIScrollView *)scrollView maxLength:(CGFloat)maxLength scroolBlock:(void (^)(BOOL beforeMaxLength))scroolBlock {
    
    if (scrollView.contentSize.height<=CGRectGetHeight(scrollView.frame)+maxLength) {
        return;
    }
    CGFloat currentY = scrollView.contentOffset.y;
    if (currentY<=0) {
        self.__titleLabel.textColor = [UIColor hexChangeFloat:__kSL_White_01];
        self.__navigationView.backgroundColor = [UIColor clearColor];
        self.__leftWhiteBannerBt.iconView.image = [UIImage imageNamed:@"fun_btn_back_white"];
        self.__navigationLine.backgroundColor = [UIColor hexChangeFloat:__kSL_Line_01 AndAlpha:0];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        if (scroolBlock) {
            scroolBlock(YES);
        }
    } else if (currentY<maxLength) {
        float radio = currentY/maxLength;
        self.__titleLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01 AndAlpha:radio];
        self.__navigationView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01 AndAlpha:radio];
        self.__navigationLine.backgroundColor = [UIColor hexChangeFloat:__kSL_Line_01 AndAlpha:radio];
        if (scroolBlock) {
            scroolBlock(YES);
        }
    } else {
        self.__titleLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
        self.__navigationView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
        self.__leftWhiteBannerBt.iconView.image = [UIImage imageNamed:@"fun_btn_back"];
        self.__navigationLine.backgroundColor = [UIColor hexChangeFloat:__kSL_Line_01 AndAlpha:1];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        if (scroolBlock) {
            scroolBlock(NO);
        }
    }
}

- (void)showAlertView {
    __weak typeof(self) weakSelf = self;
//    NSArray *firstButton = @[@"取消",@"999999"];
//    NSArray *secondButton = @[@"确定",@"4285f4"];
//    NSArray *textArray = @[firstButton,secondButton];
//    SLAlertView *alertView = [[SLAlertView alloc]initWithTitle:nil message:@"您还未保存，确定退出吗？" customView:nil textAttArray:textArray delegate:nil alertViewType:SLAlertViewCommonType];
//    alertView.clickBlock = ^(NSInteger clickIndex) {
//        if (clickIndex == 1) {
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        }
//    };
//    [alertView show];
}

#pragma mark - Setter Getter

- (void)setBannerType:(ETBannerButtonType)bType{
    __bannerType = bType;
    [self.__leftBannerBt initWithType:bType];
}

- (void)setCtrlerHideType:(ETBaseViewCtrlerHideType)cType{
    __ctrlerHideType = cType;
}

- (void)setTitle:(NSString *)title{
    if (__title != title) {
        __title = title;
    }
    __titleLabel.text = __title;
}

@end
