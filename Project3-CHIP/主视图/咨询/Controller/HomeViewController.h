//
//  HomeViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"
#import "TableHeightView.h"
#import "BrandTableView.h"
@interface HomeViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    TableHeightView *_heightView;
    NSMutableArray *_tableData;
    NSInteger _type;
    NSInteger page1;
    NSInteger page2;
    NSInteger page3;
    BrandTableView *_brandTableView;
}
@property (weak, nonatomic) IBOutlet UIView *selectedView;

@end
