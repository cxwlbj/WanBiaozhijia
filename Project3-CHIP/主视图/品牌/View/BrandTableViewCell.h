//
//  BrandTableViewCell.h
//  Project3-CHIP
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandModel.h"
@interface BrandTableViewCell : UITableViewCell

@property (nonatomic, strong) BrandModel *brandModel;
@property (weak, nonatomic) IBOutlet UIImageView *watchImgView;
@property (weak, nonatomic) IBOutlet UILabel *eNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cNameLabel;


@end
