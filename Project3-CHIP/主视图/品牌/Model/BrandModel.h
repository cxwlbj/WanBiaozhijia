//
//  BrandModel.h
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseModel.h"

@interface BrandModel : BaseModel

@property (nonatomic, copy) NSString *img; //图片链接
@property (nonatomic, copy) NSString *name; //中文名
@property (nonatomic, copy) NSString *ename; //英文名
@property (nonatomic, copy) NSString *brandid; //ID
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, copy) NSString *cityID;//城市ID
@property (nonatomic, copy) NSString *url;

//分享model
@property (nonatomic, copy) NSString *text; //分享内容
@property (nonatomic, copy) NSString *pic; //分享图片


@end
