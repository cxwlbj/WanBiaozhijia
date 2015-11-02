//
//  ContentModel.h
//  Project3-CHIP
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseModel.h"

@interface ContentModel : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *brand_logo;
@property (nonatomic, copy) NSString *price_rmb;
@property (nonatomic, copy) NSString *price_hk;
@property (nonatomic, copy) NSString *price_usa;
@property (nonatomic, strong) NSArray *pics;

@end
