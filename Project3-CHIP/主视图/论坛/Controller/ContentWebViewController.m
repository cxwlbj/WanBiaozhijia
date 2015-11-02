//
//  ContentWebViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ContentWebViewController.h"
#import "BrandContentViewController.h"
@interface ContentWebViewController ()
{
    UIWebView *_webView;
}
@end

@implementation ContentWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    [self initView];
}

- (void)initView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    [self.view addSubview:_webView];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]];
    [_webView loadRequest:request];
    
    if ([self.title isEqualToString:@"筛选结果"]) {
        _webView.delegate = self;
    }
}

#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@", request.URL.absoluteString);
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
    
    NSString *urlstr = [kProductDetail stringByAppendingString:str];
    BrandContentViewController *brandContentVC = [[BrandContentViewController alloc] init];
    brandContentVC.title = @"腕表详情";
    brandContentVC.linkStr = [Base_URL stringByAppendingString: urlstr];
    NSInteger a = [arr indexOfObject:@"pid"];
    brandContentVC.watchID = arr[a + 2];
    [self.navigationController pushViewController:brandContentVC animated:YES];
    
    return YES;
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
