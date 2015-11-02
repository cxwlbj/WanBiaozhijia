//
//  LoginViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/10/4.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录后可以继续操作哦";
//    UIImage *image = [UIImage imageNamed:@"bp.png"];
//    image = [image stretchableImageWithLeftCapWidth:80 topCapHeight:1];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}
- (IBAction)loginAction:(UIButton *)sender {
    NSString *postText = self.postTextField.text;
    NSString *passWordText = self.passWordTextField.text;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"" forKey:@"PHPSESSID"];
    [params setObject:postText forKey:@"username"];
    [params setObject:passWordText forKey:@"password"];
    
    [DataService requestDataWithURL:kLogin params:params httpMethod:@"POST" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSLog(@"%@", result);
        NSLog(@"%@", [result objectForKey:@"message"]);
        NSLog(@"%@", [result objectForKey:@"msg"]);
        
        if ([[result objectForKey:@"success"] integerValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"login%@", error);
    }];
}

- (IBAction)registerAction:(UIButton *)sender {
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (IBAction)otherLoginAction:(UIButton *)sender {
    if (sender.tag == 200) {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            //          获取微博用户名、uid、token等
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                
                NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                
            }});
    } else{
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            //          获取微博用户名、uid、token等
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                
                NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                
            }});

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
