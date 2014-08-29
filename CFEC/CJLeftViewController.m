//
//  CJLeftViewController.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJLeftViewController.h"
#import "CJleftListCell.h"
@interface CJLeftViewController ()

@end

@implementation CJLeftViewController
@synthesize listTable = _listTable;
@synthesize userHeadImage = _userHeadImage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户信息";
    self.view.backgroundColor = [UIColor blackColor];
    [self initUI];
}
-(void)initUI {
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.backgroundColor = kColor(24, 24, 19, 1);
    _listTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_listTable setSeparatorColor:kColor(43, 46, 42, 1)];
    [_listTable setSeparatorInset:UIEdgeInsetsMake(-10, 0, 10, 0)];
    [self.view addSubview:_listTable];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    CJleftListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CJleftListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_07@2x.png"];
        cell.leftLable.text = @"积分";
    }else if (indexPath.row == 1) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_22@2x.png"];
        cell.leftLable.text = @"我的订单";
    }else if (indexPath.row == 2) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_15@2x.png"];
        cell.leftLable.text = @"清楚缓存";
        cell.rightLable.text = @"缓存 200M";
    }else if (indexPath.row == 3) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_17@2x.png"];
        cell.leftLable.text = @"联系我们";
    }else if (indexPath.row == 4) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_20@2x.png"];
        cell.leftLable.text = @"版本号";
    }else if (indexPath.row == 5) {
        cell.leftImage.image = [UIImage imageNamed:@"我的订单@2x.png"];
        cell.leftLable.text = @"服务条款";
    }else if (indexPath.row == 6) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_24@2x"];
        cell.leftLable.text = @"关于我们";
    }else if (indexPath.row == 8) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_26@2x"];
        cell.leftLable.text = @"收件箱";
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView.backgroundColor = kColor(255, 255, 255, .5);
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    
    _userHeadImage = [UIButton buttonWithType:UIButtonTypeCustom];
    _userHeadImage.frame = CGRectMake(75, 25, 60, 60);
    [_userHeadImage setImage:[UIImage imageNamed:@"首页cetui_03@2x.png"] forState:UIControlStateNormal];
    headView.backgroundColor = kColor(24, 24, 19, 1);
    [headView addSubview:_userHeadImage];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height,headView.frame.size.width, 1)];
    lineView.backgroundColor = kColor(43, 46, 42, 1);
    [headView addSubview:lineView];

    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击cell");
}

@end
