//
//  EBackgroundView.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBackgroundView : UIImageView

@property (nonatomic,strong,readonly) UIImageView *__foregroundImgView;
@property (nonatomic,assign,setter = setForegroundRect:) CGRect __foregroundRect;

- (void)initBackgroundView;

@end
