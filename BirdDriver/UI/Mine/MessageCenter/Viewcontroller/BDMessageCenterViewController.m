//
//  BDMessageCenterViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/11.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDMessageCenterViewController.h"
#import "BDMessageCenterCell.h"
#import "BDMessageCenterDetailViewController.h"

static NSString *const _bdMessageCenterCell = @"BDMessageCenterCell";

@interface BDMessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation BDMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"消息中心";
    _tableView = [[UITableView alloc] initWithFrame:self.__contentView.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.rowHeight = 150;
    [_tableView registerNib:[UINib nibWithNibName:@"BDMessageCenterCell" bundle:nil] forCellReuseIdentifier:_bdMessageCenterCell];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.__contentView addSubview:_tableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDMessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:_bdMessageCenterCell];
    //    [cell setDataWithBean:bean];
    if (indexPath.section == 0) {
        [cell isNeedSetTop:YES];
    } else {
        [cell isNeedSetTop:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BDMessageCenterDetailViewController *vc = [[BDMessageCenterDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
@end
