//
//  BDServiceCell.m
//  SmartLife
//
//  Created by 甘明强 on 2017/6/8.
//
//

#import "BDServiceCell.h"

@interface BDServiceCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (nonatomic, strong) BDServiceBean *bean;
@end

@implementation BDServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setDataWithBean:(BDServiceBean *)bean {
    self.bean = bean;
    [self.iconImageView slSetImageWithName:self.bean.imageName];
    self.titlelabel.text = self.bean.titleName;
}
@end
