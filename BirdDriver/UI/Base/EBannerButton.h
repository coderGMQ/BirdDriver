//
//  EBannerButton.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    ETBannerButtonBack,
    ETBannerButtonFinished,
    ETBannerButtonCancel,
    ETBannerButtonAdd,
    ETBannerButtonWhite,   //白色返回按钮
    ETBannerButtonOther
};
typedef NSInteger ETBannerButtonType;

@interface EBannerButton : UIButton
@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong,setter = setTitle:) NSString *__title;

- (void)initWithType:(ETBannerButtonType)buttonType;
@end
