//
//  CJCompleteInfoController.m
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJCompleteInfoController.h"
#import "CJCompleteInfoCell.h"
#import "CJNameController.h"
#import "CJTelController.h"
#import "CJCompanyController.h"
#import "CJJobController.h"
#import "CJEmailController.h"
#import "CJAppDelegate.h"
#import "CJRootViewController.h"

@interface CJCompleteInfoController ()
{
    NSArray *arr;
}
@end

@implementation CJCompleteInfoController

@synthesize infoTable = _infoTable;

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
    arr = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    self.title = @"完善资料";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setLeftNavBarItemWithImageName:(NSString *)name {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
}
-(void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initUI {
    _infoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _infoTable.delegate = self;
    _infoTable.dataSource = self;
    _infoTable.backgroundColor = [UIColor whiteColor];
    _infoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_infoTable];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *ID = @"first";
        CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
        if(cell == nil) {
            cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.infoName.text = @"头像";
        cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03@2x.png"];
        return cell;
    }else if (indexPath.row == 1) {
        static NSString *ID = @"two";
        CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
        if(cell == nil) {
            cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.infoName.text = @"姓名";
        cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-07@2x"];
        cell.peopleInfo.text = @"王兴胜";
        return cell;
    }else if (indexPath.row == 2) {
        static NSString *ID = @"three";
        CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
        if(cell == nil) {
            cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.infoName.text = @"电话";
        cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-11@2x"];
        cell.peopleInfo.text = @"13992014456";
        return cell;
    }else if (indexPath.row == 3) {
        static NSString *ID = @"four";
        CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
        if(cell == nil) {
            cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.infoName.text = @"公司";
        cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-13@2x"];
        cell.peopleInfo.text = @"德胜集团";
        
        return cell;
    }else if (indexPath.row == 4) {
        static NSString *ID = @"five";
        CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
        if(cell == nil) {
            cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.infoName.text = @"职位";
        cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-16@2x"];
        cell.peopleInfo.text = @"财务总监";
        
        return cell;

    }else if (indexPath.row == 5) {
        static NSString *ID = @"six";
        CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
        if(cell == nil) {
            cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.infoName.text = @"邮箱";
        cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-18@2x"];
        cell.peopleInfo.text = @"wys008@desen.com";
        
        return cell;

    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        NSLog(@"换头像");
    }else if (indexPath.row == 1) {
        CJNameController *nameControl = [[CJNameController alloc] init];
        [self.navigationController pushViewController:nameControl animated:YES];
    }else if (indexPath.row == 2) {
        CJTelController *telControl = [[CJTelController alloc] init];
        [self.navigationController pushViewController:telControl animated:YES];
    }else if (indexPath.row == 3) {
        CJCompanyController *companyControl = [[CJCompanyController alloc] init];
        [self.navigationController pushViewController:companyControl animated:YES];;
    }else if (indexPath.row == 4) {
        CJJobController *jobControl = [[CJJobController alloc] init];
        [self.navigationController pushViewController:jobControl animated:YES];
    }else if (indexPath.row == 5) {
        CJEmailController *emailControl = [[CJEmailController alloc] init];
        [self.navigationController pushViewController:emailControl animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    UIButton *getinBt = [UIButton buttonWithType:UIButtonTypeCustom];
    getinBt.frame = CGRectMake(0, 20, self.view.frame.size.width, 44);
    [getinBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getinBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [getinBt setTitle:@"进入CFEC" forState:UIControlStateNormal];
    getinBt.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [getinBt addTarget:self action:@selector(getIn:) forControlEvents:UIControlEventTouchUpInside];
    getinBt.backgroundColor = kColor(93, 201, 16, 1);
    [footView addSubview:getinBt];
    return footView;
}
-(void)getIn:(id)sender {
    NSLog(@"进入CFEC");
    [self.navigationController popToRootViewControllerAnimated:YES];
//    CJRootViewController *rootC = [[CJAppDelegate shareCJAppDelegate] rootController];
//    [rootC showMainController];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50.0f;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
