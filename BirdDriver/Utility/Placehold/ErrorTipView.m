//
//  ErrorTipView.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "ErrorTipView.h"
#import "MBTimeProgressView.h"

@interface ErrorTipView(){
    UIImageView * _errorImgView;
    UILabel * _errorInfo;
    UIButton * _errorBtn;
    ErrorType _errorType;
    UIImageView *_leftImageView;
    UIImageView *_rightImageView;
}
@end

@implementation ErrorTipView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _errorType = ErrorNone;
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andErrorType:(ErrorType)errorType{
    self = [super initWithFrame:frame];
    if(self){
        _errorType = errorType;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    if(_errorType == ErrorLoading){
        
        self.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.2];
        
        UIView *whiteBgView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-125)/2, (self.frame.size.height-125)/2, 125, 125)];
        whiteBgView.backgroundColor = [UIColor whiteColor];
        whiteBgView.layer.cornerRadius = 10;
        [self addSubview:whiteBgView];
        
        UIActivityIndicatorView *loadView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        loadView.color = [UIColor blackColor];
        loadView.frame = CGRectMake(44.5, 35, 36, 36);
        [loadView startAnimating];
        [whiteBgView addSubview:loadView];
        
        _errorInfo = [[UILabel alloc] initWithFrame:CGRectMake(0,loadView.frame.origin.y + loadView.frame.size.height + 10, whiteBgView.frame.size.width, 20)];
        _errorInfo.font = [UIFont systemFontOfSize:15];
        _errorInfo.adjustsFontSizeToFitWidth = YES;
        _errorInfo.backgroundColor=[UIColor clearColor];
        _errorInfo.textAlignment = NSTextAlignmentCenter;
        _errorInfo.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        _errorInfo.backgroundColor = [UIColor clearColor];
        _errorInfo.text = @"加载中...";
        [whiteBgView addSubview:_errorInfo];
    } else if (_errorType == ErrorNoDataNoPic) {
        _errorInfo = [[UILabel alloc] initWithFrame:self.bounds];
        _errorInfo.font = [UIFont systemFontOfSize:15];
        _errorInfo.adjustsFontSizeToFitWidth = YES;
        _errorInfo.backgroundColor=[UIColor clearColor];
        _errorInfo.textAlignment = NSTextAlignmentCenter;
        _errorInfo.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        [self addSubview:_errorInfo];
        
        _errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _errorBtn.frame = self.bounds;
        _errorBtn.backgroundColor = [UIColor clearColor];
        _errorBtn.layer.cornerRadius = 4.0f;
        _errorBtn.layer.masksToBounds = YES;
        _errorBtn.highlighted = YES;
        [_errorBtn addTarget:self.target action:self.errorAction forControlEvents:UIControlEventTouchUpInside];
        [_errorBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _errorInfo.text = @"无数据";
        [self addSubview:_errorBtn];
    } else if (_errorType == ErrorNoData) {
        _errorImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-errorImageWidth)/2,0, errorImageWidth, errorImageHeight)];
        if (self.errorImg) {
            _errorImgView.image = [UIImage imageNamed:self.errorImg];
        } else {
            _errorImgView.image = [UIImage imageNamed:@"placehold_noData"];
        }
        [self addSubview:_errorImgView];

        _errorInfo = [[UILabel alloc] initWithFrame:CGRectMake(0,errorImageHeight+12, self.frame.size.width, 20)];
        _errorInfo.font = [UIFont systemFontOfSize:15];
        _errorInfo.adjustsFontSizeToFitWidth = YES;
        _errorInfo.backgroundColor=[UIColor clearColor];
        _errorInfo.textAlignment = NSTextAlignmentCenter;
        _errorInfo.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        [self addSubview:_errorInfo];
        
        _errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _errorBtn.frame = self.bounds;
        _errorBtn.backgroundColor = [UIColor clearColor];
        _errorBtn.layer.cornerRadius = 4.0f;
        _errorBtn.layer.masksToBounds = YES;
        _errorBtn.highlighted = YES;
        [_errorBtn addTarget:self.target action:self.errorAction forControlEvents:UIControlEventTouchUpInside];
        [_errorBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _errorInfo.text = @"无数据";
        [self addSubview:_errorBtn];
    } else if (_errorType == ErrorNoNet) {

        _errorInfo = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, 20)];
        _errorInfo.font = [UIFont systemFontOfSize:15];
        _errorInfo.adjustsFontSizeToFitWidth = YES;
        _errorInfo.backgroundColor=[UIColor clearColor];
        _errorInfo.textAlignment = NSTextAlignmentCenter;
        _errorInfo.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        [self addSubview:_errorInfo];
        
        _errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _errorBtn.frame = CGRectMake((self.frame.size.width-70)/2,_errorInfo.frame.origin.y + _errorInfo.frame.size.height + 20,70, 30);
        [_errorBtn setTitle:@"刷新" forState:UIControlStateNormal];
        _errorBtn.backgroundColor = [UIColor colorWithRed:66.0/255.0 green:133.0/244.0 blue:244.0/255.0 alpha:1.0];
        _errorBtn.layer.cornerRadius = 15.0f;
        _errorBtn.layer.masksToBounds = YES;
        _errorBtn.highlighted = YES;
        [_errorBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:_errorBtn];
        
        //添加默认错误类型
        switch (_errorType){
            case ErrorNoData:
            {
                _errorInfo.text = @"无数据";
            }
                break;
            case ErrorNoNet:
            {
                _errorInfo.text = @"网络已走丢,请刷新重试";
            }
                break;
            default:
                break;
        }
        
    }
}

