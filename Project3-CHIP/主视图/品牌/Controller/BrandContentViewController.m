//
//  BrandContentViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/10/6.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BrandContentViewController.h"
#import "ShareContentViewController.h"
#import "ContentHeaderView.h"
#import "ContentModel.h"
@interface BrandContentViewController ()
{
    UIWebView *_webView;
    UIView *_shareView;
    UIScrollView *_scrollView;
    ContentHeaderView *_contentHeaderView;
}
@end

@implementation BrandContentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *imgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:300];
    [imgView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    _webView.height = kScreenHeight - 64 - 45;
    _webView.delegate = self;
    _webView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_webView];
//    _linkStr = [Base_URL stringByAppendingString:_linkStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_linkStr]];
    [_webView loadRequest:request];
    
    if ([self.title isEqualToString:@"腕表详情"] || [self.title isEqualToString:@"腕表咨询"]){
        [self _initViews];
        
        if ([self.title isEqualToString:@"腕表详情"]) {
            [self _initHeaderView];
            UIScrollView *scrollView = [_webView.subviews objectAtIndex:0];
            scrollView.scrollEnabled = NO;
            //    [scrollView removeFromSuperview];
            //    scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
            scrollView.showsVerticalScrollIndicator = NO;
        }
        
    }
    
    
//    UIView *qView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
//    qView.backgroundColor = [UIColor redColor];
//    [_scrollView addSubview:qView];
    
    //设置风火轮
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:activity];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)_initHeaderView{
    _contentHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"ContentHeaderView" owner:nil options:nil] lastObject];
    _contentHeaderView.width = kScreenWidth;
    [_scrollView addSubview:_contentHeaderView];
    _webView.top = _contentHeaderView.bottom;
    
    [self _loadHeaderData];
}
//加载头视图的数据
- (void)_loadHeaderData{
//  http://www.xbiao.com/app/productBase/pid/33856/loginid//loginkey/
    NSString *str = [NSString stringWithFormat:@"app/productBase/pid/%@/loginid//loginkey/", self.watchID];
    
    [DataService requestDataWithURL:str params:nil httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        ContentModel *model = [[ContentModel alloc] initContentWithDic:result];
        _contentHeaderView.headerModel = model;
        if (model.pics.count == 0) {
            _contentHeaderView.showImageView.hidden = YES;
            _contentHeaderView.height = 500 - 110;
            
        } else{
            _contentHeaderView.showImageView.hidden = NO;
            _contentHeaderView.height = 500;
        }
        _webView.top = _contentHeaderView.bottom;
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"headerData%@", error);
    }];
    
}

- (void)_initViews{
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 110, kScreenWidth, 49)];
    _shareView.backgroundColor = [UIColor lightGrayColor];
    [self.view insertSubview:_shareView aboveSubview:_webView];
    NSArray *btnImg = @[@"inf_detail_pl.png", @"a_love.png", @"inf_detail_fx.png", @"goTop.png"];
    
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kScreenWidth / 4 - 30) * i + 20, 10, 30, 30);
        if (i == 3) {
            btn.right = kScreenWidth - 30;
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:btnImg[i]] forState:UIControlStateNormal];
        [_shareView addSubview:btn];
    }
}

- (void)shareAction:(UIButton *)btn{
    if (btn.tag == 2) {
        
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *sinaAction = [UIAlertAction actionWithTitle:@"分享到新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            ShareContentViewController *shareContentVC = [[ShareContentViewController alloc] init];
            shareContentVC.title = @"分享到新浪微博";
            shareContentVC.urlStr = [NSString stringWithFormat:@"app/shareContent/type/2/id/%@/share/weibo", self.watchID];
            [self.navigationController pushViewController:shareContentVC animated:YES];
        }];
        
        UIAlertAction *tencetAction = [UIAlertAction actionWithTitle:@"分享到腾讯微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        
        UIAlertAction *weixinAction = [UIAlertAction actionWithTitle:@"分享到微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        
        [alertCtrl addAction:sinaAction];
        [alertCtrl addAction:tencetAction];
        [alertCtrl addAction:weixinAction];
        [alertCtrl addAction:cancelAction];
        
        [self presentViewController:alertCtrl animated:YES completion:nil];
    } else if (btn.tag == 3){
//        UIScrollView *scrollView = [_webView.subviews objectAtIndex:0];
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

#pragma mark -UIWebViewDelegate
//已经开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //风火轮
    UIActivityIndicatorView *activity = (UIActivityIndicatorView *)self.navigationItem.rightBarButtonItem.customView;
    [activity startAnimating];
}

//结束加载
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIActivityIndicatorView *activity = (UIActivityIndicatorView *)self.navigationItem.rightBarButtonItem.customView;
    [activity stopAnimating];
    
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//    _webView.height = height;
    _scrollView.contentSize = CGSizeMake(0, height + 100);
    _webView.height = height - _contentHeaderView.height;

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
