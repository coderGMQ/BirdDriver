//
//  BDLoginViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/7.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDLoginViewController.h"
#import "BDRegisterViewController.h"

@interface BDLoginViewController ()
{
    __weak IBOutlet UITextField *_phoneT;
    __weak IBOutlet UITextField *_securityCodeT;
    __weak IBOutlet UIButton *_securityCodeBtn;
    __weak IBOutlet UIButton *_loginBtn;
    __weak IBOutlet UILabel *_registerDriverLabel;
    __weak IBOutlet UIButton *_ownerBtn;
    __weak IBOutlet UIButton *_serviceBtn;
    __weak IBOutlet UILabel *_versionLabel;
    __weak IBOutlet UIView *_contentView;
    __weak IBOutlet UIImageView *_backgroundImageView;
}

@end

@implementation BDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Private Method
- (BOOL)needFullScreen{
    return YES;
}

- (BOOL)needBackButton{
    return NO;
}

// 是否使用手势退出功能
- (BOOL)isUserGestureBack{
    return NO;
}

- (void)initUI {
    _loginBtn.layer.cornerRadius = 3;
    _contentView.layer.cornerRadius = 5;
    _securityCodeBtn.layer.cornerRadius = 3;
    // 添加下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSUnderlineColorAttributeName : [UIColor hexChangeFloat:__kSL_Blue_02]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_registerDriverLabel.text attributes:attribtDic];
    _registerDriverLabel.attributedText = attribtStr;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)];
    _registerDriverLabel.userInteractionEnabled = YES;
    [_registerDriverLabel addGestureRecognizer:gestureRecognizer];
    
    NSDictionary *infoPlist = [[NSBundle mainBundle]infoDictionary];
    NSString *app_Version = [infoPlist objectForKey:@"CFBundleShortVersionString"];
    _versionLabel.text = [NSString stringWithFormat:@"司机版V%@",app_Version];
}

- (void)labelClick:(UITapGestureRecognizer *)tap {
    BDRegisterViewController *vc = [[BDRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnClick:(UIButton *)sender {
    if (sender == _loginBtn) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
