//
//  ImageViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/10/4.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"

@interface ImageViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}
@end
