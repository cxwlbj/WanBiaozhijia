//
//  ProfileViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "ProfileTableHeaderView.h"
@interface ProfileViewController ()
{
    NSArray *_titleArr;
    NSArray *_imgArr;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    _titleArr = @[@[@"关注和粉丝"], @[@"我的私信", @"论坛提醒", @"主贴", @"回贴", @"作业贴"]];
    
    _imgArr = @[@[@"p_c1.png"], @[@"p_c2.png", @"p_c3.png", @"p_c4.png", @"p_c5.png", @"p_c6.png"]];
    
    ProfileTableHeaderView *tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"ProfileTableHeaderView" owner:nil options:nil] lastObject];
    
    self.tableView.tableHeaderView = tableHeaderView;
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titleArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil] lastObject];
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:300];
    imgView.image = [UIImage imageNamed:[_imgArr[indexPath.section] objectAtIndex:indexPath.row]];
    UILabel *label = (UILabel *)[cell viewWithTag:301];
    label.text = [_titleArr[indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    if (![UMSocialAccountManager isLogin]) {
//        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//        loginVC.hidesBottomBarWhenPushed = NO;
//        [self.navigationController pushViewController:loginVC animated:YES];
//    } else{
//        NSString * htmlString = @"<html><body> Some html string \n <font size=\"13\" color=\"red\">This is some text!</font> </body></html>";
//        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//        UILabel * myLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
//        myLabel.attributedText = attrStr;
//        [self.view addSubview:myLabel];
//    }
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
