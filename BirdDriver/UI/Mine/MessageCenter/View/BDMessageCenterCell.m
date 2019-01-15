//
//  BDMessageCenterCell.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/11.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDMessageCenterCell.h"
#import "BDMessageCenterDetailViewController.h"

@interface BDMessageCenterCell ()
{
    __weak IBOutlet UIButton *_checkDetailBtn;
    __weak IBOutlet UIImageView *_messageImageView;
    __weak IBOutlet UILabel *_setTopLabel;
}
@end

@implementation BDMessageCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _checkDetailBtn.layer.cornerRadius = 3;
    _checkDetailBtn.layer.borderColor = [UIColor hexChangeFloat:__kSL_Blue_01].CGColor;
    _checkDetailBtn.layer.borderWidth = 1;

}
- (IBAction)_btnClick:(UIButton *)sender {
    if (sender == _checkDetailBtn) {
        BDMessageCenterDetailViewController *vc = [[BDMessageCenterDetailViewController alloc]init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

- (void)isNeedSetTop:(BOOL)needSetTop {
    if (needSetTop) {
        _setTopLabel.hidden = NO;
        _messageImageView.hidden = YES;
    } else {
        _setTopLabel.hidden = YES;
        _messageImageView.hidden = NO;
    }
}
@end
