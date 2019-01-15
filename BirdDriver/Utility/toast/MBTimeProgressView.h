//
//  MBTimeProgressView.h
//  ECalendar-Pro
//
//  Created by etouch on 14-8-13.
//  Copyright (c) 2014年 etouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBTimeProgressView : UIView{
    UIImageView * bgImageView;
    UIImageView * hourImageView;
    UIImageView * minImageView;
}
- (void)startAnimation;
- (void)stopAnimation;
@end
