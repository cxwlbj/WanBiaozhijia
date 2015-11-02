//
//  ImageDetailView.h
//  Project3-CHIP
//
//  Created by imac on 15/10/9.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageDetailView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *imageData;

@end
