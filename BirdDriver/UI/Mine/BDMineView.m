//
//  BDMineView.m
//  BirdDriver
//
//  Created by 甘明强 on 2018/12/28.
//  Copyright © 2018年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDMineView.h"
#import "BDMineUserProfileView.h"
#import "UIDeviceInfo.h"
#import "BDDriverInfoViewController.h"
#import "BDInviteViewController.h"
#import "BDMyOrderViewController.h"
#import "BDMembershipCodeViewController.h"
#import "BDMessageCenterViewController.h"
#import "BDSettingViewController.h"

@interface BDMineView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation BDMineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.rowHeight = 44;
    _tableView.separatorColor = [UIColor hexChangeFloat:__kSL_Line_01];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:_tableView];
    [self addHeaderView];
}

- (void)addHeaderView {
    CGFloat height = 215 * __gScreenWidth / 375;
    if ([UIDeviceInfo isiPhoneX]) {
        height = 250 * __gScreenWidth / 375;
    }
    BDMineUserProfileView *userProfileView = [[BDMineUserProfileView alloc] initWithFrame:CGRectMake(0, 0, __gScreenWidth, height)];
    __weak typeof (self)weakSelf = self;
    userProfileView.authTapBlock = ^{
        [weakSelf goToDriverInfo];
    };
    _tableView.tableHeaderView = userProfileView;
}

// 跳转驾驶员信息
- (void)goToDriverInfo {
    BDDriverInfoViewController *vc = [[BDDriverInfoViewController alloc]init];
    [self.rootViewController.navigationController pushViewController:vc animated:YES];

}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"kCellIdentifier_mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:__kSL_Text_15];
        cell.textLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *title;
    NSString *detailTitle;
    NSString *iconStr;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            title = @"我的运单";
            iconStr = @"order";
        } else if (indexPath.row == 1) {
            title = @"交易记录";
            iconStr = @"record";
        } else if (indexPath.row == 2) {
            title = @"邀请有礼";
            iconStr = @"invite";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            title = @"消息中心";
            iconStr = @"message";
        } else if (indexPath.row == 1) {
            title = @"会员码";
            iconStr = @"qrCode";
        } else if (indexPath.row == 2) {
            title = @"联系客服";
            iconStr = @"contactService";
        } else if (indexPath.row == 3) {
            title = @"设置";
            iconStr = @"setup";
        }
    }
    cell.textLabel.text = title;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icn_mine_%@", iconStr]];
    cell.detailTextLabel.text = detailTitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BDMyOrderViewController *vc = [[BDMyOrderViewController alloc]init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            
        } else if (indexPath.row == 2) {
            BDInviteViewController *vc = [[BDInviteViewController alloc]init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            BDMessageCenterViewController *vc = [[BDMessageCenterViewController alloc]init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            BDMembershipCodeViewController *vc = [[BDMembershipCodeViewController alloc]init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            
        } else if (indexPath.row == 3) {
            BDSettingViewController *vc = [[BDSettingViewController alloc]init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
@end
