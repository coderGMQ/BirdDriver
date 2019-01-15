//
//  UIView+Placehold.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum PlaceholdType{
    PlaceholdNoData,           //没数据
    PlaceholdNoDataNoPic,      //没数据且不展示占位图片
    PlaceholdRetry,            //重试
    PlaceholdLoading,          //正在加载
    PlaceholdSmart             //智能判断
}PlaceholdType;


@interface PlaceholdData : NSObject

+ (PlaceholdData *)dataWithType:(PlaceholdType)type;

// smart类型初始化
+ (PlaceholdData *)smartDataWithSecondType:(PlaceholdType)secondType placeTip:(NSString *)placeTip scrollView:(UIScrollView *)scrollView error:(NSError *)error target:(id)target ;

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeTip:(NSString *)placeTip;

+ (PlaceholdData *)dataWithType:(PlaceholdType)type backgroundColor:(UIColor*)backgroundColor;

+ (PlaceholdData *)dataWithType:(PlaceholdType)type backgroundColor:(UIColor*)backgroundColor placeTip:(NSString *)placeTip placeBtnTitle:(NSString *)placeBtnTitle btnAction:(SEL)btnAction target:(id)target;

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeImage:(NSString *)placeImage;

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeImage:(NSString *)placeImage placeTip:(NSString *)placeTip;

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeImage:(NSString *)placeImage placeTip:(NSString *)placeTip placeBtnTitle:(NSString *)placeBtnTitle;

+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeImage:(NSString *)placeImage placeTip:(NSString *)placeTip placeBtnTitle:(NSString *)placeBtnTitle offset:(CGPoint)offset;

//默认可点击
+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeImage:(NSString *)placeImage placeTip:(NSString *)placeTip placeBtnTitle:(NSString *)placeBtnTitle offset:(CGPoint)offset btnAction:(SEL)btnAction target:(id)target;

//默认可点击
+ (PlaceholdData *)dataWithType:(PlaceholdType)type placeTip:(NSString *)placeTip placeTipNumberOfLines:(NSInteger)placeTipNumberOfLines offsetScale:(CGPoint)offsetScale btnAction:(SEL)btnAction target:(id)target;

@property (nonatomic,assign)PlaceholdType type;                 //占位符类型
@property (nonatomic,assign)PlaceholdType secondType;           //二级占位符类型,当type为PlaceholdSmart时,需要标示
@property (nonatomic,strong)NSString * placeImage;              //占位的图片  默认:tips_empty
@property (nonatomic,strong)NSString * placeTip;                //占位提示文本
@property (nonatomic,assign)NSInteger placeTipNumberOfLines;    //占位提示文本的行数 默认1行
@property (nonatomic,strong)NSString * placeBtnTitle;           //按钮的标题
@property (nonatomic,assign)CGPoint offset;                     //上下左右微调位置-只是上下移动，整体高度宽度不变
@property (nonatomic,assign)CGPoint offsetScale;                //上下左右微调位置-宽度和高度随着更改-eg.offsetScale.y = 20 即:上下分别向内缩20像素 整体高度减少40像素
@property (nonatomic,assign)SEL btnAction;                      //按钮的事件  默认 如果是PlaceholdRetry需要实现此方法 retryClick
@property (nonatomic,weak)id target;                            //按钮响应者
@property (nonatomic,strong)UIColor * backgroundColor;          //背景色
@property (nonatomic,assign)BOOL needTouchView;                 //是否需要点击页面回调，如果需要需要设置btnAction和target回调 默认:不需要
@property (nonatomic,assign)BOOL onlySearchCurrentView;         //在移除的时候 YES:只查询当前View一层子视图 NO:查询当前View的所有子视图 默认值YES
@property (nonatomic,strong) UIColor *textColor;            // 文字颜色
@property (nonatomic,strong) UIScrollView *scrollView;      // 列表页面的scroolView,如UITableView 或者 UICollectionView,使用PlaceholdSmart时,必须配置该属性
@property (nonatomic,strong) NSError *error; //在使用PlaceholdSmart时,如果配置了error,就会在调用reloadPlaceholdWithData时,加载上重试的页面
@end

@interface UIView (Placehold)

//增加占位符
- (void)addPlaceholdWithData:(PlaceholdData *)placeData;

//移除占位符  一般只要告诉占位符类型即可
- (void)removePlaceholdWithData:(PlaceholdData *)placeData animation:(BOOL)animation;

//移除所有占位符
- (void)removeAllPlaceholdWithAnimation:(BOOL)animation;

// 智能reload
- (void)reloadPlaceholdWithData:(PlaceholdData *)placeData;

// 刷新placehold位置
- (void)refreshPlaceholdFrame;
@end



