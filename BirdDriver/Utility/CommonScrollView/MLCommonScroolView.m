//
//  MLCommonScroolView.m
//  ECalendar-Pro
//
//  Created by Potter on 15/5/7.
//  Copyright (c) 2015年 etouch. All rights reserved.
//

#import "MLCommonScroolView.h"
//#import "UIView+SLShadow.h"

CGFloat _headHeight = 44.0f;
CGFloat _btnHeight = 33.0f;
const NSInteger head_button_tag = 1000;
const NSInteger content_view_tag = 2000;
const NSInteger line_view_tag = 3000;
const NSInteger redView_tag = 4000;

@interface MLCommonScroolView()
{
    UIScrollView * _contentScroolView;
    MLCommonScroolHeadView * _headView;
    MLCommonScroolHeadStyle _type;
}
@end

@implementation MLCommonScroolView

- (void)dealloc {
}

- (instancetype)initWithFrame:(CGRect)frame andType:(MLCommonScroolHeadStyle)type defaultPage:(NSInteger)defaultPage {
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _defaultPage = defaultPage;
        if (_type == MLCommonScroolHeadTwoLevel) {
            _headHeight = 55;
            _btnHeight = 40;
        } else if (_type == MLCommonScroolHeadFlood) {
            _headHeight = 44.0f;
            _btnHeight = 36.0f;
        } else if (_type == MLCommonScroolSelected) {
            _headHeight = 46.0f;
            _btnHeight = 35.0f;
        } else if (_type == MLCommonScroolHeadBlueUnderline) {
            _headHeight = 49.0f;
            _btnHeight = 33.0f;
        }
        else
        {
            _headHeight = 44.0f;
            _btnHeight = 33.0f;
        }
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //body scroolView
    _contentScroolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _headHeight, self.frame.size.width, self.frame.size.height-_headHeight)];
    _contentScroolView.pagingEnabled = YES;
    _contentScroolView.delegate = self;
    _contentScroolView.bounces = NO;
    _contentScroolView.showsHorizontalScrollIndicator = NO;
    _contentScroolView.showsVerticalScrollIndicator = NO;
    [self addSubview:_contentScroolView];
    
    //headView
    _headView = [[MLCommonScroolHeadView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _headHeight) andType:_type andDefaultPage:_defaultPage];
    _headView.headDelegate = self;
    [self addSubview:_headView];
}

- (void)layoutSubviews
{
    _headView.contentOffset = CGPointMake(0, 0);
    //修改body frame
    CGRect frame = _contentScroolView.frame;
    frame.origin.y =_headView.frame.origin.y + _headView.frame.size.height;
    frame.size.height = self.frame.size.height - _headView.frame.origin.y - _headView.frame.size.height;
    _contentScroolView.frame = frame;
}

- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = titleArr;
    if (_headView && [_headView respondsToSelector:@selector(setTitleArr:)]) {
        [_headView performSelector:@selector(setTitleArr:) withObject:_titleArr];
    }
}

- (void)setContentViewArr:(NSMutableArray *)contentViewArr {
    _contentViewArr = contentViewArr;
    for (UIView * view in _contentScroolView.subviews) {
        [view removeFromSuperview];
    }
    for (int i =0; i<contentViewArr.count; i++) {
        UIView * view = [contentViewArr objectAtIndex:i];
        view.frame = CGRectMake(_contentScroolView.frame.size.width*i, 0, _contentScroolView.frame.size.width, _contentScroolView.frame.size.height);
        view.tag = content_view_tag + i;
        [_contentScroolView addSubview:view];
    }
    _contentScroolView.contentSize = CGSizeMake(_contentScroolView.frame.size.width*_contentViewArr.count, _contentScroolView.frame.size.height);
    _contentScroolView.contentOffset = CGPointMake(_contentScroolView.frame.size.width*_defaultPage, 0);
    _contentScroolView.scrollEnabled = _scrollEnabled;
}

- (void)setRedNum:(NSInteger)redNum index:(NSInteger)index{
    UIView *redView = [_headView getRedViewWithIndex:index];
    if (_redViewType == MLCommonScroolredViewNoNum) {
        if (redNum > 0) {
            redView.hidden = NO;
        } else {
            redView.hidden = YES;
        }
    }
}

