//
//  BDSubscribeSourceView.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/8.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDSubscribeSourceView.h"

@interface BDSubscribeSourceView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BDSubscribeSourceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.scrollEnabled = NO;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.rowHeight = 70;
    _tableView.separatorColor = [UIColor hexChangeFloat:__kSL_Line_01];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(__gScreenWidth);
        make.bottom.mas_equalTo(0);
    }];
    [self addHeaderView];
}

- (void)addHeaderView {
    CGFloat height = 35;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __gScreenWidth, height)];
    
    UILabel *subscribeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 35)];
    subscribeLabel.text = @"订阅货源";
    subscribeLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    subscribeLabel.font = [UIFont systemFontOfSize:__kSL_Text_15];
    [headView addSubview:subscribeLabel];
    
    UIButton *subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_13];
    subscribeBtn.frame = CGRectMake(__gScreenWidth-75, 0, 60, 35);
    [subscribeBtn setTitleColor:[UIColor hexChangeFloat:@"4D76FD"] forState:UIControlStateNormal];
    [subscribeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [subscribeBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [headView addSubview:subscribeBtn];
    
    _tableView.tableHeaderView = headView;
}

- (void)btnClick:(UIButton *)btn {
    
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
        cell.textLabel.font = [UIFont systemFontOfSize:__kSL_Text_15];
        cell.textLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
