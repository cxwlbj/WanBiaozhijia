//
//  ShareContentViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"

@interface ShareContentViewController : BaseViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *shareImgView;
@property (weak, nonatomic) IBOutlet UITextView *shareTextView;
@property (nonatomic, copy) NSString *urlStr;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