- (UIView *)currentView
{
    return [_contentScroolView viewWithTag:content_view_tag+_currentPage];
}

- (void)moveContent:(NSInteger)index
{
    [_contentScroolView setContentOffset:CGPointMake(_contentScroolView.frame.size.width*index, 0) animated:YES];
}

- (void)moveToIndex:(NSInteger)index
{
    if (index<_titleArr.count) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(topScrollViewWillMoveToIndex:andTitle:andView:)]) {
            NSString * title = [_titleArr objectAtIndex:index];
            UIView * view = [_contentScroolView viewWithTag:content_view_tag+index];
            [_delegate topScrollViewWillMoveToIndex:index andTitle:title andView:view];
        }
        
        //1.移动头
        if ([_headView respondsToSelector:@selector(moveTitle:)]) {
            [_headView performSelector:@selector(moveTitle:) withObject:[NSNumber numberWithInteger:index]];
        }
        //2.移动内容
        [self moveContent:index];
        _currentPage = index;
    }
}

#pragma mark - HeadViewDelegate
- (void)headViewMoveToIndex:(NSInteger)index
{
    [self moveToIndex:index];
}

#pragma mark - ScroolViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)myScrollView{
    CGFloat pageWidth = myScrollView.frame.size.width;
    int page = floor((myScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self moveToIndex:page];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

#pragma mark 外类调用
- (UIView *)getViewAtIndex:(NSUInteger)index
{
    if (index>=_contentViewArr.count) {
        return nil;
    }
    return [_contentViewArr objectAtIndex:index];
}

- (void)replaceViewAtIndex:(NSUInteger)index withObject:(UIView *)view
{
    if (index>=_contentViewArr.count) {
        return;
    }
    UIView * oldView = [_contentScroolView viewWithTag:content_view_tag + index];
    [oldView removeFromSuperview];
    view.frame = CGRectMake(_contentScroolView.frame.size.width*index, 0, _contentScroolView.frame.size.width, _contentScroolView.frame.size.height);
    view.tag = content_view_tag + index;
    [_contentScroolView addSubview:view];
    [_contentViewArr replaceObjectAtIndex:index withObject:view];
}

- (void)switchTableAsIndex:(NSInteger)index
{
    [self moveToIndex:index];
}

- (void)setHeadItemWidth:(CGFloat)headItemWidth {
    _headItemWidth = headItemWidth;
    _headView.headItemWidth = headItemWidth;
}
@end


@interface MLCommonScroolHeadView()
{
    MLCommonScroolHeadStyle _type;
    NSInteger _defaultPage;
}
@property (nonatomic, strong) NSMutableArray *titleArray;
@end

@implementation MLCommonScroolHeadView

- (instancetype)initWithFrame:(CGRect)frame andType:(MLCommonScroolHeadStyle)type andDefaultPage:(NSInteger)defaultPage
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _defaultPage = defaultPage;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.bounces = NO;
    self.pagingEnabled = YES;
}

- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = titleArr;
    if (_type == MLCommonScroolHeadMidLine) { //MLCommonScroolHeadMidLine
        float btnWidth = (self.frame.size.width)/titleArr.count;
        //添加btn
        for (int i =0; i<titleArr.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            float x = btnWidth*i;
            btn.frame = CGRectMake(x, (self.bounds.size.height-_btnHeight)/2, btnWidth, _btnHeight);
            btn.backgroundColor = [UIColor clearColor];
            btn.adjustsImageWhenHighlighted = NO;
            [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            btn.tag = head_button_tag + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == _defaultPage) {
                btn.selected = YES;
            }
        }
        //添加line
        for (int i =0; i<titleArr.count; i++) {
            float x = btnWidth*i;
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(x+btnWidth, (self.frame.size.height-_btnHeight)/2+9, 1, _btnHeight-18)];
            line.backgroundColor = [UIColor colorWithWhite:215.f / 255.f alpha:1.f];
            [self addSubview:line];
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,_headHeight-1, self.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithWhite:215.f / 255.f alpha:1.f];
        [self addSubview:lineView];
        
        UIView *redLineView = [[UIView alloc] initWithFrame:CGRectMake(0,_headHeight-2, btnWidth, 2)];
        redLineView.backgroundColor = [UIColor darkGrayColor];
        redLineView.tag = line_view_tag;
        [self addSubview:redLineView];
    } else if (_type == MLCommonScroolHeadMidNoLine) { //项目中间没有线
        float btnWidth = (self.frame.size.width)/titleArr.count;
        //添加btn
        for (int i =0; i<titleArr.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            float x = btnWidth*i;
            btn.frame = CGRectMake(x, (self.bounds.size.height-_btnHeight)/2, btnWidth, _btnHeight);
            btn.backgroundColor = [UIColor clearColor];
            btn.adjustsImageWhenHighlighted = NO;
            [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:165.0/255 green:175.0/255 blue:180.0/255 alpha:1.0] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.0/255 green:102.0/255 blue:204.0/255 alpha:1.0] forState:UIControlStateSelected];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            btn.tag = head_button_tag + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == _defaultPage) {
                btn.selected = YES;
            }
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,_headHeight-1, self.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithWhite:215.f / 255.f alpha:1.f];
        [self addSubview:lineView];
        
        UIView *redLineView = [[UIView alloc] initWithFrame:CGRectMake(_defaultPage*btnWidth+5,_headHeight-2, btnWidth-10, 2)];
        redLineView.backgroundColor = [UIColor colorWithRed:0.0/255 green:102.0/255 blue:204.0/255 alpha:1.0];
        redLineView.tag = line_view_tag;
        [self addSubview:redLineView];

    } else if (_type == MLCommonScroolHeadTwoLevel) { //两层样式
        NSInteger number = titleArr.count;
        if (titleArr.count>2) {
            number = 2;
        }
        float btnWidth = (self.frame.size.width)/number;
        //添加btn
        for (int i =0; i<titleArr.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            float x = btnWidth*i;
            btn.frame = CGRectMake(x, (self.bounds.size.height-_btnHeight)/2, btnWidth, _btnHeight);
            btn.backgroundColor = [UIColor clearColor];
            btn.adjustsImageWhenHighlighted = NO;
            btn.titleLabel.numberOfLines = 2;
            NSDictionary * dic = [titleArr objectAtIndex:i];
            [btn setAttributedTitle:[dic objectForKey:@"UIControlStateSelected"] forState:UIControlStateSelected];
            [btn setAttributedTitle:[dic objectForKey:@"UIControlStateNormal"] forState:UIControlStateNormal];
            btn.tag = head_button_tag + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == _defaultPage) {
                btn.selected = YES;
            }
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,_headHeight-1, btnWidth*titleArr.count, 1)];
        lineView.backgroundColor = [UIColor colorWithWhite:215.f / 255.f alpha:1.f];
        [self addSubview:lineView];
        
        UIView *redLineView = [[UIView alloc] initWithFrame:CGRectMake(_defaultPage*btnWidth+5,_headHeight-2, btnWidth-10, 2)];
        redLineView.backgroundColor = [UIColor colorWithRed:0.0/255 green:102.0/255 blue:204.0/255 alpha:1.0];
        redLineView.tag = line_view_tag;
        [self addSubview:redLineView];
        self.contentSize = CGSizeMake(btnWidth * titleArr.count, self.frame.size.height);
    } else if (_type == MLCommonScroolHeadBlueSelected) {//MLCommonScroolHeadBlueSelected
        
        float btnWidth = 73;
        if (self.headItemWidth>0) {
            btnWidth = self.headItemWidth;
        }
        float btnHeight = CGRectGetHeight(self.bounds);
        self.contentSize = CGSizeMake(btnWidth*titleArr.count, self.frame.size.height);
        //添加btn
        for (int i =0; i<titleArr.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            float x = btnWidth*i;
            btn.frame = CGRectMake(x, 0, btnWidth,btnHeight);
            btn.backgroundColor = [UIColor clearColor];
            btn.adjustsImageWhenHighlighted = NO;
            [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:@"333333"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[[self class] createImageWithColor:[UIColor hexChangeFloat:__kSL_Blue_01]] forState:UIControlStateSelected];
            [btn setBackgroundImage:[[self class] createImageWithColor:[UIColor hexChangeFloat:__kSL_Background]] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            btn.tag = head_button_tag + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == _defaultPage) {
                btn.selected = YES;
            }
        }
    }else if (_type == MLCommonScroolHeadFlood) {//MLCommonScroolHeadFlood
        float btnWidth = 95;
        if (self.headItemWidth>0) {
            btnWidth = self.headItemWidth;
        }
        self.contentSize = CGSizeMake(btnWidth*titleArr.count, self.frame.size.height);
        
        CGFloat bufferX = 0;
        CGFloat allTitleWidth = titleArr.count *btnWidth;
        if (allTitleWidth<self.bounds.size.width) {
            bufferX = (self.bounds.size.width-allTitleWidth)/2;
        }
        
        //添加btn
        for (int i =0; i<titleArr.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            float x = btnWidth*i;
            btn.frame = CGRectMake(bufferX+x, (self.bounds.size.height-_btnHeight)/2, btnWidth,_btnHeight);
            btn.layer.cornerRadius = _btnHeight/2;
            btn.layer.masksToBounds = YES;
            btn.backgroundColor = [UIColor clearColor];
            btn.adjustsImageWhenHighlighted = NO;
            [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:@"85868F"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[[self class] createImageWithColor:[UIColor hexChangeFloat:@"5c5e6d"]] forState:UIControlStateSelected];
            [btn setBackgroundImage:[[self class] createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            btn.tag = head_button_tag + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == _defaultPage) {
                btn.selected = YES;
            }
        }
    } else if (_type == MLCommonScroolSelected) {
        float btnWidth = 73;
        if (self.headItemWidth>0) {
            btnWidth = self.headItemWidth;
        }
        float btnHeight = CGRectGetHeight(self.bounds);
        self.contentSize = CGSizeMake(btnWidth*titleArr.count, self.frame.size.height);
        //添加btn
        for (int i =0; i<titleArr.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            float x = btnWidth*i;
            btn.frame = CGRectMake(x, 0, btnWidth,btnHeight);
            btn.backgroundColor = [UIColor whiteColor];
            btn.adjustsImageWhenHighlighted = NO;
            [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:__kSL_Black_03] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:@"4285F4"] forState:UIControlStateSelected];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            btn.tag = head_button_tag + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == _defaultPage) {
                btn.selected = YES;
            }
        }
        
        self.layer.shadowColor = [UIColor hexChangeFloat:__kSL_Black_01].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowRadius = 2;
        self.layer.masksToBounds = NO;
        self.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
        
    } else if (_type == MLCommonScroolHeadBlueUnderline) {// 带蓝色下划线的
        float btnWidth = 100;
        if (self.headItemWidth>0) {
            btnWidth = self.headItemWidth;
        }
        float btnHeight = CGRectGetHeight(self.bounds);
        self.contentSize = CGSizeMake(btnWidth*titleArr.count, self.frame.size.height);
        //添加btn
        for (int i =0; i<titleArr.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (titleArr.count*100>self.frame.size.width) {
                float x = btnWidth*i;
                btn.frame = CGRectMake(x, 0, btnWidth,btnHeight);
            } else {
               btn.frame = CGRectMake((self.frame.size.width-100*titleArr.count)/2+btnWidth*i, 0, btnWidth,btnHeight);
            }
            btn.backgroundColor = [UIColor whiteColor];
            btn.adjustsImageWhenHighlighted = NO;
            [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:__kSL_Black_03] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:@"4285F4"] forState:UIControlStateSelected];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            btn.tag = head_button_tag + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            if (i == _defaultPage) {
                btn.selected = YES;
            }
        }
        
        UIView *blueView = [[UIView alloc]init];
        blueView.tag = line_view_tag;
        blueView.layer.cornerRadius = 1.5;
        blueView.clipsToBounds = YES;
        blueView.backgroundColor = [UIColor hexChangeFloat:__kSL_Blue_01];
        [self addSubview:blueView];
        if (titleArr.count*100>self.frame.size.width) {
            blueView.frame = CGRectMake((btnWidth-20)/2, btnHeight-3, 20, 3);
        } else {
            CGFloat blueViewX = (self.frame.size.width-titleArr.count*btnWidth)/2+(btnWidth-20)/2;
            blueView.frame = CGRectMake(blueViewX, btnHeight-3, 20, 3);
        }

        self.layer.shadowColor = [UIColor hexChangeFloat:__kSL_Black_01].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,3);
        self.layer.shadowOpacity = 0.15;
        self.layer.shadowRadius = 3;
        self.layer.masksToBounds = NO;
        self.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
        
    }  else if (_type == MLCommonScroolHeadBlueUnderlineAndSpot) {// 带蓝色下划线的并有红点的
        float btnWidth = 100;
        if (self.headItemWidth>0) {
            btnWidth = self.headItemWidth;
        }
        float btnHeight = CGRectGetHeight(self.bounds);
        self.contentSize = CGSizeMake(btnWidth*titleArr.count, self.frame.size.height);
        //添加btn
        for (int i =0; i<titleArr.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((self.width-100*titleArr.count)/2+btnWidth*i, 0, btnWidth,btnHeight);
            btn.backgroundColor = [UIColor whiteColor];
            btn.adjustsImageWhenHighlighted = NO;
            [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:__kSL_Black_03] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:@"4285F4"] forState:UIControlStateSelected];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            btn.tag = head_button_tag + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            // 红点
            UIView *redView = [[UIView alloc]init];
            redView.hidden = YES;
            redView.tag = redView_tag+i;
            [self addSubview:redView];
            [redView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btn.titleLabel.mas_right).offset(-5);
                make.top.mas_equalTo(12);
                make.width.mas_equalTo(5);
                make.height.mas_equalTo(5);
            }];
            redView.backgroundColor = [UIColor redColor];
            redView.layer.cornerRadius = 2.5;
            
            if (i == _defaultPage) {
                btn.selected = YES;
                redView.hidden = YES;
            }
        }
        
        UIView *blueView = [[UIView alloc]init];
        blueView.tag = line_view_tag;
        blueView.layer.cornerRadius = 1.5;
        blueView.clipsToBounds = YES;
        blueView.backgroundColor = [UIColor hexChangeFloat:__kSL_Blue_01];
        [self addSubview:blueView];
        CGFloat blueViewX = (self.frame.size.width-titleArr.count*btnWidth)/2+(btnWidth-20)/2;
        blueView.frame = CGRectMake(blueViewX, btnHeight-3, 20, 3);
    }
}

