//
//  SearchViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "SearchViewController.h"
#import "BrandContentViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *urlStr = [Base_URL stringByAppendingFormat:@"%@", self.searchStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    _webView.delegate = self;
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
