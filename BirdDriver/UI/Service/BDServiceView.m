//
//  BDServiceView.m
//  BirdDriver
//
//  Created by 甘明强 on 2018/12/28.
//  Copyright © 2018年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDServiceView.h"
#import "BDServiceBean.h"
#import "BDServiceCell.h"
#import "BDServiceHeadView.h"

static NSString *const _bdServiceCell = @"BDServiceCell";
static NSString *const _bdServiceHeadView = @"BDServiceHeadView";

#define itemW  __gScreenWidth/4

@interface BDServiceView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}
@property (nonatomic, strong) NSArray *functionArray;
@property (nonatomic, strong) NSArray *serviceArray;
@end

@implementation BDServiceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.title = @"更多服务";
    self.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    self.__navigationView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    self.__statusBarView.backgroundColor = [UIColor hexChangeFloat:__kSL_Background];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(itemW, 120);
    _collectionView = [[UICollectionView alloc]initWithFrame:self.__contentView.bounds collectionViewLayout:layout];
    // 注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"BDServiceCell" bundle:nil] forCellWithReuseIdentifier:_bdServiceCell];
    // 注册cell的头部视图
    [_collectionView registerClass:[BDServiceHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:_bdServiceHeadView];
    
    _collectionView.scrollEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
    [self.__contentView addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.functionArray.count;
    }else {
        return self.serviceArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDServiceCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:_bdServiceCell forIndexPath:indexPath];
        BDServiceBean *bean = [self.functionArray safeObjectAtIndex:indexPath.row];
        [cell setDataWithBean:bean];
    }else if (indexPath.section == 1) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:_bdServiceCell forIndexPath:indexPath];
        BDServiceBean *bean = [self.serviceArray safeObjectAtIndex:indexPath.row];
        [cell setDataWithBean:bean];
    }
    return cell;
}

// collectionView的头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    BDServiceHeadView *headView = (BDServiceHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:_bdServiceHeadView forIndexPath:indexPath];
    if (indexPath.section == 0) {
        headView.textLabel.text = @"物流工具";
    } else if (indexPath.section == 1) {
        headView.textLabel.text = @"车友服务";
    }
    return headView;
}

// 设置UICollectionView每组头部视图的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(__gScreenWidth, 41);
}
#pragma mark - get method

- (NSArray *)functionArray {
    if (!_functionArray) {
        NSDictionary *parkItem = @{@"imageName": @"service_top_park", @"titleName": @"物流园"};
        NSDictionary *mileageItem = @{@"imageName": @"service_top_mileage", @"titleName": @"里程计算"};
        NSDictionary *parkingItem = @{@"imageName": @"service_top_parking", @"titleName": @"停车场"};
        
        
        NSArray *functionArrayDicTemp = @[parkItem, mileageItem,parkingItem];
        
        NSMutableArray *funcTemp = [NSMutableArray array];
        for (NSDictionary *dic in functionArrayDicTemp) {
            BDServiceBean *bean = [[BDServiceBean alloc]initWithDic:dic];
            [funcTemp addObject:bean];
        }
        _functionArray = [NSArray arrayWithArray:funcTemp];
    }
    return _functionArray;
}

- (NSArray *)serviceArray {
    if (!_serviceArray) {
        NSDictionary *helpItem = @{@"imageName": @"service_top_help", @"titleName": @"救援"};
        NSDictionary *gasStationItem = @{@"imageName": @"service_top_gasStation", @"titleName": @"加油站"};
        NSArray *serviceArrayDicTemp = @[helpItem, gasStationItem];
        
        NSMutableArray *serviceTemp = [NSMutableArray array];
        for (NSDictionary *dic in serviceArrayDicTemp) {
            BDServiceBean *bean = [[BDServiceBean alloc]initWithDic:dic];
            [serviceTemp addObject:bean];
        }
        _serviceArray = [NSArray arrayWithArray:serviceTemp];
    }
    return _serviceArray;
}
@end
