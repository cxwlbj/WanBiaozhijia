//
//  HomeViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "HomeTableViewCell.h"
#import "BrandContentViewController.h"
#import "BrandModel.h"
@interface HomeViewController ()
{
    UIImageView *_selectImgView;
//    NSMutableDictionary *_brandList;
//    NSArray *keys;
    NSString *_cityId;
}
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *navImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 140) / 2, 0, 140, 40)];
    navImgView.tag = 300;
    navImgView.image = [UIImage imageNamed:@"inf_logo.png"];
    [self.navigationController.navigationBar addSubview:navImgView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    //初始化视图
    [self _initViews];
    //初始化按钮
    [self _initButton];
    //初始化头视图数据
    [self _loadHeaderData];
    _type = 1;
    //获取表视图数据
    [self _loadTabelData:kList type:@1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"brandid" object:nil];
    
    [self showHUD:@"正在加载"];
}

#pragma mark -NSNotificationCenter
- (void)notificationAction:(NSNotification *)notification{
    _type = 3;
    _cityId = notification.object;
    UIButton *btn = (UIButton *)[_selectedView viewWithTag:202];
    btn.hidden = NO;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _selectImgView.center = btn.center;
    NSString *brandName;
    for (NSString *key in _brandTableView.keys) {
        NSArray *arr = _brandTableView.brandList[key];
        for (BrandModel *model in arr) {
            if (model.brandid == _cityId) {
                brandName = model.name;
                break;
            }
        }
    }
    
    [btn setTitle:brandName forState:UIControlStateNormal];
    UIButton *btn1 = (UIButton *)[_selectedView viewWithTag:203];
//    btn1.transform = CGAffineTransformIdentity;
    btn1.left = btn.right + 10;
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self _loadTabelData:kList type:@3];
    [self showHUD:@"正在加载"];
    _tableView.tableHeaderView = nil;
    [self.view insertSubview:_tableView aboveSubview:_brandTableView];
}


#pragma mark -InitViews
//初始化首页表视图
- (void)_initViews{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 64 - 50) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    _heightView = [[[NSBundle mainBundle] loadNibNamed:@"TableHeightView" owner:nil options:nil] lastObject];
    _tableView.tableHeaderView = _heightView;
//    _tableView.tableHeaderView = nil;
//    _tableView.contentInset = UIEdgeInsetsMake(-200, 0, 0, 0);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view insertSubview:_tableView atIndex:0];
    
    [_tableView addHeaderWithTarget:self action:@selector(loadNewData)];
    [_tableView addFooterWithTarget:self action:@selector(loadFormerData)];
}

- (void)loadNewData{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@0 forKey:@"page"];
    
    if (_type == 1) {
        [params setObject:@1 forKey:@"type"];
        
    } else if (_type == 2){
        [params setObject:@2 forKey:@"type"];
    } else{
        [params setObject:@3 forKeyedSubscript:@"type"];
        [params setObject:_cityId forKeyedSubscript:@"brand"];
    }
    
    [DataService requestDataWithURL:kList params:params httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in result) {
            HomeModel *model = [[HomeModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
        }

        _tableData = mArr;
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"hehe%@", error);
        [_tableView headerEndRefreshing];

    }];
}

- (void)loadFormerData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_type == 1) {
        [params setObject:@1 forKey:@"type"];
        page1 ++;
        [params setObject:@(page1) forKey:@"page"];
    } else if (_type == 2){
        [params setObject:@2 forKey:@"type"];
        page2 ++;
        [params setObject:@(page2) forKey:@"page"];
    } else{
        [params setObject:@3 forKeyedSubscript:@"type"];
        [params setObject:_cityId forKeyedSubscript:@"brand"];
        page3++;
        [params setObject:@(page3) forKeyedSubscript:@"page"];
    }
    
    [DataService requestDataWithURL:kList params:params httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in result) {
            HomeModel *model = [[HomeModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
        }
        [_tableData addObjectsFromArray:mArr];
//        _tableData = mArr;
        [_tableView reloadData];
        [_tableView footerEndRefreshing];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"haha%@", error);
        [_tableView footerEndRefreshing];

    }];
    
}

