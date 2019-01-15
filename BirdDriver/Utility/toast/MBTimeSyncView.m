//
//  ECalendar-Pro
//
//  Created by etouch on 14-8-13.
//  Copyright (c) 2014年 etouch. All rights reserved.
//

#import "MBTimeSyncView.h"

@implementation MBTimeSyncView
#pragma mark - Public Methods

- (void)startForSync{
    if(isLoading){
        return;
    }
    isLoading = YES;
    [hourHand removeAllAnimations];
    CABasicAnimation *rotateAnimationHour = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimationHour.repeatCount = HUGE_VALF;
    rotateAnimationHour.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimationHour.duration = 9.6f;
    rotateAnimationHour.fromValue = @(0);
    rotateAnimationHour.removedOnCompletion = NO;
    rotateAnimationHour.toValue = @(2*M_PI);
    [hourHand addAnimation:rotateAnimationHour forKey:@"refreshButtonRotation"];
    
    [minHand removeAllAnimations];
    CABasicAnimation *rotateAnimationMin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimationMin.repeatCount = HUGE_VALF;
    rotateAnimationMin.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimationMin.duration = 0.8f;
    rotateAnimationMin.fromValue = @(0);
    rotateAnimationMin.removedOnCompletion = NO;
    rotateAnimationMin.toValue = @(2*M_PI);
    [minHand addAnimation:rotateAnimationMin forKey:@"refreshButtonRotation"];}

- (void)stopForSync{
    isLoading = NO;
    [hourHand removeAllAnimations];
    [minHand removeAllAnimations];
}

float Degrees2Radians(float degrees){
    return degrees * M_PI / 180;
}

//customize appearence
- (void)setHourHandImage:(CGImageRef)image{
	hourHand.contents = (__bridge id)image;
}

- (void)setMinHandImage:(CGImageRef)image{
	minHand.contents = (__bridge id)image;
}

- (void)setClockBackgroundImage:(CGImageRef)image{
	containerLayer.contents = (__bridge id)image;
}

#pragma mark - Overrides
- (void)layoutSubviews{
	[super layoutSubviews];
	containerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	CGPoint c = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
	hourHand.position = minHand.position = c;
	CGFloat w, h;
//    w = CGImageGetWidth((CGImageRef)hourHand.contents)*0.5;
//    h = CGImageGetHeight((CGImageRef)hourHand.contents)*0.5;
    w = self.frame.size.width*0.7;
    h = self.frame.size.height*0.9;
	hourHand.bounds = CGRectMake(0,0,w,h);
//    w = CGImageGetWidth((CGImageRef)minHand.contents)*0.5;
//    h = CGImageGetHeight((CGImageRef)minHand.contents)*0.5;
    w = self.frame.size.width*0.9;
    h = self.frame.size.height*0.9;
	minHand.bounds = CGRectMake(0,0,w,h);
}

- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if(self){
		containerLayer = [CALayer layer];
		hourHand = [CALayer layer];
		minHand = [CALayer layer];
		//default appearance
		[self setClockBackgroundImage:NULL];
		[self setHourHandImage:NULL];
		[self setMinHandImage:NULL];
		//add all created sublayers
		[containerLayer addSublayer:hourHand];
		[containerLayer addSublayer:minHand];
		[self.layer addSublayer:containerLayer];
	}
	return self;
}

- (void)dealloc{
    [self stopForSync];
}

@end





