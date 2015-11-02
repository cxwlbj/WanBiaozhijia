//
//  BrandDetailViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "BaseViewController.h"
#import "CityView.h"
@interface BrandDetailViewController : BaseViewController <UIWebViewDelegate>
{
    UIWebView *_webView;
    UIView *_pickerHeaderView;
    CityView *_pickView;
}
@property (nonatomic, copy) NSString *linkID;

@end
