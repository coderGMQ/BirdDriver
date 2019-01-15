//
//  MLCommonScroolView.h
//  ECalendar-Pro
//
//  Created by Potter on 15/5/7.
//  Copyright (c) 2015年 etouch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    MLCommonScroolHeadMidLine,            // 项目之间一根线   default
    MLCommonScroolHeadMidNoLine,          // 项目之间没有线
    MLCommonScroolHeadTwoLevel,           // 两层label
    MLCommonScroolHeadBlueSelected,       // 选中后颜色是蓝色
    MLCommonScroolHeadFlood,              // 涌入效果 (填充)
    MLCommonScroolSelected,               // 字体选中效果
    MLCommonScroolHeadBlueUnderline,      // 选中后颜色是蓝色并带有蓝色下划线
    MLCommonScroolHeadBlueUnderlineAndSpot, // 选中后颜色是蓝色并带有蓝色下划线并带有红点
}MLCommonScroolHeadStyle;

typedef NS_ENUM(NSUInteger, MLCommonScroolredViewType) {
    MLCommonScroolredViewNone,  // 默认什么都没有
    MLCommonScroolredViewNum,   // 带数字的红点
    MLCommonScroolredViewNoNum, // 只是红点 不带数字
};

#define mark - headView
@protocol MLCommonScroolHeadViewDelegate <NSObject>
//将要移动到哪个位置
- (void)headViewMoveToIndex:(NSInteger)index;
@end

@interface MLCommonScroolHeadView : UIScrollView
@property (nonatomic,strong)NSArray * titleArr;
@property (nonatomic,weak)id<MLCommonScroolHeadViewDelegate>headDelegate;
@property (nonatomic,assign)CGFloat headItemWidth;
- (void)moveTitle:(NSNumber *)index;
- (instancetype)initWithFrame:(CGRect)frame andType:(MLCommonScroolHeadStyle)type andDefaultPage:(NSInteger)defaultPage;
- (UIView *)getRedViewWithIndex:(NSInteger)index;
@end

@protocol MLCommonScroolViewDelegate <NSObject>
@optional
//将要移动到哪个位置
- (void)topScrollViewWillMoveToIndex:(NSInteger)index andTitle:(NSString *)title andView:(UIView *)view;
@end

@interface MLCommonScroolView : UIView<UIScrollViewDelegate,MLCommonScroolHeadViewDelegate>
@property (nonatomic,assign)BOOL scrollEnabled;
@property (nonatomic,strong)UIView * customHeadView;               //用户自定义头部View 一般不使用
@property (nonatomic,strong)NSArray * titleArr;                    //头部数据内容
@property (nonatomic,strong)NSMutableArray * contentViewArr;       //存放内容View的容器
@property (nonatomic,assign)NSInteger defaultPage;                 //启动显示哪一个页面 default:0
@property (nonatomic,readonly)NSInteger currentPage;               //当前显示的页面index
@property (nonatomic,readonly)UIView * currentView;                //当前显示的页面
@property (nonatomic,assign)CGFloat headItemWidth;
@property (nonatomic,weak)id<MLCommonScroolViewDelegate>delegate;
@property (nonatomic,assign)MLCommonScroolredViewType redViewType;   // 红色view的类型
- (instancetype)initWithFrame:(CGRect)frame andType:(MLCommonScroolHeadStyle)type defaultPage:(NSInteger)defaultPage;
//跳转到哪个页面
- (void)switchTableAsIndex:(NSInteger)index;
- (void)setRedNum:(NSInteger)redNum index:(NSInteger)index;
@end
