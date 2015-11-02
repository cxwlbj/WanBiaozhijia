//
//  BaseViewController.h
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    MBProgressHUD *_HUD;
}

- (void)showHUD:(NSString *)title;

- (void)hiddenHUD;

- (void)completeHUD:(NSString *)title;

@end
