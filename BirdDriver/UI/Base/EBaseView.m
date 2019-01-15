//
//  EBaseView.m
//  SmartLife
//
//  Created by Potter on 2017/3/2.
//
//

#import "EBaseView.h"


@interface EBaseView()
{
    UILabel *_titleLabel;
    UIView *_statusBarView;
}
@end

@implementation EBaseView
@synthesize __statusBarView;
@synthesize __navigationView;
@synthesize __contentView;
@synthesize __title;
@synthesize __navigationViewLine;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseViewUI];
    }
    return self;
}

- (void)initBaseViewUI {
    
    self.__contentView = [[EContentView alloc] initWithFrame:CGRectMake(0, __gNavigationHeight+__gStatusBarHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-__gNavigationHeight-__gStatusBarHeight)];
    [self addSubview:self.__contentView];
    
    self.__statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __gScreenWidth, __gStatusBarHeight)];
    self.__statusBarView.backgroundColor = [UIColor hexChangeFloat:__gStyleColor];
    self.__statusBarView.userInteractionEnabled = NO;
    [self addSubview:self.__statusBarView];
    
    self.__navigationView = [[ENavigationView alloc] initWithFrame:CGRectMake(0, __gStatusBarHeight, __gScreenWidth, __gNavigationHeight)];
    self.__navigationView .backgroundColor = [UIColor hexChangeFloat:__gStyleColor];
    [self addSubview:self.__navigationView];
    
    self.__navigationViewLine = [[UIView alloc] initWithFrame:CGRectMake(0, __gNavigationHeight-0.5, __gScreenWidth, 0.5)];
    self.__navigationViewLine.backgroundColor = [UIColor hexChangeFloat:__kSL_Line_01];
    [self.__navigationView addSubview:self.__navigationViewLine];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f,0.0f,__gScreenWidth-100,__gNavigationHeight)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    self.__titleLabel = _titleLabel;
    [__navigationView addSubview:_titleLabel];
    [__navigationView.superview bringSubviewToFront:__navigationView];
}

- (void)setTitle:(NSString *)title {
    if (__title != title) {
        __title = title;
    }
    _titleLabel.text = __title;
}

#pragma mark - public Method

- (void)setFullScreen {
    self.__contentView.frame = self.bounds;
}

@end
