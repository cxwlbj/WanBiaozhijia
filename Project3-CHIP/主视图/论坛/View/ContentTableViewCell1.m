//
//  ContentTableViewCell1.m
//  Project3-CHIP
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ContentTableViewCell1.h"

@implementation ContentTableViewCell1

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
    self.titleLabel.text = self.homeModel.title;
    [self.watchImgView sd_setImageWithURL:[NSURL URLWithString:self.homeModel.img]];
    self.authorLabel.text = self.homeModel.author_name;
    self.brandLabel.text = self.homeModel.brand_name;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
