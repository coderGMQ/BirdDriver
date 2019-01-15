//
//  SLMineUserProfileView.m
//  SmartLife
//
//  Created by han on 2017/3/6.
//
//

#import "BDMineUserProfileView.h"

@interface BDMineUserProfileView()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UIImageView *accountImageView;
@end

@implementation BDMineUserProfileView

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    // 背景图片
    _backImageView = [[UIImageView alloc]init];
    _backImageView.image = [UIImage imageNamed:@"Mine_background"];
    [self addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    _topView = [[UIView alloc]init];
    [self addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(__gScreenWidth);
        make.height.mas_equalTo(self.height-50);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    // 头像
    _avatarImageView = [[UIImageView alloc] init];
    _avatarImageView.image = [UIImage imageNamed:@"mine_avatar_placeholder"];
    _avatarImageView.layer.cornerRadius = 33;
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.borderWidth = 1.0;
    _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarImageView.userInteractionEnabled = YES;
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_topView addSubview:_avatarImageView];
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo((self.height-50-__gStatusBarHeight-66)/2+__gStatusBarHeight);
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(66);
    }];
    
    // 用户姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"未认证用户";
    _nameLabel.font = [UIFont boldSystemFontOfSize: __kSL_Text_16];
    _nameLabel.textColor = [UIColor hexChangeFloat:__kSL_White_01];
    [_topView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.avatarImageView.mas_top).offset(12);
    }];
    
    // text
    UILabel *authText = [[UILabel alloc] init];
    authText.text = @"认证后可享受更多服务";
    authText.font = [UIFont boldSystemFontOfSize: __kSL_Text_12];
    authText.textColor = [UIColor hexChangeFloat:__kSL_White_01];
    [_topView addSubview:authText];
    [authText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
    }];
    
    // 账号图片
//    _accountImageView = [[UIImageView alloc] init];
//    _accountImageView.image = [UIImage imageNamed:@"Mine_telephone"];
//    _accountImageView.userInteractionEnabled = YES;
//    _accountImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [_topView addSubview:_accountImageView];
//    [_accountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.left.mas_equalTo(self.avatarImageView.mas_right).offset(10);
//        make.top.mas_equalTo(authText.mas_bottom).offset(5);
//        make.width.mas_equalTo(15);
//        make.height.mas_equalTo(15);
//    }];
//
//    // 账号label
//    _accountLabel = [[UILabel alloc] init];
//    _accountLabel.font = [UIFont systemFontOfSize: __kSL_Text_15];
//    _accountLabel.text = @"18118850883";
//    _accountLabel.textColor = [UIColor hexChangeFloat:__kSL_White_01];
//    [_topView addSubview:_accountLabel];
//    [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.accountImageView.mas_right).offset(5);
//        make.centerY.mas_equalTo(self.accountImageView.mas_centerY);
//    }];
    
    // 钱包余额view
    UIView *balanceView = [[UIView alloc]init];
    balanceView.backgroundColor = [UIColor hexChangeFloat:__kSL_Black AndAlpha:0.3];
    [self addSubview:balanceView];
    [balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    // 左边view
    UIView *leftView = [[UIView alloc]init];
    [balanceView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo((self.width-0.5)/2);
    }];
    
    // 右边view
    UIView *rightView = [[UIView alloc]init];
    [balanceView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo((self.width-0.5)/2);
    }];
    
    // 中间竖线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    [balanceView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(0.5);
        make.centerX.mas_equalTo(balanceView.mas_centerX);
    }];
    
    // 余额label
    UILabel *monenyNumLabel = [[UILabel alloc]init];
    monenyNumLabel.textColor = [UIColor hexChangeFloat:__kSL_White_01];
    monenyNumLabel.text = @"$20";
    monenyNumLabel.font = [UIFont systemFontOfSize:__kSL_Text_14];
    [leftView addSubview:monenyNumLabel];
    [monenyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(leftView.mas_centerX);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *monenyLabel = [[UILabel alloc]init];
    monenyLabel.textColor = [UIColor hexChangeFloat:__kSL_White_01];
    monenyLabel.text = @"钱包余额";
    monenyLabel.font = [UIFont systemFontOfSize:__kSL_Text_13];
    [leftView addSubview:monenyLabel];
    [monenyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(leftView.mas_centerX);
        make.top.mas_equalTo(monenyNumLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(25);
    }];
    
    // 优惠券label
    UILabel *couponNumLabel = [[UILabel alloc]init];
    couponNumLabel.textColor = [UIColor hexChangeFloat:__kSL_White_01];
    couponNumLabel.text = @"0";
    couponNumLabel.font = [UIFont systemFontOfSize:__kSL_Text_14];
    [rightView addSubview:couponNumLabel];
    [couponNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(rightView.mas_centerX);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(0);
    }];
    
    // 余额label
    UILabel *couponLabel = [[UILabel alloc]init];
    couponLabel.textColor = [UIColor hexChangeFloat:__kSL_White_01];
    couponLabel.text = @"优惠券";
    couponLabel.font = [UIFont systemFontOfSize:__kSL_Text_13];
    [rightView addSubview:couponLabel];
    [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(rightView.mas_centerX);
        make.top.mas_equalTo(monenyNumLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(25);
    }];
    
    // 认证view
    UIView *authView = [[UIView alloc]init];
    authView.backgroundColor = [UIColor hexChangeFloat:__kSL_Black AndAlpha:0.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(authViewTap:)];
    [authView addGestureRecognizer:tap];
    [_topView addSubview:authView];
    [authView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_top).offset(0);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(65);
    }];
    
    UILabel *authLabel = [[UILabel alloc]init];
    authLabel.text = @"去认证";
    authLabel.font = [UIFont systemFontOfSize:__kSL_Text_12];
    authLabel.textColor = [UIColor hexChangeFloat:__kSL_White_01];
    [authView addSubview:authLabel];
    [authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(authView.mas_centerY);
    }];
    
    // 右边箭头
    UIImageView *rowImageView = [[UIImageView alloc] init];
    rowImageView.image = [UIImage imageNamed:@"icn_mine_more"];
    rowImageView.userInteractionEnabled = YES;
    rowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [authView addSubview:rowImageView];
    [rowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(5);
        make.height.mas_equalTo(10);
        make.centerY.mas_equalTo(authView.mas_centerY);
    }];
}

// 点击去认证
- (void)authViewTap:(UITapGestureRecognizer *)tap {
//    BDDriverInfoViewController *vc = [[BDDriverInfoViewController alloc]init];
//    [self.superview..navigationController pushViewController:vc animated:YES];
    if (self.authTapBlock) {
        self.authTapBlock();
    }
}
@end
