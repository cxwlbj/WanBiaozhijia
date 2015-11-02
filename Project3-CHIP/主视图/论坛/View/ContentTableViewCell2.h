//
//  ContentTableViewCell2.h
//  Project3-CHIP
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface ContentTableViewCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *brandImgView;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (nonatomic, strong) HomeModel *homeModel;

@end
