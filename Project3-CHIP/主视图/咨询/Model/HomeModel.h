//
//  HomeModel.h
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel

@property (nonatomic, copy) NSString *imgID; //图片ID
@property (nonatomic, copy) NSString *title; //图片标题
@property (nonatomic, copy) NSString *url; //图片对应的连接
@property (nonatomic, copy) NSString *img; //图片连接

@property (nonatomic, copy) NSString *inputtime; //时间
@property (nonatomic, copy) NSString *brand_name;// 品牌名
@property (nonatomic, copy) NSString *hits; //点击数
@property (nonatomic, copy) NSString *comment_count; //评论数
@property (nonatomic, copy) NSString *author_name;//作者
@property (nonatomic, copy) NSNumber *theme;//主题
@property (nonatomic, copy) NSNumber *post;//帖数
@property (nonatomic, copy) NSString *image; //图片连接
@property (nonatomic, copy) NSString *name;//品牌名
@end
