//
//  UIView+Placehold.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "UIView+Placehold.h"
#import "ErrorTipView.h"

#define LOADING_VIEW_TAG      999999
#define NODATA_VIEW_TAG       999998
#define NODATANOPIC_VIEW_TAG  999997
#define RETRY_VIEW_TAG        999996

@implementation PlaceholdData

- (id)init{
    self = [super init];
    if(self){
        _offset = CGPointZero;
        _onlySearchCurrentView = YES;
    }
    return self;
}

+ (PlaceholdData *)dataWithType:(PlaceholdType)type{
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = type;
    return data;
}

// smart类型初始化
+ (PlaceholdData *)smartDataWithSecondType:(PlaceholdType)secondType placeTip:(NSString *)placeTip scrollView:(UIScrollView *)scrollView error:(NSError *)error target:(id)target {
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = PlaceholdSmart;
    data.secondType = secondType;
    data.placeTip = placeTip;
    data.scrollView = scrollView;
    data.error = error;
    data.target = target;
    return data;
}

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeTip:(NSString *)placeTip
{
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = type;
    data.placeTip = placeTip;
    return data;
}

+ (PlaceholdData *)dataWithType:(PlaceholdType)type backgroundColor:(UIColor*)backgroundColor{
    
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = type;
    data.backgroundColor = backgroundColor;
    return data;
}

+ (PlaceholdData *)dataWithType:(PlaceholdType)type backgroundColor:(UIColor*)backgroundColor placeTip:(NSString *)placeTip placeBtnTitle:(NSString *)placeBtnTitle btnAction:(SEL)btnAction target:(id)target{
    
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = type;
    data.backgroundColor = backgroundColor;
    data.placeTip = placeTip;
    data.placeBtnTitle = placeBtnTitle;
    data.btnAction = btnAction;
    data.target = target;
    return data;
}

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeImage:(NSString *)placeImage{
    
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = type;
    data.placeImage = placeImage;
    return data;
}

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeImage:(NSString *)placeImage placeTip:(NSString *)placeTip{
    
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = type;
    data.placeImage = placeImage;
    data.placeTip = placeTip;
    return data;
}

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeImage:(NSString *)placeImage placeTip:(NSString *)placeTip placeBtnTitle:(NSString *)placeBtnTitle{
    
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = type;
    data.placeImage = placeImage;
    data.placeTip = placeTip;
    data.placeBtnTitle = placeBtnTitle;
    return data;
}

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeImage:(NSString *)placeImage placeTip:(NSString *)placeTip placeBtnTitle:(NSString *)placeBtnTitle offset:(CGPoint)offset{
    
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = type;
    data.placeImage = placeImage;
    data.placeTip = placeTip;
    data.placeBtnTitle = placeBtnTitle;
    data.offset = offset;
    return data;
}

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeImage:(NSString *)placeImage placeTip:(NSString *)placeTip placeBtnTitle:(NSString *)placeBtnTitle offset:(CGPoint)offset btnAction:(SEL)btnAction target:(id)target{
    
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = type;
    data.placeImage = placeImage;
    data.placeTip = placeTip;
    data.placeBtnTitle = placeBtnTitle;
    data.offset = offset;
    data.btnAction = btnAction;
    data.target = target;
    data.needTouchView = YES;
    return data;
}

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeTip:(NSString *)placeTip placeTipNumberOfLines:(NSInteger)placeTipNumberOfLines offsetScale:(CGPoint)offsetScale btnAction:(SEL)btnAction target:(id)target{
    
    PlaceholdData * data = [[PlaceholdData alloc] init];
    data.type = type;
    data.placeTip = placeTip;
    data.placeTipNumberOfLines = placeTipNumberOfLines;
    data.offsetScale = offsetScale;
    data.btnAction = btnAction;
    data.target = target;
    data.needTouchView = YES;
    return data;
}

@end

@implementation UIView (Placehold)