- (void)setErrorImg:(NSString *)errorImg{
    if(errorImg && errorImg.length > 0){
        
        CGRect frame = _leftImageView.frame;
        frame.origin.x = CGRectGetMinX(_errorImgView.frame)-47;
        _leftImageView.frame = frame;
        frame = _rightImageView.frame;
        frame.origin.x = CGRectGetMaxX(_errorImgView.frame)+22;
        _rightImageView.frame = frame;
        _errorImg = errorImg;
        _errorImgView.image = [UIImage imageNamed:_errorImg];
    }
}

- (void)setErrorTip:(NSString *)errorTip{
    if(errorTip){
        _errorTip = errorTip;
        if (errorTip && errorTip.length>0) {
            
            CGSize textSize = [_errorTip boundingRectWithSize:CGSizeMake(self.frame.size.width, 300)
                                                      options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16] }
                               context:nil].size;
            if (textSize.height>20) {
                _errorInfo.numberOfLines = 0;
                CGRect frame = _errorInfo.frame;
                frame.size.height = textSize.height;
                _errorInfo.frame = frame;
            }
        }
        _errorInfo.text = _errorTip;
    }
}

- (void)setErrorTipNumberOfLine:(NSInteger)errorTipNumberOfLine{
    if(errorTipNumberOfLine > 1){
        _errorTipNumberOfLine = errorTipNumberOfLine;
        _errorInfo.numberOfLines = _errorTipNumberOfLine;
        CGFloat height = 20 * errorTipNumberOfLine;
        CGRect frame = _errorInfo.frame;
        frame.size.height = height;
        _errorInfo.frame = frame;
        if(_errorType != ErrorNoData){
            frame = _errorBtn.frame;
            frame.origin.y = _errorInfo.frame.origin.y + _errorInfo.frame.size.height + 10;
            _errorBtn.frame = frame;
        }
    }
}

- (void)setErrorBtnTitle:(NSString *)errorBtnTitle{
    if(errorBtnTitle){
        _errorBtnTitle = errorBtnTitle;
        //        [_errorBtn setTitle:_errorBtnTitle forState:UIControlStateNormal];
    }
}

- (void)setErrorAction:(SEL)errorAction{
    if(errorAction != NULL){
        _errorAction = errorAction;
        if(_target && [_target respondsToSelector:_errorAction]){
            [_errorBtn addTarget:_target action:_errorAction forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)setTarget:(id)target{
    if(target){
        _target = target;
        if(_target && [_target respondsToSelector:_errorAction]){
            [_errorBtn addTarget:_target action:_errorAction forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)setNeedTouchView:(BOOL)needTouchView{
    if(needTouchView){
        _needTouchView = needTouchView;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = self.bounds;
        [btn addTarget:_target action:_errorAction forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _errorInfo.textColor = textColor;
}

@end


