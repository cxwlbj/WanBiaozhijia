//
//  ContentHeaderView.m
//  Project3-CHIP
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ContentHeaderView.h"
#import "ImageShowViewController.h"
#import "ImageDetailViewController.h"
@implementation ContentHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setHeaderModel:(ContentModel *)headerModel{
    if (_headerModel != headerModel) {
        _headerModel = headerModel;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.watchImgView sd_setImageWithURL:[NSURL URLWithString:self.headerModel.image]];
    self.watchName.text = self.headerModel.title;
    self.watchNumLabel.text = self.headerModel.model;
    [self.brandImgView sd_setImageWithURL:[NSURL URLWithString:self.headerModel.brand_logo]];
    self.price_rmb.text = self.headerModel.price_rmb;
    self.price_usa.text = self.headerModel.price_usa;
    self.price_hk.text = self.headerModel.price_hk;
    
    self.imgNumLabel.text = [NSString stringWithFormat:@"%ld", self.headerModel.pics.count];
    NSArray *pics = self.headerModel.pics;
    
    if (pics.count != 0) {
        for (int i = 0 ; i < MIN(3, pics.count); i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 100) / 3 * i + 10, 20, 70, 70)];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            [imageView sd_setImageWithURL:[NSURL URLWithString:pics[i]]];
            [self.showImageView addSubview:imageView];
        }
    }
    
}

//手势触发的事件
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    ImageDetailViewController *imgDetailVC = [[ImageDetailViewController alloc] init];
    imgDetailVC.index = tap.view.tag;
    imgDetailVC.data = self.headerModel.pics;
    [self.viewController.navigationController pushViewController:imgDetailVC animated:YES];
    
}

//图片按钮的触发事件
- (IBAction)imgBtnAction:(UIButton *)sender {
    
    ImageShowViewController *imgShowVC = [[ImageShowViewController alloc] init];
    imgShowVC.title = self.headerModel.model;
    imgShowVC.picsArr = self.headerModel.pics;
    [self.viewController.navigationController pushViewController:imgShowVC animated:YES];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
