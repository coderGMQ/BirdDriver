//
//  MBTimeProgressView.m
//  ECalendar-Pro
//
//  Created by etouch on 14-8-13.
//  Copyright (c) 2014年 etouch. All rights reserved.
//

#import "MBTimeProgressView.h"

@implementation MBTimeProgressView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        // Initialization code
        bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgImageView.image = [UIImage imageNamed:@"ic_clock"];
        [self addSubview:bgImageView];
        
        hourImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        hourImageView.image = [UIImage imageNamed:@"ic_clock_hour"];
        [self addSubview:hourImageView];
        
        minImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        minImageView.image = [UIImage imageNamed:@"ic_clock_min"];
        
        [self addSubview:minImageView];
    }
    return self;
}

- (void)startAnimation{
    [self animation];
}

- (void)animation{
    [hourImageView.layer removeAllAnimations];
    CABasicAnimation* rotateAnimationHour = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimationHour.repeatCount = HUGE_VALF;
    rotateAnimationHour.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimationHour.duration = 9.6f;
    rotateAnimationHour.fromValue = @(0);
    rotateAnimationHour.removedOnCompletion = NO;
    rotateAnimationHour.toValue = @(2*M_PI);
    [hourImageView.layer addAnimation:rotateAnimationHour forKey:@"refreshButtonRotation"];
    
    [minImageView.layer removeAllAnimations];
    CABasicAnimation *rotateAnimationMin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimationMin.repeatCount = HUGE_VALF;
    rotateAnimationMin.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimationMin.duration = 0.8f;
    rotateAnimationMin.fromValue = @(0);
    rotateAnimationMin.removedOnCompletion = NO;
    rotateAnimationMin.toValue = @(2*M_PI);
    [minImageView.layer addAnimation:rotateAnimationMin forKey:@"refreshButtonRotation"];
}

- (void)stopAnimation{
    [hourImageView.layer removeAllAnimations];
    [minImageView.layer removeAllAnimations];
}

@end


