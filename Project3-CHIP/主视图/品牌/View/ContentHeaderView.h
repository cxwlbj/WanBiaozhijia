//
//  ContentHeaderView.h
//  Project3-CHIP
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentModel.h"
@interface ContentHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *watchImgView;
@property (weak, nonatomic) IBOutlet UILabel *watchName;
@property (weak, nonatomic) IBOutlet UILabel *watchNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *brandImgView;

@property (weak, nonatomic) IBOutlet UILabel *price_rmb;
@property (weak, nonatomic) IBOutlet UILabel *price_usa;

@property (weak, nonatomic) IBOutlet UILabel *price_hk;

@property (weak, nonatomic) IBOutlet UIImageView *boxImgView;

@property (weak, nonatomic) IBOutlet UILabel *imgNumLabel;
@property (weak, nonatomic) IBOutlet UIView *showImageView;


@property (nonatomic, strong) ContentModel *headerModel;

@end
