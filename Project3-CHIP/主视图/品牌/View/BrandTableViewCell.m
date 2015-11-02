//
//  BrandTableViewCell.m
//  Project3-CHIP
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BrandTableViewCell.h"

@implementation BrandTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _watchImgView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setBrandModel:(BrandModel *)brandModel{
    if (_brandModel != brandModel) {
        _brandModel = brandModel;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_watchImgView sd_setImageWithURL:[NSURL URLWithString:self.brandModel.img]];
    
    _eNameLabel.text = self.brandModel.ename;
    _cNameLabel.text = self.brandModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
