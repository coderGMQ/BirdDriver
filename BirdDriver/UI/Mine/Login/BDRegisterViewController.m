//
//  BDRegisterViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/7.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDRegisterViewController.h"

@interface BDRegisterViewController ()
{
    __weak IBOutlet UILabel *_skipUrlLabel;
    __weak IBOutlet UITextField *_phoneT;
    __weak IBOutlet UITextField *_securityT;
    __weak IBOutlet UIButton *_securityBtn;
    __weak IBOutlet UILabel *_securityLabel;
    __weak IBOutlet UIButton *_registerBtn;
    __weak IBOutlet UILabel *_userLabel;
    __weak IBOutlet UILabel *_protectLabel;
}
@end

@implementation BDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initUI];
}

- (void)initUI {
    self.title = @"注册司机端";
    self.__titleLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    self.__navigationView.backgroundColor = [UIColor hexChangeFloat:@"f4f6f8"];
    self.__contentView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    
    _registerBtn.layer.cornerRadius = 3;
    _securityBtn.layer.cornerRadius = 3;

    [self addUnderlineWithLabel:_skipUrlLabel];
    [self addUnderlineWithLabel:_userLabel];
    [self addUnderlineWithLabel:_protectLabel];
}

// 添加下划线
- (void)addUnderlineWithLabel:(UILabel *)label {
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSUnderlineColorAttributeName : [UIColor hexChangeFloat:__kSL_Blue_02]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:label.text attributes:attribtDic];
    label.attributedText = attribtStr;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)];
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:gestureRecognizer];
}

- (void)labelClick:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == 100) {
        
    } else if (tap.view.tag == 101) {
        
    } else if (tap.view.tag == 102) {
        
    }
}

- (IBAction)btnClick:(UIButton *)sender {
}
@end
