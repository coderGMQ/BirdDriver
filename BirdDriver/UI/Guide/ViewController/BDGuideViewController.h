//
//  BDGuideViewController.h
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/7.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GuideFinishBlock)();

@interface BDGuideViewController : UIViewController
@property (nonatomic,copy)GuideFinishBlock finishBlock;
// 是否需要显示引导页
+ (BOOL)needShowGuideView;
@end