- (UIView *)getRedViewWithIndex:(NSInteger)index {
    UIView * redView = (UIView *)[self viewWithTag:redView_tag + index];
    return redView;
}

- (void)btnClick:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    NSInteger index = btn.tag - head_button_tag;
    if (_headDelegate && [_headDelegate respondsToSelector:@selector(headViewMoveToIndex:)]) {
        [_headDelegate headViewMoveToIndex:index];
    }
}

- (void)moveTitle:(NSNumber *)index
{
    UIButton * btn = (UIButton *)[self viewWithTag:head_button_tag +[index integerValue]];
    float btnWidth = btn.frame.size.width;
    UIView * lineView = [self viewWithTag:line_view_tag];
    float x = btnWidth*[index integerValue];
    CGFloat width = lineView.frame.size.width;
    if (_titleArr.count*100>self.frame.size.width) {
        lineView.frame = CGRectMake(x+(btnWidth - width)/2,_headHeight-3, width, 3);
    } else {
        float x = (self.frame.size.width-_titleArr.count*100)/2+btnWidth*[index integerValue];
        UIView * lineView = [self viewWithTag:line_view_tag];
        CGFloat width = lineView.frame.size.width;
        lineView.frame = CGRectMake(x+(btnWidth - width)/2,_headHeight-3, width, 3);
    }
    btn.selected = YES;
    //取消当前选择
    for (int i =0; i<[_titleArr count]; i++) {
        UIButton * btn = (UIButton*)[self viewWithTag:i+head_button_tag];
        btn.selected = NO;
    }
    //选择当前的
    UIButton * currentBtn = (UIButton*)[self viewWithTag:[index integerValue]+head_button_tag];
    currentBtn.selected = YES;
    
    //移动contentSize
    float targetX = btnWidth * ([index integerValue]-1);
    if (self.contentSize.width - self.frame.size.width<targetX) {
        targetX = self.contentSize.width - self.frame.size.width;
    }
    if (targetX<0) {
        targetX = 0;
    }
    [self setContentOffset:CGPointMake(targetX, 0) animated:YES];
}

+ (UIImage*)createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
