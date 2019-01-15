//
//  SLActionSheetTimePicker.h
//  SmartLife
//
//  Created by han on 2017/3/31.
//
//

#import <UIKit/UIKit.h>

@class SLActionSheetTimePicker;

typedef void(^actionTimeDoneBlock)(SLActionSheetTimePicker *picker, NSInteger selectedSecond);
typedef void(^actionTimeCancelBlock)(SLActionSheetTimePicker *picker);

@interface SLActionSheetTimePicker : UIView

- (instancetype)initWithTitle:(NSString *)title
                 curSecond:(NSInteger)curSecond
                    doneBlock:(actionTimeDoneBlock)doneBlock
                  cancelBlock:(actionTimeCancelBlock)cancelBlock;

- (void)show;

@end
