//
//  ErrorTipView.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat errorImageWidth = 60;
static CGFloat errorImageHeight = 60;

typedef enum ErrorType{
    ErrorNone,             //没有错误类型
    ErrorNoDataNoPic,      //没数据且不展示图片
    ErrorNoData,           //没数据
    ErrorNoNet,            //没网络
    ErrorLoading           //正在加载
}ErrorType;

@interface ErrorTipView : UIView
@property (nonatomic,strong) NSString * errorImg;             //错误的图片  默认:tips_empty
@property (nonatomic,strong) NSString * errorTip;             //错误提示文本
@property (nonatomic,assign) NSInteger errorTipNumberOfLine;  //错误提示文本行数
@property (nonatomic,strong) NSString * errorBtnTitle;        //按钮的标题
@property (nonatomic,assign) SEL errorAction;                 //按钮的事件
@property (nonatomic,weak) id target;                       //按钮响应者
@property (nonatomic,assign) BOOL needTouchView;              //是否需要点击页面回调，如果需要需要设置btnAction和target回调 默认:不需要
@property (nonatomic,strong) UIColor *textColor;            // 文字颜色

/*带上下面按钮的本身高度232 不带按钮 182  loading:70*/
- (instancetype)initWithFrame:(CGRect)frame andErrorType:(ErrorType)errorType;

@end



