//
//  MoreViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"

@interface MoreViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_moreData;
    
    __weak IBOutlet UITableView *_tableView;
}
@end
