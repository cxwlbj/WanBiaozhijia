//
//  ContentWebViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"

@interface ContentWebViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic, copy) NSString *webUrl;

@end
