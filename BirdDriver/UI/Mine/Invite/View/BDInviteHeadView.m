//
//  BDInviteHeadView.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/10.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDInviteHeadView.h"

@interface BDInviteHeadView ()
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@end

@implementation BDInviteHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    
    UILabel *qrCodeLabel = [[UILabel alloc]init];
    qrCodeLabel.text = @"我的邀请二维码";
    qrCodeLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    qrCodeLabel.font = [UIFont systemFontOfSize:__kSL_Text_13];
    [self addSubview:qrCodeLabel];
    [qrCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(20);
    }];
    
    _qrCodeImageView = [[UIImageView alloc]init];
    [self addSubview:_qrCodeImageView];
    [_qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(qrCodeLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(134);
        make.height.mas_equalTo(134);
    }];
    // 生成二维码
    NSString *inputMsg = @"智运道合";
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"]; // 创建滤镜
    [filter setDefaults];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    NSData *inputData = [inputMsg dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:inputData forKeyPath:@"inputMessage"];
    CIImage *outImage = filter.outputImage;
    UIImage *hdImage = [self createHDImageWithOriginalImage:outImage];// 获取高清二维码
    _qrCodeImageView.image = hdImage;
    
    [self addInviteView];
}

- (UIImage *)createHDImageWithOriginalImage:(CIImage *)ciImage {
    CGAffineTransform transform = CGAffineTransformMakeScale(10, 10);
    ciImage = [ciImage imageByApplyingTransform:transform];
    return [UIImage imageWithCIImage:ciImage];
}

- (void)addInviteView {
    // ---邀请码---
    UILabel *inviteQrCodeL = [[UILabel alloc]init];
    inviteQrCodeL.text = @"我的邀请码";
    inviteQrCodeL.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    inviteQrCodeL.font = [UIFont systemFontOfSize:__kSL_Text_13];
    [self addSubview:inviteQrCodeL];
    [inviteQrCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.qrCodeImageView.mas_bottom).offset(50);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(35);
    }];
    
    UITextField *inviteQrCodeT = [[UITextField alloc]init];
    inviteQrCodeT.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    inviteQrCodeT.leftViewMode = UITextFieldViewModeAlways;
    inviteQrCodeT.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    inviteQrCodeT.font = [UIFont systemFontOfSize:__kSL_Text_14];
    inviteQrCodeT.text = @"JGGGGGG123";
    inviteQrCodeT.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    [self addSubview:inviteQrCodeT];
    [inviteQrCodeT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(inviteQrCodeL.mas_centerY);
        make.left.mas_equalTo(inviteQrCodeL.mas_right).offset(10);
        make.width.mas_equalTo(175);
        make.height.mas_equalTo(35);
    }];
    
    UIButton *inviteQrCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inviteQrCodeBtn.backgroundColor = [UIColor hexChangeFloat:__kSL_Blue_01];
    inviteQrCodeBtn.layer.cornerRadius = 3;
    [inviteQrCodeBtn setTitleColor:[UIColor hexChangeFloat:__kSL_White_01] forState:UIControlStateNormal];
    inviteQrCodeBtn.titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_12];
    [inviteQrCodeBtn setTitle:@"复制邀请码" forState:UIControlStateNormal];
    [self addSubview:inviteQrCodeBtn];
    [inviteQrCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(inviteQrCodeT.mas_right).offset(10);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(inviteQrCodeT.mas_centerY);
    }];
    
    // ----邀请链接---
    UILabel *inviteLinkL = [[UILabel alloc]init];
    inviteLinkL.text = @"邀请链接";
    inviteLinkL.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    inviteLinkL.font = [UIFont systemFontOfSize:__kSL_Text_13];
    [self addSubview:inviteLinkL];
    [inviteLinkL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inviteQrCodeL.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(35);
    }];
    
    UITextField *inviteLinkT = [[UITextField alloc]init];
    inviteLinkT.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    inviteLinkT.leftViewMode = UITextFieldViewModeAlways;
    inviteLinkT.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    inviteLinkT.font = [UIFont systemFontOfSize:__kSL_Text_14];
    inviteLinkT.text = @"http://www.baidu.com";
    inviteLinkT.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    [self addSubview:inviteLinkT];
    [inviteLinkT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(inviteLinkL.mas_centerY);
        make.left.mas_equalTo(inviteQrCodeT.mas_left);
        make.width.mas_equalTo(175);
        make.height.mas_equalTo(35);
    }];
    
    UIButton *inviteLinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inviteLinkBtn.backgroundColor = [UIColor hexChangeFloat:__kSL_Blue_01];
    inviteLinkBtn.layer.cornerRadius = 3;
    [inviteLinkBtn setTitleColor:[UIColor hexChangeFloat:__kSL_White_01] forState:UIControlStateNormal];
    inviteLinkBtn.titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_12];
    [inviteLinkBtn setTitle:@"复制邀请链接" forState:UIControlStateNormal];
    [self addSubview:inviteLinkBtn];
    [inviteLinkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(inviteLinkT.mas_right).offset(10);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(inviteLinkT.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(inviteLinkL.mas_bottom).offset(17);
    }];
    
    // ---邀请记录---
    UIImageView *recordImageView = [[UIImageView alloc]init];
    recordImageView.image = [UIImage imageNamed:@"Mine_invite_record"];
    [self addSubview:recordImageView];
    [recordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(lineView.mas_bottom).offset(15);
    }];
    
    UILabel *inviteL = [[UILabel alloc]init];
    inviteL.text = @"我的邀请记录";
    inviteL.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    inviteL.font = [UIFont systemFontOfSize:__kSL_Text_13];
    [self addSubview:inviteL];
    [inviteL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(recordImageView.mas_centerY);
        make.left.mas_equalTo(recordImageView.mas_right).offset(5);
    }];
    
    CGFloat labelY = self.height-30;
    CGFloat labelW = __gScreenWidth/4;
    CGFloat labelH = 30;
    NSArray *inviteArr = @[@"邀请时间",@"邀请账号",@"邀请姓名",@"邀请奖励"];
    for (int i = 0; i<4; i++) {
        UILabel *inviteL = [[UILabel alloc]init];
        inviteL.frame = CGRectMake(labelW*i, labelY, labelW, labelH);
        inviteL.textAlignment = NSTextAlignmentCenter;
        inviteL.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
        inviteL.font = [UIFont systemFontOfSize:__kSL_Text_12];
        inviteL.text = [inviteArr safeObjectAtIndex:i];
        [self addSubview:inviteL];
    }
}
@end
