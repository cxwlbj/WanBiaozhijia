//
//  DataService.m
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "DataService.h"

@implementation DataService

+ (AFHTTPRequestOperation *)requestDataWithURL:(NSString *)url
                                        params:(NSMutableDictionary *)params
                                    httpMethod:(NSString *)method
                                 finshDidBlock:(FinshDidBlock)finshBlock
                                  failuerBlock:(FailuerBlock)faileBlock{
    //判断参数是否为空
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    //拼接URL
    NSString *urlStr = [Base_URL stringByAppendingString:url];
    //创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置请求方式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPRequestOperation *operation = nil;
    if ([method isEqualToString:@"GET"]) {
       operation = [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"GET方式请求成功");
            if (finshBlock) {
                finshBlock(operation, responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"GET方式请求失败");
            if (faileBlock) {
                faileBlock(operation, error);
            }
        }];
    } else{
        
        BOOL isFile = NO;
        for (NSString *key in params) {
            id value = params[key];
            if ([value isKindOfClass:[NSData class]]) {
                isFile = YES;
                break;
            }
        }
        
        if (isFile) {
            //有文件请求
           operation = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
               for (NSString *key in params) {
                   id value = params[key];
                   if ([value isKindOfClass:[NSData class]]) {
                       [formData appendPartWithFileData:value name:key fileName:key mimeType:@"image/jpeg"];
                   }
               }
           } success:^(AFHTTPRequestOperation *operation, id responseObject) {
               NSLog(@"POST(带文件)请求成功");
               if (finshBlock) {
                   finshBlock(operation, responseObject);
               }
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               NSLog(@"POST(带文件)请求失败");
               if (faileBlock) {
                   faileBlock(operation, error);
               }
           }];
            
            
        } else{
            //非文件请求
            operation = [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"POST(非文件)请求成功");
                if (finshBlock) {
                    finshBlock(operation, responseObject);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"POST(非文件)请求失败");
                if (faileBlock) {
                    faileBlock(operation, error);
                }
            }];
        }
        
        
    }
    
    
    
    return operation;
    
}

+ (AFHTTPRequestOperation *)requestDataWithAllURL:(NSString *)url
                                        params:(NSMutableDictionary *)params
                                    httpMethod:(NSString *)method
                                 finshDidBlock:(FinshDidBlock)finshBlock
                                  failuerBlock:(FailuerBlock)faileBlock{
    //判断参数是否为空
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    //拼接URL
//    NSString *urlStr = [Base_URL stringByAppendingString:url];
    //创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置请求方式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPRequestOperation *operation = nil;
    
    operation = [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"GET方式请求成功");
        if (finshBlock) {
            finshBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"GET方式请求失败");
        if (faileBlock) {
            faileBlock(operation, error);
        }
    }];
    
    return operation;
    
}


@end
