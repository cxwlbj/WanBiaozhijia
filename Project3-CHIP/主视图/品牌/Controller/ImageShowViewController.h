//
//  ImageShowViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/10/9.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"

@interface ImageShowViewController : BaseViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *picsArr;

@end
