//
//  BDMineUserProfileView.h
//  SmartLife
//
//  Created by han on 2017/3/6.
//
//

#import <UIKit/UIKit.h>
#import "EBaseView.h"
#import "RootViewController.h"

@interface BDMineUserProfileView : EBaseView
@property (nonatomic, copy) void (^authTapBlock)();
@end
