//
//  CJPersonaldataController.m
//  CFEC
//
//  Created by SumFlower on 14-8-29.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJPersonaldataController.h"
#import "CJMainViewController.h"
#import "CJAppDelegate.h"
#import "CJCompleteInfoCell.h"
#import "CJNameController.h"
#import "CJTelController.h"
#import "CJCompanyController.h"
#import "CJJobController.h"
#import "CJEmailController.h"
@interface CJPersonaldataController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *infoTable;
@property (nonatomic, strong) UIActionSheet *headImageSheet;

@end

@implementation CJPersonaldataController

@synthesize infoTable = _infoTable;
@synthesize headImageSheet = _headImageSheet;
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
    self.navigationItem.title = @"个人资料";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self initUI];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)setLeftNavBarItemWithImageName:(NSString *)name {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
}
-(void)back:(id)sender {
    CJMainViewController *mainC = [[CJMainViewController alloc] init];
    [[[[CJAppDelegate shareCJAppDelegate] rootController] navController] setCenterViewController:mainC withCloseAnimation:YES completion:nil];
}
-(void)initUI {
    _infoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _infoTable.delegate = self;
    _infoTable.dataSource = self;
    _infoTable.backgroundColor = [UIColor whiteColor];
    _infoTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _infoTable.separatorInset = UIEdgeInsetsMake(0, -5, 0, 5);
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
        _headImageSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"从相册上传", nil];
        [_headImageSheet showInView:self.view];
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
    [getinBt setTitle:@"退出登录" forState:UIControlStateNormal];
    getinBt.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [getinBt addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    getinBt.backgroundColor = kColor(225, 39, 39, 1);
    [footView addSubview:getinBt];
    return footView;
}
-(void)logout:(id)sender {
    NSLog(@"退出登录");
}
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for (UIView *subView in actionSheet.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *bt = (UIButton *)subView;
            if (bt.tag == 3) {
                [bt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
        }
    }
}
@end
