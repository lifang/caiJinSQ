//
//  CJLeftViewController.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJLeftViewController.h"
#import "CJleftListCell.h"
#import "CJPersonaldataController.h"
#import "CJAppDelegate.h"
#import "CJMyordersController.h"
#import "CJIntegralController.h"
#import "CJContactusController.h"
#import "CJVersionController.h"
#import "CJTermsofserviceController.h"
#import "CJAboutUsController.h"
#import "CJInboxController.h"
#import "CJUserModel.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
@interface CJLeftViewController ()
{
    CJUserModel *user;
}
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
    self.navigationController.navigationBarHidden = YES;
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
-(void)viewWillAppear:(BOOL)animated {
    user = [CJAppDelegate shareCJAppDelegate].user;
    [_listTable reloadData];
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
        cell.leftImage.image = [UIImage imageNamed:@"我的订单@2x.png"];
        cell.leftLable.text = @"我的订单";
    }else if (indexPath.row == 2) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_15@2x.png"];
        cell.leftLable.text = @"清除缓存";
        NSInteger interger = [[SDImageCache sharedImageCache] getSize];
        float getCache = interger/1024/1024;
        cell.rightLable.text = [NSString stringWithFormat:@"%.2fM",getCache];
    }else if (indexPath.row == 3) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_17@2x.png"];
        cell.leftLable.text = @"联系我们";
    }else if (indexPath.row == 4) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_20@2x.png"];
        cell.leftLable.text = @"版本号";
    }else if (indexPath.row == 5) {
        cell.leftImage.image = [UIImage imageNamed:@"首页cetui_22@2x.png"];
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
    if (user.headImage == nil) {
        [_userHeadImage setImage:[UIImage imageNamed:@"首页cetui_03@2x.png"] forState:UIControlStateNormal];
    }else {
        UIImage *img = [UIImage imageWithData:user.headImage];
        [_userHeadImage setImage:img forState:UIControlStateNormal];
    }

    [_userHeadImage addTarget:self action:@selector(personalData:) forControlEvents:UIControlEventTouchUpInside];
//    headView.backgroundColor = kColor(24, 24, 19, 1);
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
    if (indexPath.row == 0) {
        CJIntegralController *integral = [[CJIntegralController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:integral];
        [CJAppDelegate setNavigationBarTinColor:nav];
        [[[[CJAppDelegate shareCJAppDelegate] rootController] navController] setCenterViewController:nav withCloseAnimation:YES completion:nil];
        
        
    }else if (indexPath.row == 1) {
        CJMyordersController *orderControl = [[CJMyordersController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:orderControl];
        [CJAppDelegate setNavigationBarTinColor:nav];
        [[[[CJAppDelegate shareCJAppDelegate] rootController] navController] setCenterViewController:nav withCloseAnimation:YES completion:nil];
    }else if (indexPath.row == 2) {
        [SVProgressHUD showWithStatus:@"请稍后..."];
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(stopAction) userInfo:nil repeats:NO];
    }else if (indexPath.row == 3) {
        CJContactusController *contactControl = [[CJContactusController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:contactControl];
        [CJAppDelegate setNavigationBarTinColor:nav];
        [[[[CJAppDelegate shareCJAppDelegate] rootController] navController] setCenterViewController:nav withCloseAnimation:YES completion:nil];
    }else if (indexPath.row == 4) {
        CJVersionController *version = [[CJVersionController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:version];
        [CJAppDelegate setNavigationBarTinColor:nav];
        [[[[CJAppDelegate shareCJAppDelegate] rootController] navController] setCenterViewController:nav withCloseAnimation:YES completion:nil];
    }else if (indexPath.row == 5) {
        CJTermsofserviceController *termsofserviceControl = [[CJTermsofserviceController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:termsofserviceControl];
        [CJAppDelegate setNavigationBarTinColor:nav];
        [[[[CJAppDelegate shareCJAppDelegate]rootController]navController] setCenterViewController:nav withCloseAnimation:YES completion:nil];
    }else if (indexPath.row == 6) {
        CJAboutUsController *aboutusControl = [[CJAboutUsController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:aboutusControl];
        [CJAppDelegate setNavigationBarTinColor:nav];
        [[[[CJAppDelegate shareCJAppDelegate]rootController]navController] setCenterViewController:nav withCloseAnimation:YES completion:nil];
    }else if (indexPath.row == 7) {
    }else {
        CJInboxController *inboxControl = [[CJInboxController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:inboxControl];
        [CJAppDelegate setNavigationBarTinColor:nav];
        [[[[CJAppDelegate shareCJAppDelegate] rootController]navController] setCenterViewController:nav withCloseAnimation:YES completion:nil];
    }
}
-(void)personalData:(id)sender {
    CJPersonaldataController *personal = [[CJPersonaldataController alloc] init];
    UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:personal];
    [CJAppDelegate setNavigationBarTinColor:nav];
    [[[[CJAppDelegate shareCJAppDelegate] rootController] navController] setCenterViewController:nav withCloseAnimation:YES completion:nil];
}
-(void)stopAction {
    [SVProgressHUD dismissWithSuccess:@"清除成功"];
    [[SDImageCache sharedImageCache] cleanDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [_listTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

@end
