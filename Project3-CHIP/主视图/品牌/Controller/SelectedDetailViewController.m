//
//  SelectedDetailViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/10/6.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "SelectedDetailViewController.h"

@interface SelectedDetailViewController ()
{
    UIWebView *_webView;
    NSArray *_titleArr;
    UITableView *_tableView;
}
@end

@implementation SelectedDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    if (self.searchStr == nil) {
        [self _initTableView];
    } else{
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_webView];
        NSString *url = [Base_url1 stringByAppendingString:self.searchStr];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_webView loadRequest:request];
    }
    
    
    _titleArr = @[@"不限", @"白达翡丽", @"朗格", @"宝玑", @"江诗丹顿", @"积家", @"宝珀", @"卡地亚"];
}

- (void)_initTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    
    cell.textLabel.text = _titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"price" object:_titleArr[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
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
