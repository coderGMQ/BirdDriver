//
//  BDMembershipCodeViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/11.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDMembershipCodeViewController.h"

@interface BDMembershipCodeViewController ()
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@end

@implementation BDMembershipCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"会员码";
    
    UILabel *qrCodeLabel = [[UILabel alloc]init];
    qrCodeLabel.text = @"笨鸟智运专属会员特权二维码";
    qrCodeLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    qrCodeLabel.font = [UIFont systemFontOfSize:__kSL_Text_13];
    [self.__contentView addSubview:qrCodeLabel];
    [qrCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.__contentView);
        make.top.mas_equalTo(30);
    }];
    
    _qrCodeImageView = [[UIImageView alloc]init];
    [self.__contentView addSubview:_qrCodeImageView];
    [_qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(qrCodeLabel.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.__contentView);
        make.width.mas_equalTo(210);
        make.height.mas_equalTo(210);
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
}

- (UIImage *)createHDImageWithOriginalImage:(CIImage *)ciImage {
    CGAffineTransform transform = CGAffineTransformMakeScale(10, 10);
    ciImage = [ciImage imageByApplyingTransform:transform];
    return [UIImage imageWithCIImage:ciImage];
}
@end
