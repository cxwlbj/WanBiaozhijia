//
//  BrandViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"

@interface BrandViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableDictionary *_brandList;
}

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;


@end