- (void)addPlaceholdWithData:(PlaceholdData *)placeData{
    
    if(!placeData){
        return;
    }
    
    NSInteger viewTag = 0;
    ErrorType errorType = ErrorNone;
    CGFloat height = 0;
    switch (placeData.type){
        case PlaceholdNoData:
        {
            viewTag = NODATA_VIEW_TAG;
            errorType = ErrorNoData;
            
            height = (errorImageHeight+40);  //placeTip行高一行时候高度
            if(placeData.placeTipNumberOfLines > 1){
                height = (errorImageHeight+20) + 20*placeData.placeTipNumberOfLines;
            }
            break;
        }
        case PlaceholdNoDataNoPic:
        {
            viewTag = NODATANOPIC_VIEW_TAG;
            errorType = ErrorNoDataNoPic;
            height = 40;  //placeTip行高一行时候高度
            if(placeData.placeTipNumberOfLines > 1){
                height = 20 + 20*placeData.placeTipNumberOfLines;
            }
            break;
        }
           
        case PlaceholdRetry:
        {
            viewTag = RETRY_VIEW_TAG;
            errorType = ErrorNoNet;
            height = 70;
            if(placeData.placeTipNumberOfLines > 1){
                height = 50 + 20*placeData.placeTipNumberOfLines;
            }
            break;
        }
            
        case PlaceholdLoading:
        {
            viewTag = LOADING_VIEW_TAG;
            errorType = ErrorLoading;
            height = self.height;
            break;
        }
        default:
            break;
    }
    
    UIView * tempView = [self viewWithTag:viewTag onlySearchCurrentView:placeData.onlySearchCurrentView];
    if(tempView){
        [tempView removeFromSuperview];
        tempView = nil;
    }
    
    tempView = [[UIView alloc] initWithFrame:CGRectMake(placeData.offset.x+placeData.offsetScale.x, placeData.offset.y+placeData.offsetScale.y, self.frame.size.width-placeData.offset.x-2*placeData.offsetScale.x, self.frame.size.height-placeData.offset.y-2*placeData.offsetScale.y)];
    tempView.backgroundColor = placeData.backgroundColor;
    tempView.tag = viewTag;
    
    ErrorTipView * tipView = [[ErrorTipView alloc] initWithFrame:CGRectMake(0,(tempView.frame.size.height-height)/2, tempView.frame.size.width, height) andErrorType:errorType];
    if (placeData.textColor) {
        tipView.textColor = placeData.textColor;
    }
    if (!placeData.btnAction) {
        placeData.btnAction = NSSelectorFromString(@"retryClick");
    }
    tipView.errorAction = placeData.btnAction;
    tipView.target = placeData.target;
    tipView.errorImg = placeData.placeImage;
    tipView.errorTip = placeData.placeTip;
    tipView.errorBtnTitle = placeData.placeBtnTitle;
    tipView.errorTipNumberOfLine = placeData.placeTipNumberOfLines;
    tipView.needTouchView = placeData.needTouchView;
    [tempView addSubview:tipView];
    [self addSubview:tempView];
}

//移除占位符  一般只要告诉占位符类型即可
- (void)removePlaceholdWithData:(PlaceholdData *)placeData animation:(BOOL)animation{
    
    NSInteger viewTag;
    switch (placeData.type){
        case PlaceholdNoData:
        {
            viewTag = NODATA_VIEW_TAG;
            break;
        }
        case PlaceholdNoDataNoPic:
        {
            viewTag = NODATANOPIC_VIEW_TAG;
            break;
        }
        case PlaceholdRetry:
        {
            viewTag = RETRY_VIEW_TAG;
            break;
        }
        case PlaceholdLoading:
        {
            viewTag = LOADING_VIEW_TAG;
            break;
        }
        default:
            viewTag = 9099999;
            break;
    }

    UIView * tempView = [self viewWithTag:viewTag onlySearchCurrentView:placeData.onlySearchCurrentView];
    if(tempView){
        
        if(animation){
            [UIView animateWithDuration:0.6 animations:^{
                [tempView setAlpha:0];
            }completion:^(BOOL finished){
                [tempView removeFromSuperview];
            }];
        }else{
            [tempView removeFromSuperview];
        }
    }
}

