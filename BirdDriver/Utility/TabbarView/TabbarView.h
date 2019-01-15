//
//  TabbarView.h
//  SmartLife
//
//  Created by Potter on 2017/2/27.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TabbarType) {
    TabbarHome = 0,      //首页
    TabbarOrder,         // 下单
    TabbarMessage,       // 消息
    TabbarMine,          //我的
};

typedef NS_ENUM(NSInteger, TabbarEnterType) {
    TabbarEnterClick,       // 单击进入
    TabbarEnterLongPress,   // 长按进入
};

@interface TabbarBean : NSObject
@property (nonatomic,strong)NSString *icon;
@property (nonatomic,strong)NSString *selectIcon;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)TabbarType type;
- (instancetype)initWithIcon:(NSString *)icon slectIcon:(NSString *)selectIcon title:(NSString *)title type:(TabbarType)type;
@end

@protocol TabbarViewDelegate <NSObject>
- (void)didClickItemWithType:(TabbarType)type enterType:(TabbarEnterType)enterType;
@end

@interface TabbarView : UIView
@property (nonatomic,readonly)TabbarType currentItem;
@property (nonatomic,weak)id<TabbarViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;
//显示某个tabBar
- (void)showTabWithType:(TabbarType)type;
@end

@class TarbarItemView;
@protocol TarbarItemViewDelegate <NSObject>

- (void)didClickItem:(TarbarItemView *)item bean:(TabbarBean *)bean enterType:(TabbarEnterType)enterType;

@end

@interface TarbarItemView : UIView
@property (nonatomic,assign)BOOL highlighted;
@property (nonatomic,weak)id<TarbarItemViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame bean:(TabbarBean*)bean;
- (void)setRedViewHide:(BOOL)hidden;
@end
