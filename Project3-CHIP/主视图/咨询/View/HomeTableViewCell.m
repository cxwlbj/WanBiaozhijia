//
//  HomeTableViewCell.m
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(HomeModel *)model{
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.watchImgView sd_setImageWithURL:[NSURL URLWithString:self.model.img]];
    
    self.titleLabel.text = self.model.title;
    
    if (_typeID == 1) {
        self.brandLabel.hidden = NO;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        //修改时间的格式将其从2015-09-27 09:53:30转换成2015-09-27
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:self.model.inputtime];
//        NSLog(@"%@", self.model.inputtime);
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeStr = [formatter stringFromDate:date];
        self.timeLabel.text = timeStr;
        self.brandLabel.text = self.model.brand_name;
    } else if (_typeID == 2){
        self.brandLabel.hidden = NO;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.text = [NSString stringWithFormat:@"%@次阅读", self.model.hits];
        self.brandLabel.text = [NSString stringWithFormat:@"%@条评论", self.model.comment_count];
    } else if (_typeID == 3){
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        //修改时间的格式将其从2015-09-27 09:53:30转换成2015-09-27
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:self.model.inputtime];
        //        NSLog(@"%@", self.model.inputtime);
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeStr = [formatter stringFromDate:date];
        self.timeLabel.text = timeStr;
        self.brandLabel.hidden = YES;
    }

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
