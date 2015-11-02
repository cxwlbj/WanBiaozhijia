//
//  BaseTabBarController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseTabBarController.h"
#import "MainTabBarItem.h"
@interface BaseTabBarController ()
{
    UIImageView *_selectView;
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self createTarBarItem];
}

- (void)createTarBarItem{
    
    if (_selectView != nil) {
        return;
    }
    
    UIImage *image = [UIImage imageNamed:@"zl.png"];
    image = [image stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    
    [self.tabBar setBackgroundImage:image];
    
    //将tabBar上的按钮移除，自定义按钮
    NSArray *array = self.tabBar.subviews;
    for (UIView *btnView in array) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([btnView isKindOfClass:cls]) {
            [btnView removeFromSuperview];
        }
    }
    
    NSArray *btnArr = @[@"7_tab1.png", @"7_tab2.png", @"7_tab3.png", @"7_tab4.png", @"7_tab5.png"];
    NSArray *btnArr1 = @[@"7_tab1_s.png", @"7_tab2_s.png", @"7_tab3_s.png", @"7_tab4_s.png", @"7_tab5_s.png"];
    
    
    for (int i = 0; i < 5; i ++) {
        //构建标签栏的按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth / 5 * i, 0, 64, 49);
        [btn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:btnArr[i]]]];
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(tabBarAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:btn];
        
        if (i == 0) {
            _selectView.center = btn.center;
        }
    }
    //设置选中视图
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 49)];
    _selectView.image = [UIImage imageNamed:btnArr1[0]];
    [self.tabBar addSubview:_selectView];
    
}
//标签栏按钮点击触发的事件
- (void)tabBarAction:(UIButton *)btn{
    self.selectedIndex = btn.tag - 200;
    NSInteger index = btn.tag - 200;
    NSArray *btnArr1 = @[@"7_tab1_s.png", @"7_tab2_s.png", @"7_tab3_s.png", @"7_tab4_s.png", @"7_tab5_s.png"];
    
    _selectView.image = [UIImage imageNamed:btnArr1[index]];
    _selectView.center = btn.center;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createTarBarItem];
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
