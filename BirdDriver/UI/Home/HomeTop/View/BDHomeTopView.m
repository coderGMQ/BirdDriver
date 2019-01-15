//
//  BDHomeTopView.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/8.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDHomeTopView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "BDHomeTopCell.h"
#import "BDHomeTopBean.h"

static NSString *const _bdHomeTopCell = @"BDHomeTopCell";

@interface BDHomeTopView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation BDHomeTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    NSArray *imageNames = @[@"home_top_background",@"home_top_background",@"home_top_background"];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, __gScreenWidth, 195) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self addSubview:cycleScrollView];
    
    // 首页3个功能键
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    CGFloat itemW = __gScreenWidth/4;
    CGFloat itemH = 115;
    layout.itemSize = CGSizeMake(itemW, itemH);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleScrollView.frame), __gScreenWidth, itemH) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"BDHomeTopCell" bundle:nil] forCellWithReuseIdentifier:_bdHomeTopCell];
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(cycleScrollView.mas_bottom).offset(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDHomeTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_bdHomeTopCell forIndexPath:indexPath];
    BDHomeTopBean *bean = [self.dataSource safeObjectAtIndex:indexPath.row];
    [cell setDataWithBean:bean];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - get method

- (NSArray *)dataSource {
    if (!_dataSource) {
        NSDictionary *dic0 = @{@"title":@"最新货源",@"imageName":@"home_top_goods"};
        NSDictionary *dic1 = @{@"title":@"货源列表",@"imageName":@"home_top_list"};
        NSDictionary *dic2 = @{@"title":@"添加线路",@"imageName":@"home_top_line"};
        NSDictionary *dic3 = @{@"title":@"最新活动",@"imageName":@"home_top_activity"};
        BDHomeTopBean *bean0 = [[BDHomeTopBean alloc]initDataWithDic:dic0];
        BDHomeTopBean *bean1 = [[BDHomeTopBean alloc]initDataWithDic:dic1];
        BDHomeTopBean *bean2 = [[BDHomeTopBean alloc]initDataWithDic:dic2];
        BDHomeTopBean *bean3 = [[BDHomeTopBean alloc]initDataWithDic:dic3];
        _dataSource = @[bean0,bean1,bean2,bean3];
    }
    return _dataSource;
}
@end
