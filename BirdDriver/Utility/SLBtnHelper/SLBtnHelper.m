//
//  SLBtnHelper.m
//  SmartLife
//
//  Created by han on 2017/3/23.
//
//

#import "SLBtnHelper.h"
#import "UIImage+Utils.h"

@implementation SLBtnHelper

+ (UIButton *)rightNavBtnWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = CGRectMake(__gScreenWidth - 60, 0, 60, __gNavigationHeight);
    [btn setTitleColor:[UIColor hexChangeFloat:__kSL_White_01] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_12];
    return btn;
}

+ (UIButton *)rightNavBtnWithImageStr:(NSString *)imageStr {
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(__gScreenWidth-45, 0, 45, __gNavigationHeight);
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor hexChangeFloat:__kSL_Blue_01] forState:UIControlStateNormal];
    return btn;
}

+ (UIButton *)slCommonStyleButtonWithType:(SLCommonButtonType)type {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [[self class] slCommonStyleButtonWithType:type btn:btn];
    return btn;
}

+ (void)slCommonStyleButtonWithType:(SLCommonButtonType)type btn:(UIButton *)btn {
    switch (type) {
        case SLButtonPageMainOperate:
        {
            btn.backgroundColor = [UIColor hexChangeFloat:@"4285f4"];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:@"8caff7"] forState:UIControlStateHighlighted];
            btn.titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_18];
            btn.layer.borderColor = [[UIColor hexChangeFloat:@"4285f4"] CGColor];
            btn.layer.borderWidth = .5f;
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            [btn setFrame:CGRectMake(15, 0, __gScreenWidth-30, 44)];
            break;
        }
        case SLButtonPageMinorOperate:
        {
            [btn setBackgroundImage:[UIImage sl_imageWithColor:[UIColor hexChangeFloat:@"ffffff"]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage sl_imageWithColor:[UIColor hexChangeFloat:@"f6f6f6"]] forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor hexChangeFloat:@"666666"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:@"cacaca"] forState:UIControlStateHighlighted];
            btn.titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_18];
            btn.layer.borderColor = [[UIColor hexChangeFloat:@"e6e6e6"] CGColor];
            btn.layer.borderWidth = .5f;
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            [btn setFrame:CGRectMake(15, 0, __gScreenWidth-30, 44)];
            break;
        }
        case SLButtonBottomHover:
        {
            [btn setBackgroundImage:[UIImage sl_imageWithColor:[UIColor hexChangeFloat:@"ffffff"]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage sl_imageWithColor:[UIColor hexChangeFloat:@"f6f6f6"]] forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor hexChangeFloat:@"4285f4"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:@"9ab7f5"] forState:UIControlStateHighlighted];
            btn.titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_15];
            btn.layer.borderColor = [[UIColor hexChangeFloat:@"e6e6e6"] CGColor];
            btn.layer.borderWidth = .5f;
            [btn setFrame:CGRectMake(0, 0, __gScreenWidth, 50)];
            break;
        }
        case SLButtonContentOperate:
        {
            [btn setBackgroundImage:[UIImage sl_imageWithColor:[UIColor hexChangeFloat:@"ffffff"]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage sl_imageWithColor:[UIColor hexChangeFloat:@"f6f6f6"]] forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor hexChangeFloat:@"4285f4"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexChangeFloat:@"9ab7f5"] forState:UIControlStateHighlighted];
            btn.titleLabel.font = [UIFont systemFontOfSize:__kSL_Text_15];
            btn.layer.borderColor = [[UIColor hexChangeFloat:@"e6e6e6"] CGColor];
            btn.layer.borderWidth = .5f;
            [btn setFrame:CGRectMake(0, 0, __gScreenWidth, 60)];
            break;
        }
        default:
            break;
    }
}
@end
