//
//  DiscoverViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "DiscoverViewController.h"
#import "BrandModel.h"
#import "ContentTableViewController.h"
@interface DiscoverViewController ()
{
    NSArray *_titleArr;
    UIImageView *_selectImgView;
}
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"论坛";
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = YES;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;

    [self _loadHeaderData];
    
    
//    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
}

#pragma mark -加载数据
- (void)_loadHeaderData{
    [DataService requestDataWithURL:kNav params:nil httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in result) {
            BrandModel *model = [[BrandModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
        }
        BrandModel *model = [[BrandModel alloc] init];
        model.name = @"首页";
        model.url = @"http://www.xbiao.com/bbs2/zuoyelist/loginid/0/loginkey/0/page/1";
        [mArr insertObject:model atIndex:0];
        _titleArr = mArr;
        [self addLabel];
        [self addController];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"discover%@", error);
    }];
}
//添加控制器
- (void)addController{
    for (int i = 0; i < _titleArr.count; i++) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        ContentTableViewController *contentVC = [storyboard instantiateViewControllerWithIdentifier:@"contentVC"];
        BrandModel *model = _titleArr[i];
        NSLog(@"%@", model.url);
        contentVC.urlStr = model.url;
        [self addChildViewController:contentVC];
        if (i == 0) {
            [self.contentScrollView addSubview:contentVC.view];
        }
    }
    self.contentScrollView.contentSize = CGSizeMake(kScreenWidth * _titleArr.count, 0);
}

//添加title
- (void)addLabel{
    _selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _selectImgView.image = [UIImage imageNamed:@"light.png"];
    [_titleScrollView addSubview:_selectImgView];
    for (int i = 0; i < _titleArr.count; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 50)];
        label.userInteractionEnabled = YES;
        label.tag = i;
//        NSLog(@"jdkfjs%ld", [_titleArr[i] name].length);
        label.text = [_titleArr[i] name];
        label.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [label addGestureRecognizer:tap];
        if (i == 0) {
            if ([_titleArr[i] name].length == 2) {
                _selectImgView.width = 60;
            }
            _selectImgView.center = label.center;
            label.textColor = [UIColor whiteColor];
        }
        label.textAlignment = NSTextAlignmentCenter;
        [_titleScrollView addSubview:label];
    }
    _titleScrollView.contentSize = CGSizeMake(_titleArr.count * 100, 0);

}

#pragma mark -UITapGestureRecognizer
- (void)tapAction:(UITapGestureRecognizer *)tap{
    UILabel *label = (UILabel *)tap.view;
    label.textColor = [UIColor whiteColor];
    
    CGFloat pageX = label.tag * kScreenWidth;
    [self.contentScrollView setContentOffset:CGPointMake(pageX, 0) animated:YES];
    if (label.text.length >2) {
        _selectImgView.width = 100;
    } else {
        _selectImgView.width = 60;
    }
    _selectImgView.center = label.center;

    NSArray *arr = _titleScrollView.subviews;
    for (UILabel *label1 in arr) {
        if ([label1 isKindOfClass:[UILabel class]]) {
            if (label1 != label) {
                label1.textColor = [UIColor blackColor];
            }
        }
    }
    
}

#pragma mark -热门板块或者最近浏览的按钮点击事件
- (IBAction)hotBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    _btnScrollView.hidden = NO;
    _btnImageView.hidden = NO;
    UIImage *image = [UIImage imageNamed:@"daxiala.png"];
    if (sender.tag == 800) {
        image = [image stretchableImageWithLeftCapWidth:160 topCapHeight:0];
        _btnImageView.image = image;
        UIButton *btn = (UIButton *)[self.view viewWithTag:801];
        btn.selected = NO;
        
    } else {
        image = [image stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        _btnImageView.image= image;
        UIButton *btn = (UIButton *)[self.view viewWithTag:800];
        btn.selected = NO;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    UILabel *label = (UILabel *)self.titleScrollView.subviews[index + 1];
    
    label.textColor = [UIColor whiteColor];
    //滚动标题栏
    if (label.text.length >2) {
        _selectImgView.width = 100;
    } else {
        _selectImgView.width = 60;
    }
    _selectImgView.center = label.center;
    
    NSArray *arr = _titleScrollView.subviews;
    for (UILabel *label1 in arr) {
        if ([label1 isKindOfClass:[UILabel class]]) {
            if (label1 != label) {
                label1.textColor = [UIColor blackColor];
            }
        }
    }
    
    ContentTableViewController *contentVC = self.childViewControllers[index];
    contentVC.view.frame = scrollView.bounds;
    [self.contentScrollView addSubview:contentVC.view];
    
    
    //计算标题栏是否超过整个屏幕的一半
    CGFloat offX = label.center.x - self.titleScrollView.width * 0.5;
    //计算标题栏是否是显示最后几个标题
    CGFloat offMax = self.titleScrollView.contentSize.width - self.titleScrollView.width;
    if (offX < 0) {
        offX = 0;
    } else if (offX > offMax){
        offX = offMax;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offX, 0) animated:YES];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
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
