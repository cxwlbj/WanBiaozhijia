//
//  ImageDetailViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/10/9.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ImageDetailViewController.h"
#import "ImageDetailView.h"
@interface ImageDetailViewController ()

@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图片浏览";
    self.view.backgroundColor = [UIColor orangeColor];
    [self _initImageDeatilView];
}

- (void)_initImageDeatilView{
    
    ImageDetailView *imageDetailView = [[ImageDetailView alloc] initWithFrame:self.view.bounds];
    imageDetailView.imageData = self.data;
    [self.view addSubview:imageDetailView];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
    [imageDetailView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
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
