//
//  EBaseView.h
//  SmartLife
//
//  Created by Potter on 2017/3/2.
//
//

#import <UIKit/UIKit.h>
#import "ENavigationView.h"
#import "EContentView.h"

@interface EBaseView : UIView
@property (nonatomic,strong) UIView *__statusBarView;
@property (nonatomic,strong) ENavigationView *__navigationView;
@property (nonatomic,strong) UIView *__navigationViewLine;
@property (nonatomic,strong) EContentView * __contentView;
@property (nonatomic,strong,setter = setTitle:) NSString *__title;
@property (nonatomic, strong) UILabel *__titleLabel;
//把ContentView全屏
- (void)setFullScreen;
@end
