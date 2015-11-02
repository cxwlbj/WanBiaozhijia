//
//  NewsViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:300];
    [imgView removeFromSuperview];
    
    
    self.title = @"腕表详情";
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.height -= 64;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [_webView loadRequest:request];
    
    //设置风火轮
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:activity];
    self.navigationItem.rightBarButtonItem = item;
    
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
