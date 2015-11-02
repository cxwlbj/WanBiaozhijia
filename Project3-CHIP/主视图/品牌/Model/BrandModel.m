//
//  BrandModel.m
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel

- (id)initContentWithDic:(NSDictionary *)jsonDic{
    self = [super initContentWithDic:jsonDic];
    if (self) {
        self.cityID = [jsonDic objectForKey:@"id"];
    }
    return self;
}

@end
