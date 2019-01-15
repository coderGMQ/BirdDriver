//
//  MBTimeSyncView.h
//  ECalendar-Pro
//
//  Created by B.E.N on 14-8-20.
//  Copyright (c) 2014年 etouch. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface MBTimeSyncView : UIView{
    CALayer *containerLayer;
	CALayer *hourHand;
	CALayer *minHand;
    BOOL isLoading;
}
//customize appearence
- (void)setHourHandImage:(CGImageRef)image;
- (void)setMinHandImage:(CGImageRef)image;
- (void)setClockBackgroundImage:(CGImageRef)image;
- (void)startForSync;
- (void)stopForSync;
@end



