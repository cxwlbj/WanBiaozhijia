//
//  ContentTableViewCell2.m
//  Project3-CHIP
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ContentTableViewCell2.h"

@implementation ContentTableViewCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)setHomeModel:(HomeModel *)homeModel{
    if (_homeModel != homeModel) {
        _homeModel = homeModel;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.brandImgView sd_setImageWithURL:[NSURL URLWithString:self.homeModel.image]];
    self.brandNameLabel.text = self.homeModel.name;
    self.themeLabel.text = [NSString stringWithFormat:@"主题:  %@", self.homeModel.theme];
    self.postLabel.text = [NSString stringWithFormat:@"贴数:  %@", self.homeModel.post];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
