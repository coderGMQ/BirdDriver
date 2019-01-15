//
//  SLAlertView.h
//  SmartLife
//
//  Created by 甘明强 on 2017/8/24.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SLAlertViewType) {
    SLAlertViewCommonType = 0, // 普通弹框-- 纯文字+按钮
    SLAlertViewTitleType = 1,  // 标题弹框-- 标题+ 纯文字+ 按钮
    SLAlertViewImageTextType = 2,// 图文弹框-- 文字+图片+按钮/ 文字+图片+文字+按钮
    SLAlertViewBottomType = 3,   // 底部弹框
    SLAlertViewInputType = 4,    // 弹出输入框
};

@class SLAlertView;


typedef void(^BtnClickBlock)(NSInteger clickIndex);

@protocol SLAlertViewDelegate <NSObject>
/**
 *   Called when a button is clicked. The view will be automatically dismissed after this call returns
 *
 *  @param alertView   alertView自身
 *  @param buttonIndex 取消:buttonIndex=0  确定:buttonIndex=1
 */
@optional
- (void)etAlertView:(SLAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface SLAlertView : UIView
@property (nonatomic, copy) BtnClickBlock clickBlock;
@property (nonatomic, weak) id <SLAlertViewDelegate>delegate;
@property (nonatomic, strong) UITextField *inputTextFieldView;

- (void)setHideSelf;
/**
 *  自定义AlertView
 *
 *  @param title             提示标题
 *  @param message           提示内容
 *  @param customView        图文形式下自定义的view
 *  @param textAttArray      文字属性数组
 *  @param delegate          提示代理
 *  @param alertViewType     边框样式类型
 *  @return 返回一个类似系统UIAlertView的AlertView
 */
//- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitle alertViewType:(SLAlertViewType)alertViewType;

- (id) initWithTitle:(NSString *)title message:(NSString *)message customView:(UIView *)customView textAttArray:(NSArray *)textAttArray delegate:(id)delegate alertViewType:(SLAlertViewType)alertViewType;


/**
 *  需要调用show方法，显示对话框
 */
- (void)show;
@end
