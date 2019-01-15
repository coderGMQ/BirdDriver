//
//  UIView+Custom.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)

- (UIViewController *)viewController{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    // If the view controller isn't found, return nil.
    return nil;
}

- (void)setShadowWithOffset:(CGSize)shadowSize andShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = shadowSize;//shadowOffset阴影偏移，默认(0, -3)
    self.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    self.layer.shadowRadius = 0;//阴影半径，默认3
}


- (UIView *)viewWithTag:(NSInteger)tag adjoinFatherView:(BOOL)adjoin{
    UIView * resultView = nil;
    if(adjoin){
        for(UIView * subView in self.subviews){
            if(subView.tag == tag){
                resultView = subView;
                break;
            }
        }
    }else{
        resultView = [self viewWithTag:tag];
    }
    return resultView;
}

@end