#pragma mark -InitButton
//初始化选择视图按钮
- (void)_initButton{
    
    _selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 29)];
    _selectImgView.image = [UIImage imageNamed:@"light.png"];

    [_selectedView addSubview:_selectImgView];
    
    NSArray *nameArr = @[@"咨询", @"七日热点", @"", @"选品牌"];
    
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(kScreenWidth / 4 * i + 10, 10, 75, 29);
        if (i == 0) {
            _selectImgView.center = btn.center;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        if (i == 2) {
            btn.hidden = YES;
        }
        if (i == 3) {
//            btn.transform = CGAffineTransformMakeTranslation(-80, 0);
            btn.left -= 80;
        }
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_selectedView addSubview:btn];
    }
    
}
//头视图的选择按钮触发的事件
- (void)selectBtnAction:(UIButton *)btn{
    for (UIView *btnView in _selectedView.subviews) {
        if ([btnView isKindOfClass:[UIButton class]]) {
            if (btnView.tag != btn.tag) {
                UIButton *btn1 =(UIButton *)btnView;
                [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _selectImgView.center = btn.center;

    if (btn.tag == 201) {
        [self showHUD:@"正在加载"];
        _tableView.tableHeaderView = nil;
        [self _loadTabelData:kList type:@2];
        _type = 2;
        [self.view insertSubview:_tableView aboveSubview:_brandTableView];
    } else if (btn.tag == 200){
        [self showHUD:@"正在加载"];
        _tableView.tableHeaderView = _heightView;
        [self _loadTabelData:kList type:@1];
        _type = 1;
        [self.view insertSubview:_tableView aboveSubview:_brandTableView];
    } else if (btn.tag == 203){
        [self showHUD:@"正在加载"];
        _brandTableView = [[BrandTableView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - 40 - 50 - 64) style:UITableViewStylePlain];
//        _brandTableView.height -= 40;
        [self.view insertSubview:_brandTableView aboveSubview:_tableView];
        [self _loadBrandData];
    } else if (btn.tag == 202){
        [self showHUD:@"正在加载"];
        _tableView.tableHeaderView = nil;
        _type = 3;
        [self _loadTabelData:kList type:@3];
        [self.view insertSubview:_tableView aboveSubview:_brandTableView];
    }
}
#pragma mark -LoadData
//加载品牌视图的数据
- (void)_loadBrandData{
    [DataService requestDataWithURL:kBrandList params:nil httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        _brandTableView.brandList = [NSMutableDictionary dictionary];
        NSMutableArray *modelArr = nil;
        _brandTableView.keys = [result allKeys];
       _brandTableView.keys = [_brandTableView.keys sortedArrayUsingSelector:@selector(compare:)];
        for (NSString *key in _brandTableView.keys) {
            NSArray *values = [result objectForKey:key];
            for (NSDictionary *dic in values) {
                if ([_brandTableView.brandList objectForKey:key] == nil) {
                    modelArr = [NSMutableArray array];
                    [_brandTableView.brandList setObject:modelArr forKey:key];
                }
                BrandModel *model = [[BrandModel alloc] initContentWithDic:dic];
                [modelArr addObject:model];
            }
        }
        [_brandTableView reloadData];
        [self hiddenHUD];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"brand error:%@", error);
        [self completeHUD:@"加载失败"];
    }];
}
//加载滚动视图数据
- (void)_loadHeaderData{
    [DataService requestDataWithURL:kImage params:nil httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in result) {
            HomeModel *model = [[HomeModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
        }
        _heightView.imgData = mArr;
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"home%@", error);
    }];
}
//加载表视图数据
- (void)_loadTabelData:(NSString *)urlStr type:(NSNumber *)type{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:type forKey:@"type"];
    if ([type integerValue] == 3) {
        [params setObject:_cityId forKey:@"brand"];
    }
    [DataService requestDataWithURL:urlStr params:params httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in result) {
            HomeModel *model = [[HomeModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
        }
        _tableData = mArr;
        [_tableView reloadData];
        [self hiddenHUD];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [self completeHUD:@"加载失败"];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cellID";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:nil options:nil] lastObject];
        if (_type == 1) {
            cell.typeID = 1;
        } else if (_type == 2){
            cell.typeID = 2;
        } else if (_type == 3){
            cell.typeID = 3;
        }
    }
    cell.model = _tableData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model = _tableData[indexPath.row];
//    NewsViewController *newsVC = [[NewsViewController alloc] init];
//    newsVC.urlStr = model.url;
//    [self.navigationController pushViewController:newsVC animated:YES];
    BrandContentViewController *brandContentVc = [[BrandContentViewController alloc] init];
    brandContentVc.title = @"腕表咨询";
    brandContentVc.linkStr = model.url;
    [self.navigationController pushViewController:brandContentVc animated:YES];
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
