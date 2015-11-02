//
//  SearchViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController <UIWebViewDelegate>
{
    UIWebView *_webView;
}

@property (nonatomic, copy) NSString *searchStr;

@end
