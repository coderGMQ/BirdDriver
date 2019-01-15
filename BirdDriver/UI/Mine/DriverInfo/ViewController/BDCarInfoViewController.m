//
//  BDCarInfoViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/10.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDCarInfoViewController.h"

@interface BDCarInfoViewController ()
{
    __weak IBOutlet UIView *_uploadDrivingView;
    __weak IBOutlet UITextField *_licensePlateT;
    __weak IBOutlet UIButton *_licensePlateBtn;
    __weak IBOutlet UITextField *_carNumT;
    __weak IBOutlet UITextField *_carStyleT;
    __weak IBOutlet UIButton *_carStyleBtn;
    __weak IBOutlet UITextField *_carLengthT;
    __weak IBOutlet UIButton *_carLengthBtn;
    __weak IBOutlet UIButton *_agreeBtn;
    __weak IBOutlet UILabel *_agreeLabel;
    __weak IBOutlet UIButton *_sureBtn;
    __weak IBOutlet UIView *_agreeView;
}
@end

@implementation BDCarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"车辆信息";
    self.__navigationView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    
    _sureBtn.layer.cornerRadius = 3;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_agreeLabel.text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hexChangeFloat:__kSL_Black_02] range:NSMakeRange(0,7)];
    _agreeLabel.attributedText = str;
    
    [self addGestureRecognizer:_uploadDrivingView];
    [self addGestureRecognizer:_agreeView];
}

- (void)addGestureRecognizer:(UIView *)view {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap:)];
    [view addGestureRecognizer:tap];
}

- (void)viewTap:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == 111) {// 上传行驶证
        
    } else if (tap.view.tag == 112) {
           _agreeBtn.selected = !_agreeBtn.selected;
    }
}

- (IBAction)btnClick:(id)sender {
   if (sender == _sureBtn) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
