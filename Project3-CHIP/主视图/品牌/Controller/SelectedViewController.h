//
//  SelectedViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectedViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_selectData;
}
@end
