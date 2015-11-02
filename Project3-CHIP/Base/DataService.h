//
//  DataService.h
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^FinshDidBlock)(AFHTTPRequestOperation *operation, id result);
typedef void(^FailuerBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface DataService : NSObject

+ (AFHTTPRequestOperation *)requestDataWithURL:(NSString *)url
                                        params:(NSMutableDictionary *)params
                                    httpMethod:(NSString *)method
                                 finshDidBlock:(FinshDidBlock)finshBlock
                                  failuerBlock:(FailuerBlock)faileBlock;
+ (AFHTTPRequestOperation *)requestDataWithAllURL:(NSString *)url
                                           params:(NSMutableDictionary *)params
                                       httpMethod:(NSString *)method
                                    finshDidBlock:(FinshDidBlock)finshBlock
                                     failuerBlock:(FailuerBlock)faileBlock;
@end
