//
//  TableHeightView.h
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeightView : UIView <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *showView;
@property (nonatomic, strong) NSArray *imgData;

@end
