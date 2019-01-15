//
//  SLActionSheetStringPicker.h
//  SmartLife
//
//  Created by han on 2017/3/17.
//
//

#import <UIKit/UIKit.h>

typedef void(^clickedIndexBlock)(NSInteger index);

@interface SLActionSheetStringPicker : UIView
- (instancetype)initWithTitle:(NSString *)title
               clickedAtIndex:(clickedIndexBlock)block
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles;
- (void)show;
@end
