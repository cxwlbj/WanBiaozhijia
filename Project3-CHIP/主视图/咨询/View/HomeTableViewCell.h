//
//  HomeTableViewCell.h
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger typeID;

@property (weak, nonatomic) IBOutlet UIImageView *watchImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *brandLabel;

@property (nonatomic, strong) HomeModel *model;

@end
