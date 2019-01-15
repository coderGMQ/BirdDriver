//
//  SLAlertView.m
//  SmartLife
//
//  Created by 甘明强 on 2017/8/24.
//
//

#import "SLAlertView.h"
#import "UIImage+GIF.h"

static NSInteger const _alertViewItemTag = 100;

@interface SLAlertView ()<UITextFieldDelegate>
{
    UIView *_fullScreenView;// 全屏阴影
    UIView *_viewContent;// 白色边框view
    UILabel *_titleLabel;// 标题
    UILabel *_messageLabel;
    UIImageView *_bgImageView;
    UIView *_bottomLineView;// 底部灰色的线
    UIView *_bottomView;// 底部view
    NSMutableArray *actionButtonArray;
    CGRect _oldContentFrame;
}
@end

@implementation SLAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message customView:(UIView *)customView textAttArray:(NSArray *)textAttArray delegate:(id)delegate alertViewType:(SLAlertViewType)alertViewType {
    
    self = [super init];
    if (self) {
        // 全屏的透明度为0.8的阴影
        CGRect fullScreenFrame = CGRectMake(0, 0, __gScreenWidth, __gScreenHeight+20);
        _fullScreenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __gScreenWidth, __gScreenHeight+20)];
        _fullScreenView.backgroundColor = [UIColor blackColor];
        self.frame = fullScreenFrame;
        _fullScreenView.alpha = 0.8;
        [self addSubview:_fullScreenView];

        // 白色边框
        CGFloat _viewContentW = 300;
        _viewContent = [[UIView alloc]init];
        _viewContent.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
        _viewContent.layer.cornerRadius = 10;
        [self addSubview:_viewContent];

        CGFloat actionButtonY = 0;
        CGSize size = [NSString fitSizeForText:message font:[UIFont systemFontOfSize:__kSL_Text_15] maxWidth: _viewContentW-30];
        CGFloat messageLabelHeight  = size.height;
        // -- 普通弹框 --
        if (alertViewType == SLAlertViewCommonType) {
            _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, _viewContentW-30, messageLabelHeight)];
            _messageLabel.text = message;
            _messageLabel.font = [UIFont systemFontOfSize:__kSL_Text_15];
            _messageLabel.textAlignment =NSTextAlignmentCenter;
            _messageLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
            _messageLabel.numberOfLines = 0;
            [_viewContent addSubview:_messageLabel];

            actionButtonY = messageLabelHeight+60;

        } else if (alertViewType == SLAlertViewTitleType) { // -- 标题弹框 --
            CGFloat titleLabelHeight = 50;
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _viewContentW, titleLabelHeight)];
            _titleLabel.text = title;
            _titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_18];
            _titleLabel.textAlignment =NSTextAlignmentCenter;
            _titleLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
            [_viewContent addSubview:_titleLabel];

            _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, _viewContentW-30, messageLabelHeight)];
            _messageLabel.text = message;
            _messageLabel.numberOfLines = 0;
            _messageLabel.font = [UIFont systemFontOfSize:__kSL_Text_15];
            _messageLabel.textAlignment =NSTextAlignmentCenter;
            _messageLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_02];
            [_viewContent addSubview:_messageLabel];

            actionButtonY = 50+messageLabelHeight+20;
        } else if (alertViewType == SLAlertViewImageTextType) { // 图文弹框
            CGFloat titleLabelHeight = 50;
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _viewContentW, titleLabelHeight)];
            _titleLabel.text = title;
            _titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_18];
            _titleLabel.textAlignment =NSTextAlignmentCenter;
            _titleLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
            [_viewContent addSubview:_titleLabel];

            customView.frame = CGRectMake(0, 50, _viewContentW, 95);
            [_viewContent addSubview:customView];

            actionButtonY = 50+95;
        } else if (alertViewType == SLAlertViewBottomType) {

        } else if (alertViewType == SLAlertViewInputType) {
            CGFloat titleLabelHeight = 50;
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _viewContentW, titleLabelHeight)];
            _titleLabel.text = title;
            _titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_15];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
            [_viewContent addSubview:_titleLabel];

            _inputTextFieldView = [[UITextField alloc] initWithFrame:CGRectMake(20, titleLabelHeight, _viewContentW-40, 40)];
            
            _inputTextFieldView.textAlignment = NSTextAlignmentCenter;
            _inputTextFieldView.delegate = self;
            _inputTextFieldView.font = [UIFont systemFontOfSize:__kSL_Text_15];
            _inputTextFieldView.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
            _inputTextFieldView.layer.borderWidth = 0.5f;
            _inputTextFieldView.layer.borderColor = [UIColor hexChangeFloat:__kSL_Black_03].CGColor;
            _inputTextFieldView.text = message;
            [_viewContent addSubview:_inputTextFieldView];

            actionButtonY = titleLabelHeight+40+20;
        }

        if (textAttArray && [textAttArray isKindOfClass:[NSArray class]] && textAttArray.count>0) {
            // 底部的操作按钮
            CGFloat actionButtnW = _viewContentW/textAttArray.count;
            for (int i = 0; i<textAttArray.count; i++) {
                UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
                CGFloat actionButtonX = i*actionButtnW;
                actionButton.frame = CGRectMake(actionButtonX, actionButtonY, actionButtnW, 50);
                actionButton.titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_15];
                NSArray *array = textAttArray[i];
                NSString *title= array.firstObject;
                NSString *titleColor = array.lastObject;
                [actionButton setTitle:title forState:UIControlStateNormal];
                [actionButton setTitleColor:[UIColor hexChangeFloat:titleColor] forState:UIControlStateNormal];
                actionButton.tag = _alertViewItemTag + i;
                [actionButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [_viewContent addSubview:actionButton];
            }

            // 底部的线
            for (int i = 0; i<textAttArray.count-1; i++) {
                UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake((i+1)*actionButtnW, actionButtonY, 0.5, 50)];
                bottomLineView.backgroundColor = [UIColor hexChangeFloat:__kSL_Line_01];
                [_viewContent addSubview:bottomLineView];
            }
        }

        CGFloat _viewContentH = actionButtonY+50;
        CGFloat _viewContentX = (__gScreenWidth-_viewContentW)/2;
        CGFloat _viewContentY = (__gScreenHeight+20-_viewContentH)/2;
        _viewContent.frame = CGRectMake(_viewContentX, _viewContentY, _viewContentW, _viewContentH);

        // bottom横线
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = [UIColor hexChangeFloat:__kSL_Line_01];
        [_viewContent addSubview:_bottomLineView];
        _bottomLineView.frame = CGRectMake(0, actionButtonY, _viewContentW, 0.5);

        _delegate = delegate;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)btnClick:(UIButton *)btn {
    NSInteger clickIndex = btn.tag - _alertViewItemTag;
    if (_delegate && [_delegate respondsToSelector:@selector(etAlertView:clickedButtonAtIndex:)]) {
        [_delegate etAlertView:self clickedButtonAtIndex:clickIndex];
    }
    if (self.clickBlock) {
        self.clickBlock(clickIndex);
    }
    [self setHideSelf];
}

- (void)setHideSelf{
    [UIView animateWithDuration:0.1 animations:^{
        [self setAlpha:!self.alpha];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)cornerTop:(UIView *)view
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (void)cornerBottom:(UIView *)view
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (void)show
{
    UIWindow * window = [[UIApplication sharedApplication].windows safeObjectAtIndex:0];
    [window endEditing:YES];
    [window addSubview:self];
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _oldContentFrame = _viewContent.frame;
    [UIView animateWithDuration:0.2 animations:^{
        _viewContent.frame = CGRectMake(_oldContentFrame.origin.x, _oldContentFrame.origin.y-80, _oldContentFrame.size.width, _oldContentFrame.size.height);
    } completion:^(BOOL finished) {
        _viewContent.frame = CGRectMake(_oldContentFrame.origin.x, _oldContentFrame.origin.y-80, _oldContentFrame.size.width, _oldContentFrame.size.height);
    }];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^{
        _viewContent.frame = _oldContentFrame;
    } completion:^(BOOL finished) {
        _viewContent.frame = _oldContentFrame;
    }];
}
@end
