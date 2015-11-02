//
//  ShareContentViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ShareContentViewController.h"
#import "BrandModel.h"
@interface ShareContentViewController ()

@end

@implementation ShareContentViewController

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _initSendButton];
    [self loadData];
    [self.shareTextView becomeFirstResponder];
    self.shareTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.shareTextView.layer.borderWidth = 2;
    self.shareTextView.layer.cornerRadius = 5;
    self.shareTextView.layer.masksToBounds = YES;
    self.shareTextView.delegate = self;
}
#pragma mark -初始化发送按钮
- (void)_initSendButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 62, 32);
    [btn setImage:[UIImage imageNamed:@"fx.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"fx_h.png"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)sendAction:(UIButton *)btn{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:self.shareTextView.text image:self.shareImgView.image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark -loadData
- (void)loadData{
    [DataService requestDataWithURL:self.urlStr params:nil httpMethod:@"GET" finshDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        BrandModel *model = [[BrandModel alloc] initContentWithDic:result];
        [self _addData:model];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"shareContent%@", error);
    }];
}

- (void)_addData:(BrandModel *)model{
    [self.shareImgView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.shareTextView.text = [model.text stringByAppendingString:model.url];
    
    NSInteger length = 140 - self.shareTextView.text.length;
    self.countLabel.text = [NSString stringWithFormat:@"您还可以输入: %ld字", length];
}

#pragma mark -UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    NSInteger length = 140 - textView.text.length;
    if (length < 0) {
        length = 0;
    }
    self.countLabel.text = [NSString stringWithFormat:@"您还可以输入: %ld字", length];
    if (textView.text.length > 140) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入的内容超过140字!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSRange range = NSMakeRange(0, 140);
            textView.text = [textView.text substringWithRange:range];
        }];
        [alertCtrl addAction:sureAction];
        [self presentViewController:alertCtrl animated:YES completion:nil];
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
