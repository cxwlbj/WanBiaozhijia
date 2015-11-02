//
//  DetailCollectionViewCell.m
//  Project3-CHIP
//
//  Created by imac on 15/10/9.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "DetailCollectionViewCell.h"

@implementation DetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.height = kScreenHeight - 64;
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setImgUrl:(NSString *)imgUrl{
    if (_imgUrl != imgUrl) {
        _imgUrl = imgUrl;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_imgUrl]];
    }
}

@end
