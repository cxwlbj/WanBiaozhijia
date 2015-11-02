//
//  BrandDetailViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BrandDetailViewController.h"
#import "BrandModel.h"
#import "BrandContentViewController.h"
@interface BrandDetailViewController ()
{
    UIView *_headerView;
    UIImageView *_selectView;
    NSString *strURL;
    NSInteger urlIndex;
}
@end

@implementation BrandDetailViewController

- (void)viewDidLoad {
    self.hidesBottomBarWhenPushed = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self _initView];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 50 - 50)];
    _webView.delegate = self;
    
    //    _webView.height -= 50;
    [self.view insertSubview:_webView atIndex:0];
    NSString *urlStr = [NSString stringWithFormat:@"app/seriesList/bid/%@", self.linkID];
    [self _loadWebView:urlStr];
    urlIndex = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"cityID" object:nil];
}

- (void)notificationAction:(NSNotification *)notification{
     BrandModel *model = notification.object;
    UILabel *label = (UILabel *)[_pickerHeaderView viewWithTag:1000];
    label.text = model.name;
    
    NSString *urlString = [NSString stringWithFormat:@"app/shopList/bid/%@/cityid/%@", self.linkID, model.cityID];
    [self _loadWebView:urlString];
    
}

//初始化视图
- (void)_initView{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toolbg.png"]];
//    _headerView.alpha = 0.3;
    [self.view addSubview:_headerView];
    
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 85, 40)];
    _selectView.image = [UIImage imageNamed:@"light.png"];
    [_headerView addSubview:_selectView];
    
    NSArray *array = @[@"系列", @"全部表款", @"经销商", @"简介"];
    
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth / 4 * i, 10, 80, 30);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectViewAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 300 + i;
        if (i == 0) {
            _selectView.center = btn.center;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [_headerView addSubview:btn];
    }
    
    _pickerHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, _headerView.bottom, kScreenWidth, 40)];
    UIImage *image = [UIImage imageNamed:@"city.png"];
    image = [image stretchableImageWithLeftCapWidth:50 topCapHeight:0];
    UIImageView *pickImgView = [[UIImageView alloc] initWithFrame:_pickerHeaderView.bounds];
    pickImgView.image = image;
    [_pickerHeaderView addSubview:pickImgView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, _pickerHeaderView.width - 120, 40)];
    label1.text = @"不限城市";
    label1.userInteractionEnabled = YES;
    label1.textAlignment = NSTextAlignmentLeft;
    label1.tag = 1000;
    [_pickerHeaderView addSubview:label1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityAction:)];
    [label1 addGestureRecognizer:tap];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.right + 5, 0, _pickerHeaderView.right - 120, 40)];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = @"维修点";
    label2.userInteractionEnabled = YES;

    label2.tag = 1001;
    [_pickerHeaderView addSubview:label2];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityAction:)];
    [label2 addGestureRecognizer:tap1];

    [self.view addSubview:_pickerHeaderView];
    _pickerHeaderView.hidden = YES;

    
    _pickView = [[[NSBundle mainBundle] loadNibNamed:@"CityView" owner:nil options:nil] lastObject];
    _pickView.width = self.view.width;
    _pickView.top = kScreenHeight;
//    - _pickerView.height - 64;
//    _pickerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_pickView];
    
}

