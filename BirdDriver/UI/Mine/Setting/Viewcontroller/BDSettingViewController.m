//
//  BDSettingViewController.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/14.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDSettingViewController.h"
#import "UIImage+GIF.h"
#import "LBClearCacheTool.h"
#import "iToast.h"
#import "BDCleanCacheCell.h"
#import "BDAboutUsCell.h"
#import "BDSettingAboutUsViewController.h"

static NSString *const _bdCleanCache = @"BDCleanCache";
static NSString *const _bdAboutUsCell = @"BDAboutUsCell";

@interface BDSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, assign) CGRect contantViewF;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@end

@implementation BDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"设置";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __gScreenWidth, self.__contentView.height-44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.rowHeight = 43;
    _tableView.separatorColor = [UIColor hexChangeFloat:__kSL_Line_01];
    [_tableView registerNib:[UINib nibWithNibName:@"BDCleanCacheCell" bundle:nil] forCellReuseIdentifier:_bdCleanCache];
    [_tableView registerNib:[UINib nibWithNibName:@"BDAboutUsCell" bundle:nil] forCellReuseIdentifier:_bdAboutUsCell];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.__contentView addSubview:_tableView];
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.height.mas_equalTo(self.__contentView.height-44);
//        make.left.mas_equalTo(0);
//        make.width.mas_equalTo(__gScreenWidth);
//    }];
    
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor hexChangeFloat:__kSL_Red];
    [_tableView addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-120);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(__gScreenWidth);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage sd_animatedGIFNamed:@"Mine_setting_clearCache"];
    [_headView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headView.mas_centerY);
        make.centerX.mas_equalTo(self.headView.mas_centerX);
        make.width.mas_equalTo(375);
        make.height.mas_equalTo(75);
    }];
    
    UIButton *loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_15];
    [loginOutBtn setTitleColor:[UIColor hexChangeFloat:__kSL_White_01] forState:UIControlStateNormal];
    [loginOutBtn setBackgroundColor:[UIColor hexChangeFloat:__kSL_Blue_01]];
    [loginOutBtn setTitle:@"退出账号" forState:UIControlStateNormal];
    [self.__contentView addSubview:loginOutBtn];
    [loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BDCleanCacheCell *cell = (BDCleanCacheCell *)[tableView dequeueReusableCellWithIdentifier:_bdCleanCache];
        NSString *filePath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        cell.cacheLabel.text = [LBClearCacheTool getCacheSizeWithFilePath:filePath];
        return cell;
    } else {
        BDAboutUsCell *cell = (BDAboutUsCell *)[tableView dequeueReusableCellWithIdentifier:_bdAboutUsCell];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [UIView animateWithDuration:1.0 animations:^{
            
            CGRect tableViewF = self.tableView.frame;
            tableViewF.origin.y = 120;
            self.tableView.frame = tableViewF;
            
//            CGRect headViewF = self.headView.frame;
//            headViewF.origin.y = -120;
//            self.headView.frame = headViewF;
            
//            [self.tableView bringSubviewToFront:self.headView];
            self.headView.backgroundColor = [UIColor greenColor];
//            self.__contentView.backgroundColor = [UIColor blackColor];

            [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(120);
                make.left.mas_equalTo(0);
                make.height.mas_equalTo(120);
                make.width.mas_equalTo(__gScreenWidth);
            }];
            [self.tableView addSubview:self.headView];
        } completion:^(BOOL finished) {
//            CGRect tableViewF = self.tableView.frame;
//            tableViewF.origin.y = 0;
//            self.tableView.frame = tableViewF;
        }];
    } else if (indexPath.row == 1) {
        BDSettingAboutUsViewController *vc = [[BDSettingAboutUsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)addGestureRecognizer:(UIView *)view {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap:)];
    [view addGestureRecognizer:tap];
}

- (void)viewTap:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == 200) {
        [UIView animateWithDuration:1.0 animations:^{
//            CGRect contantViewF = self.contantView.frame;
//            self.contantViewF = contantViewF;
//            contantViewF.origin.y = 0;
//            self.contantView.frame = contantViewF;
            
            //清楚缓存
            NSString *filePath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            BOOL isSuccess = [LBClearCacheTool clearCacheWithFilePath:filePath];
            if (isSuccess) {
                [[[iToast makeText:@"清除完成"] setGravity:iToastGravityCenter] show];
            }
        }];
//        [UIView animateWithDuration:1.0 animations:^{
//            CGRect contantViewF = self.contantView.frame;
//            self.contantViewF = contantViewF;
//            contantViewF.origin.y = 0;
//            self.contantView.frame = contantViewF;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:1.0 animations:^{
//                CGRect contantViewF = self.contantView.frame;
//                self.contantViewF = contantViewF;
//                contantViewF.origin.y = -120;
//                self.contantView.frame = contantViewF;
//            }];
//        }];
    } else if (tap.view.tag == 201) {
        
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat contentOffset = scrollView.contentOffset.y;
//    NSLog(@"%f",contentOffset);
//    if (contentOffset <= -120) {
////        NSLog(@"120===");
////        [UIView animateWithDuration:1.0 animations:^{
////            CGRect contantViewF = self.contantView.frame;
////            contantViewF.origin.y = 120;
////            self.contantView.frame = contantViewF;
////        }];
//
//        [UIView animateWithDuration:1.0 animations:^{
//
//            CGRect tableViewF = self.tableView.frame;
//            tableViewF.origin.y = 120;
//            self.tableView.frame = tableViewF;
//
//            //            CGRect headViewF = self.headView.frame;
//            //            headViewF.origin.y = -120;
//            //            self.headView.frame = headViewF;
//
//            [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(-120);
//                make.left.mas_equalTo(0);
//                make.height.mas_equalTo(120);
//                make.width.mas_equalTo(__gScreenWidth);
//            }];
//        } completion:^(BOOL finished) {
//            CGRect tableViewF = self.tableView.frame;
//            tableViewF.origin.y = 0;
//            self.tableView.frame = tableViewF;
//        }];
//
//    } else {
//        CGRect contantViewF = self.contantView.frame;
//        contantViewF.origin.y = 0;
//        self.contantView.frame = contantViewF;
//    }
//}

@end