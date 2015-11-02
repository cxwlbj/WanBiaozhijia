//
//  DiscoverViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"

@interface DiscoverViewController : BaseViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *btnScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *btnImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;


@end
