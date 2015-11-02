//
//  ImageDetailView.m
//  Project3-CHIP
//
//  Created by imac on 15/10/9.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ImageDetailView.h"
#import "DetailCollectionViewCell.h"
@implementation ImageDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = frame.size;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    //设置滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        [self registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        
//        [self registerNib:[UINib nibWithNibName:@"ImageDeatil" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    }
    return self;
}

- (void)setImageData:(NSArray *)imageData{
    if (_imageData != imageData) {
        _imageData = imageData;
        [self reloadData];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.imgUrl = self.imageData[indexPath.row];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 10 * 0.1 green:arc4random() % 10 * 0.1 blue:arc4random() % 10 * 0.1 alpha:1];
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
