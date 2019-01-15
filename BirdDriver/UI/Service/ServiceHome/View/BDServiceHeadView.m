//
//  BDServiceHeadView.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/10.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDServiceHeadView.h"

@implementation BDServiceHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
    _textLabel.text = @"";
    _textLabel.font = [UIFont boldSystemFontOfSize:__kSL_Text_15];
    _textLabel.textColor = [UIColor hexChangeFloat:__kSL_Black_01];
    [self addSubview:_textLabel];
}
@end