//移除所有占位符
- (void)removeAllPlaceholdWithAnimation:(BOOL)animation{
    [self removePlaceholdWithData:[PlaceholdData dataWithType:PlaceholdNoData] animation:animation];
    [self removePlaceholdWithData:[PlaceholdData dataWithType:PlaceholdNoDataNoPic] animation:animation];
    [self removePlaceholdWithData:[PlaceholdData dataWithType:PlaceholdRetry] animation:animation];
    [self removePlaceholdWithData:[PlaceholdData dataWithType:PlaceholdLoading] animation:animation];
}

// 智能reload
- (void)reloadPlaceholdWithData:(PlaceholdData *)placeData {
    [self removeAllPlaceholdWithAnimation:YES];
    [self performOurSelector:placeData.scrollView selector:@"reloadData"];
    if (placeData.type == PlaceholdSmart) {
        if (placeData.scrollView && [placeData.scrollView isKindOfClass:[UIScrollView class]]) {
            if (placeData.error) {
                placeData.type = PlaceholdRetry;
                placeData.placeTip = @"网络已走丢,请刷新重试";
                [self addPlaceholdWithData:placeData];
            } else {
                NSInteger itemCount = [self itemsCountWithScroolView:placeData.scrollView];
                if (itemCount == 0) {
                    placeData.type = placeData.secondType;
                    [self addPlaceholdWithData:placeData];
                }
            }
        } else {
            NSLog(@"使用PlaceholdSmart 类型时,需要在placeData中配上scrollView这个属性");
        }
    } else {
        [self addPlaceholdWithData:placeData];
    }
}

// 刷新placehold位置
- (void)refreshPlaceholdFrame {
    NSArray *tempArray = @[@(LOADING_VIEW_TAG),@(NODATA_VIEW_TAG),@(NODATANOPIC_VIEW_TAG),@(RETRY_VIEW_TAG)];
    for (NSNumber *tagNum in tempArray) {
        UIView *tempView = [self viewWithTag:[tagNum integerValue] onlySearchCurrentView:YES];
        if(tempView){
            CGFloat X = (self.width - tempView.width)/2;
            CGFloat Y = (self.height - tempView.height)/2;
            tempView.frame = CGRectMake(X, Y, tempView.width, tempView.height);
        }
    }
}

- (void)performOurSelector:(id)target selector:(NSString *)selector {
    SEL newSelector = NSSelectorFromString(selector);
    if ([target respondsToSelector:newSelector]) {
        [target performSelector:newSelector withObject:nil afterDelay:0.0];
    }
}

- (NSInteger)itemsCountWithScroolView:(UIScrollView *)scroolView
{
    NSInteger items = 0;
    
    // UIScollView doesn't respond to 'dataSource' so let's exit
    if (![scroolView respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    
    // UITableView support
    if ([scroolView isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)scroolView;
        id <UITableViewDataSource> dataSource = tableView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource tableView:tableView numberOfRowsInSection:section];
            }
        }
    }
    // UICollectionView support
    else if ([scroolView isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)scroolView;
        id <UICollectionViewDataSource> dataSource = collectionView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
            }
        }
    }
    
    return items;
}

- (UIView *)viewWithTag:(NSInteger)tag onlySearchCurrentView:(BOOL)onlyCurrent{
    
    UIView * resultView = nil;
    if(onlyCurrent){
        for(UIView * subView in self.subviews){
            if(subView.tag == tag){
                resultView = subView;
                break;
            }
        }
    }else{
        resultView = [self viewWithTag:tag];
    }
    return resultView;
}
@end


