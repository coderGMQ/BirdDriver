//
//  BDInviteViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/10.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDInviteViewController.h"
#import "BDInviteHeadView.h"

@interface BDInviteViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation BDInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"邀请有礼";
    
    _tableView = [[UITableView alloc] initWithFrame:self.__contentView.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.rowHeight = 50;
    _tableView.separatorColor = [UIColor hexChangeFloat:__kSL_Line_01];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.__contentView addSubview:_tableView];
    [self addHeaderView];
    [self addFooterView];
}

- (void)addHeaderView {
    BDInviteHeadView *headView = [[BDInviteHeadView alloc]initWithFrame:CGRectMake(0, 0, __gScreenWidth, 430)];
    _tableView.tableHeaderView = headView;
}

- (void)addFooterView {
    UIView *footView = [[UIView alloc]init];
    footView.height = 60;
    
    UILabel *peopleL = [[UILabel alloc]init];
    peopleL.text = @"总邀请人数:10人";
    peopleL.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    peopleL.font = [UIFont systemFontOfSize:__kSL_Text_11];
    [footView addSubview:peopleL];
    [peopleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-20);
    }];
    
    UILabel *moneyL = [[UILabel alloc]init];
    moneyL.text = @"总邀请奖励:100元";
    moneyL.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    moneyL.font = [UIFont systemFontOfSize:__kSL_Text_11];
    [footView addSubview:moneyL];
    [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(peopleL.mas_bottom).offset(10);
        make.left.mas_equalTo(peopleL.mas_left);
    }];
    
    _tableView.tableFooterView = footView;

}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"kCellIdentifier_mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:__kSL_Text_12];
        cell.textLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = @"2018-12-15";
    return cell;
}

@end
