//
//  TabbarView.m
//  SmartLife
//
//  Created by Potter on 2017/2/27.
//
//

#import "TabbarView.h"
//#import "SLUserInfo.h"
#import "AppDelegate.h"
//#import "SLMSCViewController.h"
//#import "SLMSCTool.h"

@implementation TabbarBean
- (instancetype)initWithIcon:(NSString *)icon slectIcon:(NSString *)selectIcon title:(NSString *)title type:(TabbarType)type{
    self = [super init];
    if(self){
        self.icon = icon;
        self.selectIcon = selectIcon;
        self.title = title;
        self.type = type;
    }
    return self;
}
@end

@interface TabbarView()<TarbarItemViewDelegate>
{
    NSArray *_dataSource;
}
@property (nonatomic,strong)UIView *contentView;
@end

static const NSInteger TarbarBaseTag = 100;

@implementation TabbarView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray {
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = [NSArray arrayWithArray:dataArray];
        [self initUI];
        [self initData];
    }
    return self;
}

- (void)initUI {
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 50)];
    [self addSubview:_contentView];
    
    // 黑线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0.5f)];
    line.backgroundColor = [UIColor hexChangeFloat:__kSL_Line_01];
    [_contentView addSubview:line];

    NSInteger count = _dataSource.count;
    float itemWidth = (__gScreenWidth)/(count);
    for (int i =0; i<_dataSource.count; i++) {
        TabbarBean * bean = [_dataSource objectAtIndex:i];
        TarbarItemView * itemView = [[TarbarItemView alloc] initWithFrame:CGRectMake(itemWidth*i, 0, itemWidth, 48) bean:bean];
        itemView.delegate = self;
        itemView.tag = TarbarBaseTag + bean.type;
        [_contentView addSubview:itemView];
    }
   
    _currentItem = TabbarHome;
    TarbarItemView * currentView = (TarbarItemView *)[_contentView viewWithTag:(TarbarBaseTag +_currentItem)];
    currentView.highlighted = YES;
}

- (void)initData {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleHomePageNewNoticeNotification) name:__homePageNewNoticeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleHideHomePageNewNoticeNotification) name:__hideHomePageNewNoticeNotification object:nil];
}

//- (void)handleHomePageNewNoticeNotification {
//    TarbarItemView *itemView = (TarbarItemView *)[_contentView viewWithTag:(TarbarBaseTag +TabbarService)];
//    [itemView setRedViewHide:NO];
//}

//- (void)handleHideHomePageNewNoticeNotification {
//    TarbarItemView *itemView = (TarbarItemView *)[_contentView viewWithTag:(TarbarBaseTag +TabbarService)];
//    [itemView setRedViewHide:YES];
//}
#pragma mark - Public method

- (void)showTabWithType:(TabbarType)type {
    [self switchItemWithType:type enterType:TabbarEnterClick];
}

#pragma mark - TarbarItemViewDelegate

- (void)didClickItem:(TarbarItemView *)item bean:(TabbarBean *)bean enterType:(TabbarEnterType)enterType{
    [self switchItemWithType:bean.type enterType:enterType];
}

- (void)switchItemWithType:(TabbarType)type enterType:(TabbarEnterType)enterType {
    if (type >= TabbarHome && type <= TabbarMine) {
        TarbarItemView * preView = (TarbarItemView *)[_contentView viewWithTag:(TarbarBaseTag +_currentItem)];
        preView.highlighted = NO;
        _currentItem = type;
        TarbarItemView * currentView = (TarbarItemView *)[_contentView viewWithTag:(TarbarBaseTag +_currentItem)];
        currentView.highlighted = YES;
        
        if (_delegate && [_delegate respondsToSelector:@selector(didClickItemWithType:enterType:)]) {
            [_delegate didClickItemWithType:_currentItem enterType:enterType];
        }
    }
}
@end

@interface TarbarItemView()
{
    
}
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)TabbarBean *bean;
@property (nonatomic,strong)UIView *redView;
@end

@implementation TarbarItemView

- (instancetype)initWithFrame:(CGRect)frame bean:(TabbarBean*)bean{
    self = [super initWithFrame:frame];
    if (self) {
        self.bean = bean;
        self.userInteractionEnabled = YES;
        if (self.bean.title) {
            [self initNormalUI];
        } else {
            [self initSpecialUI];
        }
    }
    return self;
}

- (void)initNormalUI {
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-24)/2, 6, 24, 24)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds = NO;
    _imageView.image = [UIImage imageNamed:self.bean.icon];
    _imageView.highlightedImage = [UIImage imageNamed:self.bean.selectIcon];
    [self addSubview:_imageView];
    
    CGFloat height = 33.0f;
    if (__gScreenHeight<=480) {
        height = 30;
    }
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, height,CGRectGetWidth(self.bounds), 12)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:11];
    _label.textColor = [UIColor hexChangeFloat:@"B9BEC2"];
    _label.highlightedTextColor = [UIColor hexChangeFloat:@"4285F4"];
    _label.text = self.bean.title;
    [self addSubview:_label];
    
    _redView = [[UIView alloc] initWithFrame:CGRectMake(_imageView.frame.size.width-8, -2, 8, 8)];
    _redView.backgroundColor = [UIColor hexChangeFloat:@"F75B41"];
    _redView.layer.cornerRadius = 4;
    _redView.layer.masksToBounds = YES;
    _redView.hidden = YES;
    [_imageView addSubview:_redView];
    
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtn.frame = self.bounds;
    clickBtn.showsTouchWhenHighlighted = YES;
    [clickBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clickBtn];
}

- (void)initSpecialUI {
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-65)/2, -16, 65, 65)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds = YES;
    _imageView.image = [UIImage imageNamed:self.bean.icon];
    _imageView.highlightedImage = [UIImage imageNamed:self.bean.selectIcon];
    [self addSubview:_imageView];

    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtn.frame = self.bounds;
    clickBtn.showsTouchWhenHighlighted = YES;
    [clickBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [clickBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpOutside];
    [clickBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchCancel];
    [clickBtn addTarget:self action:@selector(buttonTouchDown) forControlEvents:UIControlEventTouchDown];
    [self addSubview:clickBtn];
}

- (void)buttonClick {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickItem:bean:enterType:)]) {
        [_delegate didClickItem:self bean:self.bean enterType:TabbarEnterClick];
    }
}

- (void)buttonTouchDown {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickItem:bean:enterType:)]) {
        [_delegate didClickItem:self bean:self.bean enterType:TabbarEnterLongPress];
    }
}

- (void)setRedViewHide:(BOOL)hidden {
    _redView.hidden = hidden;
}

#pragma mark - set get Method

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    _label.highlighted = _highlighted;
    _imageView.highlighted = _highlighted;
}
@end
