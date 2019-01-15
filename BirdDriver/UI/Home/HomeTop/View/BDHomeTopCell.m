//
//  BDHomeTopCell.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/8.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDHomeTopCell.h"

@interface BDHomeTopCell ()
@property (nonatomic, strong) BDHomeTopBean *bean;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation BDHomeTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setDataWithBean:(BDHomeTopBean *)bean {
    _bean = bean;
    self.imageView.image = [UIImage imageNamed:bean.imageName];
    self.titleLabel.text = bean.title;
}

@end
