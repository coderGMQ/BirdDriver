//
//  ENavigationView.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface ENavigationView : UIView
{

}

@property (nonatomic, readonly, strong) UIImageView *ivBg;
@property (nonatomic,strong) UIView* line;
@property (nonatomic,readonly,strong)UIView * contentView;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * __navigationHeightConstraint;
- (void)initNavgationView;

- (void)setNaviBgHidden:(BOOL)hidden;

- (void)setNavigationHidden:(BOOL)hidden animation:(BOOL)animation;

- (void)setNavLineHidden:(BOOL)hidden;

@end
