//
//  AdviseViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/10/4.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "AdviseViewController.h"

@interface AdviseViewController ()

@end

@implementation AdviseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"建议反馈";
    [self.textView becomeFirstResponder];
    
    [self initButton];
}

- (void)initButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 63, 34);
    [btn setImage:[UIImage imageNamed:@"fs.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"fs_h.png"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)sendAction:(UIButton *)btn{
    
    NSString *adviseText = self.textView.text;
    
    if (adviseText.length < 8) {
        _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        [self completeHUD:@"少于8个字"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"" forKey:@"PHPSESSID"];
    [params setObject:adviseText forKey:@"content"];
    [DataService requestDataWithURL:kAdvise params:params httpMethod:@"POST" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSLog(@"%@", result);
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else{
            NSLog(@"发送失败");
            [self completeHUD:@"发送失败"];
        }
        
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
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
