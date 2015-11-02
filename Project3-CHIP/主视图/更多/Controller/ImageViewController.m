//
//  ImageViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/10/4.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
{
    NSArray *titleArr;
    NSArray *title_fArr;
}
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图片质量";
    [self _initView];
    titleArr = @[@"自动选择", @"高质量图片", @"低质量图片"];
    title_fArr = @[@"(WiFi下高，2G/3G下低)", @"(更清晰)", @"(更省流量)"];
}

- (void)_initView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 200, 30)];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:label];
    cell.textLabel.text = titleArr[indexPath.row];
    label.text = title_fArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
