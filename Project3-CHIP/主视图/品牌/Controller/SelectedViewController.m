//
//  SelectedViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "SelectedViewController.h"
#import "BrandModel.h"
#import "SelectedDetailViewController.h"
#import "ContentWebViewController.h"
@interface SelectedViewController ()

@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self _initViews];
    [self _loadData];
    [self initButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"price" object:nil];
}

- (void)notificationAction:(NSNotification *)notification{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:200];
    label.text = notification.object;
}
//初始化button
- (void)initButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 63, 34);
    [btn setImage:[UIImage imageNamed:@"ok.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)sureBtnAction:(UIButton *)btn{
    ContentWebViewController *contentWebVC = [[ContentWebViewController alloc] init];
    contentWebVC.webUrl = @"http://watch.xbiao.com/productlist//p2/a2//0/////";
    contentWebVC.title = @"筛选结果";
    [self.navigationController pushViewController:contentWebVC animated:YES];
}

//初始化View
- (void)_initViews{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.height -= 64;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70;
    [self.view addSubview:_tableView];
}

#pragma mark -loadData
- (void)_loadData{
    
    [DataService requestDataWithAllURL:@"http://watch.xbiao.com/productsearch/" params:nil httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in result) {
            BrandModel *model = [[BrandModel alloc] initContentWithDic:dic];
            model.urlStr = [dic objectForKey:@"url"];
            [mArr addObject:model];
        }
        _selectData = mArr;
        [_tableView reloadData];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"selected%@", error);
    }];
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _selectData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"Cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.right - 75, 20, 100, 30)];
            label.tag = 200;
            label.textAlignment = NSTextAlignmentRight;
            label.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label];
        }
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    cell.textLabel.text = [_selectData[indexPath.row] name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BrandModel *model = _selectData[indexPath.row];
    SelectedDetailViewController *selectedDetailVC = [[SelectedDetailViewController alloc] init];
    if (indexPath.row == 0) {
        selectedDetailVC.searchStr = nil;
    } else{
        selectedDetailVC.searchStr = [NSString stringWithFormat:@"productsearch/?p=%@", model.url];
    }

    [self.navigationController pushViewController:selectedDetailVC animated:YES];
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
