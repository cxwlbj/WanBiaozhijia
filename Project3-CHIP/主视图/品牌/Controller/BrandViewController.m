//
//  BrandViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BrandViewController.h"
#import "BrandModel.h"
#import "BrandTableViewCell.h"
#import "BrandDetailViewController.h"
#import "SearchViewController.h"
#import "SelectedViewController.h"
@interface BrandViewController ()
{
    NSArray *keys;
}
@end

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"腕表品牌大全";
    self.navigationController.navigationBar.translucent = NO;

    //初始化视图
    [self _initViews];
    //加载数据
    [self _loadData];
    [self showHUD:@"正在加载"];
}
//初始化视图
- (void)_initViews{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;

    _tableView.delegate = self;
    _tableView.rowHeight = 70;
    _tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    //设置索引值的背景颜色
    _tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
    //设置索引值的颜色
    _tableView.sectionIndexColor = [UIColor blueColor];

    [self.view insertSubview:_tableView atIndex:0];
    
    
    
}

#pragma mark - LoadData
//加载数据
- (void)_loadData{
    [DataService requestDataWithURL:kBrandList params:nil httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        _brandList = [NSMutableDictionary dictionary];
        NSMutableArray *modelArr = nil;
        keys = [result allKeys];
        keys = [keys sortedArrayUsingSelector:@selector(compare:)];
        for (NSString *key in keys) {
            NSArray *values = [result objectForKey:key];
            for (NSDictionary *dic in values) {
                if ([_brandList objectForKey:key] == nil) {
                    modelArr = [NSMutableArray array];
                    [_brandList setObject:modelArr forKey:key];
                }
                BrandModel *model = [[BrandModel alloc] initContentWithDic:dic];
                [modelArr addObject:model];
            }
        }
        [_tableView reloadData];
        [self hiddenHUD];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"brand error:%@", error);
        [self completeHUD:@"加载失败"];
    }];
}
#pragma mark -BtnClick
//筛选按钮触发的事件
- (IBAction)selectedAction:(UIButton *)sender {
    
    SelectedViewController *selectedVC = [[SelectedViewController alloc] init];
    selectedVC.title = @"筛选";
    [self.navigationController pushViewController:selectedVC animated:YES];
}


//搜索按钮触发的事件
- (IBAction)searchAction:(UIButton *)sender {
    NSString *text = _searchTextField.text;
    if (text.length == 0) {
        return;
    }
    NSString *strB = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.searchStr = [NSString stringWithFormat:@"app/productList2_1/bname/%@", strB];
    searchVC.title = [NSString stringWithFormat:@"搜:%@", text];
    [self.navigationController pushViewController:searchVC animated:YES];
}



#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _brandList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = [keys objectAtIndex:section];
    NSArray *arr = [_brandList objectForKey:key];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BrandTableViewCell" owner:nil options:nil] lastObject];
    }
    NSString *key = [keys objectAtIndex:indexPath.section];
    NSArray *arr = [_brandList objectForKey:key];
    cell.brandModel = arr[indexPath.row];
    return cell;
}
//设置组的头视图
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [keys objectAtIndex:section];
}

//建立索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return keys;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BrandDetailViewController *brandDetailVC = [[BrandDetailViewController alloc] init];
    NSString *key = [keys objectAtIndex:indexPath.section];
    NSArray *arr = [_brandList objectForKey:key];
    BrandModel *model = arr[indexPath.row];
    brandDetailVC.linkID = [NSString stringWithFormat:@"%@", model.brandid];
    brandDetailVC.title = model.name;
    [self.navigationController pushViewController:brandDetailVC animated:YES];
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
