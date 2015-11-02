//
//  MoreViewController.m
//  Project3-CHIP
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "MoreViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AdviseViewController.h"
#import "ImageViewController.h"
@interface MoreViewController ()
{
    CGFloat size;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更多选项";
    self.navigationController.navigationBar.translucent = NO;

    _moreData = @[@[@"登录", @"注册"], @[@"建议反馈", @"图片质量", @"关于我们", @"清除缓存", @"给我们评分", @"新浪微博", @"友情推荐"]];
}

#pragma mark -CountCache
- (void)countCache{
    //获取沙盒路径
    NSString *homePath = NSHomeDirectory();
//    NSLog(@"%@", homePath);
    //拼接路径获取缓存的路径
    NSString *cachePath = [homePath stringByAppendingPathComponent:@"Library/Caches/com.hackemist.SDWebImageCache.default"];
    //文件管理助手---单例对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    //根据路径获取一个文件夹下的所有文件路径, 返回值为数组，里面存放的全部是路径
    NSArray *files = [fileManager subpathsOfDirectoryAtPath:cachePath error:&error];
    long long sum = 0;
    for (NSString *filePath in files) {
        //拼接文件夹的路径
        NSString *path = [cachePath stringByAppendingPathComponent:filePath];
        //拿到文件夹的属性，返回值为一个字典
        NSDictionary *dic = [fileManager attributesOfItemAtPath:path error:&error];
        //拿到文件夹的大小属性
        NSNumber *fileSize = dic[NSFileSize];
        //计算总的大小
        sum += [fileSize longLongValue];
    }
    //将文件夹的总大小转化为MB
    size = sum / (1000.0 * 1000);
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _moreData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_moreData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *identifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UILabel *label;
//    if (cell == nil) {
       UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 1 && indexPath.row == 3) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(85, 15, 100, 30)];
            label.font = [UIFont boldSystemFontOfSize:17];
            label.tag = 500;
            [cell.contentView addSubview:label];
        }
//    }
    if (indexPath.section == 1 && indexPath.row == 3) {
        label.hidden = NO;
    }else{
        label.hidden = YES;
    }
    
    NSArray *arr = _moreData[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}
//表视图将要显示单元格时调用的方法
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 3) {
        [self countCache];
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:500];
//        label.hidden = NO;
        label.text = [NSString stringWithFormat:@"(%.1fM)", size];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginVC animated:YES];
        } else if (indexPath.row == 1){
            RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
            [self.navigationController pushViewController:registerVC animated:YES];
        }
    } else if (indexPath.section == 1){
        if (indexPath.row == 3) {
            UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要清除缓存?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //清除缓存
                [[SDImageCache sharedImageCache] clearDisk];
                [_tableView reloadData];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [alertCtrl addAction:sureAction];
            [alertCtrl addAction:cancelAction];
            
            [self presentViewController:alertCtrl animated:YES completion:nil];
        } else if (indexPath.row == 2){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *aboutVC = [storyboard instantiateViewControllerWithIdentifier:@"aboutVC"];
            [self.navigationController pushViewController:aboutVC animated:YES];
        } else if (indexPath.row == 0){
            AdviseViewController *adviseVC = [[AdviseViewController alloc] initWithNibName:@"AdviseViewController" bundle:nil];
            [self.navigationController pushViewController:adviseVC animated:YES];
        } else if (indexPath.row == 1){
            ImageViewController *imageVC = [[ImageViewController alloc] init];
            [self.navigationController pushViewController:imageVC animated:YES];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
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
