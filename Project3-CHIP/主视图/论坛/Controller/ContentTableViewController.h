//
//  ContentTableViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentTableViewController : UITableViewController
{
    NSMutableArray *_tableData;
}

@property (nonatomic, copy) NSString *urlStr;

@end