//选择需要显示的表的按钮触发的事件
- (void)selectViewAction:(UIButton *)btn{
    
    _selectView.center = btn.center;
    for (UIView *btnView in _headerView.subviews) {
        if ([btnView isKindOfClass:[UIButton class]]) {
            UIButton *btn1 = (UIButton *)btnView;
            if (btn1.tag != btn.tag) {
                [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
        }
    }
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (btn.tag == 300) {
        urlIndex = 0;
        _webView.transform = CGAffineTransformIdentity;
        _webView.height = kScreenHeight - 100;
        _pickerHeaderView.hidden = YES;
        [self _loadWebView:[NSString stringWithFormat:@"app/seriesList/bid/%@", self.linkID]];
    } else if (btn.tag == 301){
        urlIndex = 1;
        _webView.transform = CGAffineTransformIdentity;
        _webView.height = kScreenHeight - 100;
        _pickerHeaderView.hidden = YES;
//        NSString *urlString = [NSString stringWithFormat:@"app/shopList/bid/%@/cityid/%@", self.linkID, model.cityID];
        [self _loadWebView:[NSString stringWithFormat:@"app/productList/bid/%@", self.linkID]];
        
    } else if (btn.tag == 302){
        urlIndex = 2;
        _pickerHeaderView.hidden = NO;
        _webView.transform = CGAffineTransformMakeTranslation(0, 40);
        _webView.height = kScreenHeight - 50 - 50 - 40;
        [self _loadWebView:[NSString stringWithFormat:@"app/shopList/bid/%@", self.linkID]];
    } else if (btn.tag == 303){
        _webView.transform = CGAffineTransformIdentity;
        _webView.height = kScreenHeight - 100;
        _pickerHeaderView.hidden = YES;
        [self _loadWebView:[NSString stringWithFormat:@"app/BrandIntro/bid/%@", self.linkID]];
    }
    _pickView.transform = CGAffineTransformIdentity;
    
}
//选择城市或者维修点
- (void)cityAction:(UITapGestureRecognizer *)tap{
    
    [UIView animateWithDuration:0.3 animations:^{
        _pickView.transform = CGAffineTransformMakeTranslation(0, -( _pickView.height + 50));
    }];
    
    if (tap.view.tag == 1000) {
        [self loadData];
        _pickView.isCity = YES;
    } else{
        _pickView.isCity = NO;
        BrandModel *model = [[BrandModel alloc] init];
        model.name = @"销售点";
        model.cityID = @"0";
        BrandModel *model1 = [[BrandModel alloc] init];
        model1.name = @"维修点";
        model1.cityID = @"1";
        NSArray *arr = @[model, model1];
        _pickView.buyData = arr;
        
        
    }
}

//获取城市列表数据
- (void)loadData{
    NSString *url = [kCity stringByAppendingString:self.linkID];
    [DataService requestDataWithURL:url params:nil httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in result) {
            BrandModel *model = [[BrandModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
        }
        BrandModel *modle = [[BrandModel alloc] init];
        modle.name = @"不限城市";
        [mArr insertObject:modle atIndex:0];
        _pickView.cityData = mArr;
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"brand error %@", error);
    }];
}

- (void)_loadWebView:(NSString *)linkStr{
    
    linkStr = [Base_URL stringByAppendingString:linkStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:linkStr]];
    
    [_webView loadRequest:request];
}
#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = request.URL.absoluteString;
    NSArray *arr = [url componentsSeparatedByString:@":"];
    NSString *str = [NSString string];
    
    for (int i = 0; i < arr.count; i ++) {
        NSString *str1;
        if ([arr[i] isEqualToString:@"http"]) {
            
            return YES;
        }
        if ([arr[i] isEqualToString:@"eq"] || [arr[i] isEqualToString:@"and"]) {
            str1 = @"/";
            str = [str stringByAppendingString:str1];
        } else {
            str = [str stringByAppendingString:arr[i]];
        }
        
    }
    NSString *title;
    NSString *idIndex;
    if (urlIndex == 0) {
        strURL =kProductList;
    } else if (urlIndex == 1){
        strURL = kProductDetail;
        title = @"腕表详情";
        //获取表的id
        NSInteger inde = [arr indexOfObject:@"pid"];
        idIndex = arr[inde + 2];
    } else {
        strURL = kShopMap;
        title = @"经销商详情";
    }
        NSInteger a = [arr indexOfObject:@"title"];
    if (title.length == 0 && [arr[a + 2] length] != 0) {
        //获取页面的title
        title = arr[a + 2];
        title = [title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }

    str = [strURL stringByAppendingFormat:@"%@", str];

    BrandContentViewController *brandContentVC = [[BrandContentViewController alloc] init];
    brandContentVC.linkStr = [Base_URL stringByAppendingString:str];
    brandContentVC.title = title;
    brandContentVC.watchID = idIndex;
    [self.navigationController pushViewController:brandContentVC animated:YES];
    
    return YES;
}
//http://www.xbiao.com/app/productList/bid/101/sid/1069/title/%E6%99%BA%E6%85%A7%E7%B3%BB%E5%88%97

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
