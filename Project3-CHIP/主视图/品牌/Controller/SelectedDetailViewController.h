//
//  SelectedDetailViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/10/6.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"
#define Base_url1 @"http://watch.xbiao.com/"

@interface SelectedDetailViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSString *searchStr;

@end
