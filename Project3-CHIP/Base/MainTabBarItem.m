//
//  MainTabBarItem.m
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "MainTabBarItem.h"

@implementation MainTabBarItem

- (instancetype)initWithFrame:(CGRect)frame
                      ImgName:(NSString *)imgName{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 32) / 2, 5, 25, 25)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:imgName];
        [self addSubview:imgView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
