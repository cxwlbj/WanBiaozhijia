//
//  HomeModel.m
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (id)initContentWithDic:(NSDictionary *)jsonDic{
    self = [super initContentWithDic:jsonDic];
    if (self) {
        self.imgID = [jsonDic objectForKey:@"id"];
    }
    return self;
}

@end
