//
//  BDMyOrderItemView.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/11.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDMyOrderItemView.h"
#import "BDMyOrderItemCell.h"
#import "BDMyOrderDetailViewController.h"
#import "MLNavigationController.h"

static NSString *const _bdMyOrderItemCell = @"BDMyOrderItemCell";

@interface BDMyOrderItemView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation BDMyOrderItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
//        [self initData];
    }
    return self;
}

- (void)initUI {
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.rowHeight = 240;
    _tableView.separatorColor = [UIColor hexChangeFloat:__kSL_Line_01];
    [_tableView registerNib:[UINib nibWithNibName:@"BDMyOrderItemCell" bundle:nil] forCellReuseIdentifier:_bdMyOrderItemCell];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:_tableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDMyOrderItemCell *cell = [tableView dequeueReusableCellWithIdentifier:_bdMyOrderItemCell];
//    [cell setDataWithBean:bean];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BDMyOrderDetailViewController *vc = [[BDMyOrderDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
@end
