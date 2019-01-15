//
//  SLActionSheetDatePicker.h
//  SmartLife
//
//  Created by han on 2017/3/17.
//
//

#import <UIKit/UIKit.h>

@class SLActionSheetDatePicker;

typedef void(^actionDateDoneBlock)(SLActionSheetDatePicker *picker, NSDate *selectedDate);
typedef void(^actionDateCancelBlock)(SLActionSheetDatePicker *picker);

@interface SLActionSheetDatePicker : UIView

@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;

- (instancetype)initWithTitle:(NSString *)title
               datePickerMode:(UIDatePickerMode)datePickerMode
                 selectedDate:(NSDate *)selectedDate
                    doneBlock:(actionDateDoneBlock)doneBlock
                  cancelBlock:(actionDateCancelBlock)cancelBlock;

- (void)show;
@end
