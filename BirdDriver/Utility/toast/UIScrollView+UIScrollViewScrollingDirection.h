//
//  UIScrollView+UIScrollViewScrollingDirection.h
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ScrollDirection {
  ScrollDirectionNone,
  ScrollDirectionRight,
  ScrollDirectionLeft,
  ScrollDirectionUp,
  ScrollDirectionDown,
  ScrollDirectionCrazy,
} ScrollDirection;

@interface UIScrollView (UIScrollViewScrollingDirection)

- (int)scrollDirectionX;
- (int)scrollDirectionY;

- (CGPoint)lastContentOffset;
- (void)setLastContentOffset:(CGPoint)contentOffset;

@end



