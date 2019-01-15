//
//  EBackgroundView.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "EBackgroundView.h"

@interface EBackgroundView ()

@end

@implementation EBackgroundView

@synthesize __foregroundImgView;
@synthesize __foregroundRect;

- (void)dealloc {

}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)initBackgroundView {
    self.backgroundColor = [UIColor hexChangeFloat:__kSL_White_01];
}

- (void)setForegroundRect:(CGRect)rect {

}


@end
