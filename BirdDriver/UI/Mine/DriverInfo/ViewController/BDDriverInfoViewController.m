//
//  BDDriverInfoViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/9.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDDriverInfoViewController.h"
#import "BDCarInfoViewController.h"

@interface BDDriverInfoViewController ()
{
    __weak IBOutlet UIButton *_nextBtn;
    __weak IBOutlet UIView *_uploadHeadView;
    __weak IBOutlet UIView *_uploadDriverView;
}
@end

@implementation BDDriverInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"驾驶员信息";
    self.__navigationView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    [self addGestureRecognizer:_uploadHeadView];
    [self addGestureRecognizer:_uploadDriverView];
    _nextBtn.layer.cornerRadius = 3;
}

- (void)addGestureRecognizer:(UIView *)uploadView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadTap:)];
    [uploadView addGestureRecognizer:tap];
}

- (void)uploadTap:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == 110) {// 上传头像
        
    } else if (tap.view.tag == 111) {// 上传驾驶证
        
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    if (sender == _nextBtn) {
        BDCarInfoViewController *vc = [[BDCarInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
