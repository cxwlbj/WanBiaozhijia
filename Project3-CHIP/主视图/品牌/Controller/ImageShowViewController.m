//
//  ImageShowViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/10/9.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ImageShowViewController.h"
#import "ImageDetailViewController.h"
@interface ImageShowViewController ()
{
    UICollectionView *_collectionView;
}
@end

@implementation ImageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _initCollectionView];
}

- (void)_initCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.height = kScreenHeight - 64;
    _collectionView.dataSource =self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"ImageShowCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
    [self.view addSubview:_collectionView];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.picsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor orangeColor];
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:200];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.picsArr[indexPath.row]]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageDetailViewController *imageDetailVC = [[ImageDetailViewController alloc] init];
    imageDetailVC.data = self.picsArr;
    imageDetailVC.index = indexPath.row;
    [self.navigationController pushViewController:imageDetailVC animated:YES];
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
