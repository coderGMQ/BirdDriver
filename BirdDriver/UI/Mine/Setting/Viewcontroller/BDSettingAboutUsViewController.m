//
//  BDSettingAboutUsViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/14.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDSettingAboutUsViewController.h"

@interface BDSettingAboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation BDSettingAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"关于我们";
    
    _tableView = [[UITableView alloc] initWithFrame:self.__contentView.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.rowHeight = 43;
    _tableView.separatorColor = [UIColor hexChangeFloat:__kSL_Line_01];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.__contentView addSubview:_tableView];
    [self addHeaderView];
}

- (void)addHeaderView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __gScreenWidth, 212)];
    headView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageNamed:@"Mine_setting_headIcon"];
    [headView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.centerX.mas_equalTo(headView);
        make.width.mas_equalTo(87);
        make.height.mas_equalTo(87);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"版本号";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_12];
    titleLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_02];
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(15);
        make.centerX.mas_equalTo(headView);
    }];
    
    UILabel *versionLabel = [[UILabel alloc]init];
    NSDictionary *infoPlist = [[NSBundle mainBundle]infoDictionary];
    NSString *app_Version = [infoPlist objectForKey:@"CFBundleShortVersionString"];
    versionLabel.text = [NSString stringWithFormat:@"Ver %@",app_Version];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_02];
    versionLabel.font = [UIFont systemFontOfSize:__kSL_Text_11];
    [headView addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(headView);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    [headView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(7);
    }];

    _tableView.tableHeaderView = headView;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"kCellIdentifier_mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:__kSL_Text_14];
        cell.textLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *title;
    if (indexPath.row == 0) {
        title = @"AAAA说明";
    } else if (indexPath.row == 1) {
        title = @"BBBB说明";
    }
    cell.textLabel.text = title;
    return cell;
}
@end
