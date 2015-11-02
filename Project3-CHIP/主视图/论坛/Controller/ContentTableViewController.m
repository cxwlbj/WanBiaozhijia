//
//  ContentTableViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ContentTableViewController.h"
#import "HomeModel.h"
#import "ContentTableViewCell1.h"
#import "ContentTableViewCell2.h"
#import "ContentWebViewController.h"
@interface ContentTableViewController ()
{
    NSString *groupTitle;
    NSInteger page;
}
@end

@implementation ContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor orangeColor];
    [self loadData];
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadFormterData)];
}

- (void)loadData{
    [DataService requestDataWithAllURL:_urlStr params:nil httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSArray *arr = [result objectForKey:@"data"];
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                groupTitle = result[@"title"];
                HomeModel *model = [[HomeModel alloc] initContentWithDic:dic];
                [mArr addObject:model];
            }
            _tableData = mArr;
            [self.tableView reloadData];
        } else{
            for (NSDictionary *dic in result) {
                groupTitle = dic[@"title"];
                NSArray *arr = [dic objectForKey:@"data"];
                NSMutableArray *mArr = [NSMutableArray array];
                for (NSDictionary *mdic in arr) {
                    HomeModel *model = [[HomeModel alloc] initContentWithDic:mdic];
                    [mArr addObject:model];
                }
                _tableData = mArr;
                [self.tableView reloadData];
            }
        }
        
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"tableView%@", error);
    }];
}

- (void)loadNewData{
    
    [DataService requestDataWithAllURL:_urlStr params:nil httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSArray *arr = [result objectForKey:@"data"];
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                groupTitle = result[@"title"];
                HomeModel *model = [[HomeModel alloc] initContentWithDic:dic];
                [mArr addObject:model];
            }
            _tableData = mArr;
            [self.tableView reloadData];
        } else{
            for (NSDictionary *dic in result) {
                groupTitle = dic[@"title"];
                NSArray *arr = [dic objectForKey:@"data"];
                NSMutableArray *mArr = [NSMutableArray array];
                for (NSDictionary *mdic in arr) {
                    HomeModel *model = [[HomeModel alloc] initContentWithDic:mdic];
                    [mArr addObject:model];
                }
                _tableData = mArr;
                [self.tableView reloadData];
            }
        }
        
        [self.tableView headerEndRefreshing];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"newData%@", error);
        [self.tableView headerEndRefreshing];
    }];
}

- (void)loadFormterData{
    
    page++;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(page + 1) forKey:@"page"];
    
    [DataService requestDataWithAllURL:_urlStr params:params httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSArray *arr = [result objectForKey:@"data"];
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                groupTitle = result[@"title"];
                HomeModel *model = [[HomeModel alloc] initContentWithDic:dic];
                [mArr addObject:model];
            }
            [_tableData addObjectsFromArray:mArr];
            [self.tableView reloadData];
        } else{
            for (NSDictionary *dic in result) {
                groupTitle = dic[@"title"];
                NSArray *arr = [dic objectForKey:@"data"];
                NSMutableArray *mArr = [NSMutableArray array];
                for (NSDictionary *mdic in arr) {
                    HomeModel *model = [[HomeModel alloc] initContentWithDic:mdic];
                    [mArr addObject:model];
                }
                [_tableData addObjectsFromArray:mArr];
                [self.tableView reloadData];
            }
        }
        
        [self.tableView footerEndRefreshing];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"newData%@", error);
        [self.tableView footerEndRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _tableData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellid";
    HomeModel *model = _tableData[indexPath.row];
    if ([model.post integerValue] > 0 || [model.theme integerValue] > 0) {
        tableView.rowHeight = 70;
        ContentTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ContentTableViewCell2" owner:nil options:nil] lastObject];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.homeModel = model;
        return cell;
    }
    tableView.rowHeight = 200;
    ContentTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContentTableViewCell1" owner:nil options:nil] lastObject];
    }
    cell.homeModel = model;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (groupTitle.length == 0) {
        return @"热门腕表作业贴";
    }
    return groupTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model = _tableData[indexPath.row];
    ContentWebViewController *contentWebVC = [[ContentWebViewController alloc] init];
    contentWebVC.webUrl = model.url;
    if (model.name.length == 0) {
        contentWebVC.title = @"贴子正文";
    } else{
        contentWebVC.title = model.name;
    }
    [self.navigationController pushViewController:contentWebVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
