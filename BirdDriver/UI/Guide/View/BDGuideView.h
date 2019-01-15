//
//  BDGuideView.h
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/7.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BDGuideViewDelegate <NSObject>

// 点击立即使用
- (void)didClickUseAppRightNow;

@end

@interface BDGuideView : UIView
@property (nonatomic,weak)id<BDGuideViewDelegate>delegate;
@end

