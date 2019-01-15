//
//  BDMessageCenterDetailViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/11.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDMessageCenterDetailViewController.h"

@implementation BDMessageCenterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"消息中心";
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    [self.__contentView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"系统消息系统消息系统消息系统消息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    titleLabel.font = [UIFont boldSystemFontOfSize:__kSL_Text_15];
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"2018-12-15 18:25:35";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor hexChangeFloat:__kSL_Blue_01];
    timeLabel.font = [UIFont boldSystemFontOfSize:__kSL_Text_10];
    [titleView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-15);
    }];
    
    UIView *lineview = [[UIView alloc]init];
    lineview.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    [self.__contentView addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleView.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(5);
    }];
    
    UILabel *deTitleLabel = [[UILabel alloc]init];
    deTitleLabel.text = @"系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息111";
    deTitleLabel.numberOfLines = 0;
    deTitleLabel.textAlignment = NSTextAlignmentLeft;
    deTitleLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    deTitleLabel.font = [UIFont systemFontOfSize:__kSL_Text_13];
    deTitleLabel.attributedText = [self setLabelIndent:9 text:deTitleLabel.text];
    [self.__contentView addSubview:deTitleLabel];
    [deTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineview.mas_bottom).offset(17);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
}

// 设置UILabel首行缩进
- (NSAttributedString *)setLabelIndent:(CGFloat)indent text:(NSString *)text {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.firstLineHeadIndent = indent * 3;
    NSDictionary *attributeDic = @{NSParagraphStyleAttributeName : paragraphStyle};
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:attributeDic];
    
    return attrText;
}
@end
