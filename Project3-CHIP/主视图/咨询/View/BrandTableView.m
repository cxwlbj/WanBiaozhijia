//
//  BrandTableView.m
//  Project3-CHIP
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BrandTableView.h"
#import "BrandTableViewCell.h"
#import "BrandModel.h"
@implementation BrandTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 70;
    }
    return self;
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _brandList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = [_keys objectAtIndex:section];
    NSArray *arr = [_brandList objectForKey:key];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"tableCellID";
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BrandTableViewCell" owner:nil options:nil] lastObject];
    }
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSArray *arr = [_brandList objectForKey:key];
    cell.brandModel = arr[indexPath.row];
    return cell;
}

//设置组的头视图
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_keys objectAtIndex:section];
}

//建立索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _keys;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSArray *arr = [_brandList objectForKey:key];
    BrandModel *model = arr[indexPath.row];
    NSString *brandId = model.brandid;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"brandid" object:brandId];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
