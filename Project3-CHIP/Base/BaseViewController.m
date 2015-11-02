//
//  BaseViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
//当push时隐藏标签栏
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)showHUD:(NSString *)title{
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //让背景变暗
    _HUD.dimBackground = YES;
    //显示内容
    _HUD.labelText = title;
}

- (void)hiddenHUD{
    [_HUD hide:YES afterDelay:1];
}

- (void)completeHUD:(NSString *)title{
    _HUD.customView = [[UIImageView alloc] initWithImage:nil];;
    _HUD.labelText = title;
    [_HUD hide:YES afterDelay:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.translucent = NO;
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
