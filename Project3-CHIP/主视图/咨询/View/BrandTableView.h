//
//  BrandTableView.h
//  Project3-CHIP
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *brandList;
@property (nonatomic, strong) NSArray *keys;

@end
