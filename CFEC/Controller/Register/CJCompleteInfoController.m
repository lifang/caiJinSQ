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
#import "CJBusinessRangeViewController.h"
#import "CJInterestingWhyViewController.h"
#import "CJSchoolViewController.h"
#import "CJProfessionViewController.h"
#import "CJGraduationViewController.h"

@interface CJCompleteInfoController ()<nameDelegate,telDelegate,companyDelegate,companyDelegate,jobDelegate,emailDelegate,schoolDelegate,professionDelegate,graduationDelegate,businessDelegate,interestingDelegate>
{
    //代理传过来接受的参数
    NSString *nameStr;
    NSString *telStr;
    NSString *companyStr;
    NSString *jobStr;
    NSString *emailStr;
    NSString *schoolStr;
    NSString *professionStr;
    NSString *graduationStr;
    NSString *businessStr;
    NSString *interestingStr;
}
@end

@implementation CJCompleteInfoController

@synthesize infoTable = _infoTable;
@synthesize commitDic = _commitDic;

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
    self.title = @"完善资料";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self initUI];
    NSLog(@"%@",self.emailRegisterStr);
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
    _infoTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _infoTable.separatorInset = UIEdgeInsetsMake(0, -5, 0, 5);
    [self.view addSubview:_infoTable];
    
    
    nameStr = [NSString string];
    telStr = [NSString string];
    companyStr = [NSString string];
    jobStr = [NSString string];
    emailStr = [NSString string];
    professionStr = [NSString string];
    graduationStr = [NSString string];
    businessStr = [NSString string];
    interestingStr = [NSString string];
    
    _commitDic = [NSMutableDictionary dictionary];
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
    if (![self.campString isEqualToString:@"F"]) {
        //不是财务专业学生
        if (indexPath.row == 0) {
            static NSString *ID = @"one";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"姓名";
            cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-07@2x"];
            cell.peopleInfo.text = nameStr;
            return cell;
        }else if (indexPath.row == 1) {
            static NSString *ID = @"two";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"电话";
            cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-11@2x"];
            cell.peopleInfo.text = telStr;
            return cell;
        }else if (indexPath.row == 2) {
            static NSString *ID = @"three";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"公司";
            cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-13@2x"];
            cell.peopleInfo.text = companyStr;
            
            return cell;
        }else if (indexPath.row == 3) {
            static NSString *ID = @"four";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"职位";
            cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-16@2x"];
            cell.peopleInfo.text = jobStr;
            
            return cell;
            
        }else if (indexPath.row == 4) {
            static NSString *ID = @"five";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"邮箱";
            cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-18@2x"];
            cell.peopleInfo.text = emailStr;
            return cell;
        }else {
            static NSString *ID = @"six";
            CJCompleteInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if ([self.campString isEqualToString:@"A"]||[self.campString isEqualToString:@"I"]) {    //当注册者为在职财务A或者待业I
                cell.hidden = YES;
            }else if ([self.campString isEqualToString:@"E"]) {
                //当注册者为财务圈相关人士E
                cell.infoName.text = @"业务范围";
                cell.headImage.image = [UIImage imageNamed:@"业务范围@2x.png"];
                cell.peopleInfo.text = businessStr;
            }else {
                //当注册者为感兴趣人士
                cell.infoName.text = @"感兴趣原因";
                cell.headImage.image = [UIImage imageNamed:@"兴趣原因@2x.png"];
                cell.peopleInfo.text = interestingStr;
            }
            return cell;
        }
    }else {
        //是财务专业学生
        if (indexPath.row == 0) {
            static NSString *ID = @"one";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"姓名";
            cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-07@2x"];
            cell.peopleInfo.text = nameStr;
            return cell;
        }else if (indexPath.row == 1) {
            static NSString *ID = @"two";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"电话";
            cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-11@2x"];
            cell.peopleInfo.text = telStr;
            return cell;
        }else if (indexPath.row == 2) {
            static NSString *ID = @"three";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"学校";
            cell.headImage.image = [UIImage imageNamed:@"学校@2x.png"];
            cell.peopleInfo.text = schoolStr;
            return cell;
        }else if (indexPath.row == 3) {
            static NSString *ID = @"three";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"专业";
            cell.headImage.image = [UIImage imageNamed:@"专业@2x.png"];
            cell.peopleInfo.text = professionStr;
            return cell;
        }else if (indexPath.row == 4) {
            static NSString *ID = @"five";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"邮箱";
            cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-18@2x"];
            cell.peopleInfo.text = emailStr;
            return cell;
        }else {
            static NSString *ID = @"five";
            CJCompleteInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
            if(cell == nil) {
                cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.infoName.text = @"毕业时间";
            cell.headImage.image = [UIImage imageNamed:@"毕业时间@2x.png"];
            cell.peopleInfo.text = graduationStr;
            return cell;
        }
    }
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![self.campString isEqualToString:@"F"]) {
        if (indexPath.row == 0) {
            CJNameController *nameControl = [[CJNameController alloc] init];
            nameControl.isShow = NO;
            nameControl.delegate = self;
            [self.navigationController pushViewController:nameControl animated:YES];
        }else if (indexPath.row == 1) {
            CJTelController *telControl = [[CJTelController alloc] init];
            telControl.delegate = self;
            [self.navigationController pushViewController:telControl animated:YES];
        }else if (indexPath.row == 2) {
            CJCompanyController *companyControl = [[CJCompanyController alloc] init];
            companyControl.delegate = self;
            [self.navigationController pushViewController:companyControl animated:YES];
        }else if (indexPath.row == 3) {
            CJJobController *jobControl = [[CJJobController alloc] init];
            jobControl.delegate = self;
            [self.navigationController pushViewController:jobControl animated:YES];
        }else if (indexPath.row == 4) {
            CJEmailController *emailControl = [[CJEmailController alloc] init];
            emailControl.delegate = self;
            [self.navigationController pushViewController:emailControl animated:YES];
        }else if (indexPath.row == 5) {
            if ([self.campString isEqualToString:@"E"]) {
                CJBusinessRangeViewController *businessControl = [[CJBusinessRangeViewController alloc]init];
                businessControl.delegate = self;
                [self.navigationController pushViewController:businessControl animated:YES];
            }else if ([self.campString isEqualToString:@"P"]) {
                CJInterestingWhyViewController *interestingControl = [[CJInterestingWhyViewController alloc] init];
                interestingControl.delegate = self;
                [self.navigationController pushViewController:interestingControl animated:YES];
            }
        }
    }else {
        if (indexPath.row == 0) {
            CJNameController *nameControl = [[CJNameController alloc] init];
            nameControl.delegate = self;
            [self.navigationController pushViewController:nameControl animated:YES];
        }else if (indexPath.row == 1) {
            CJTelController *telControl = [[CJTelController alloc] init];
            telControl.delegate = self;
            [self.navigationController pushViewController:telControl animated:YES];
        }else if (indexPath.row == 2) {
            CJSchoolViewController *schoolControl = [[CJSchoolViewController alloc] init];
            schoolControl.delegate = self;
            [self.navigationController pushViewController:schoolControl animated:YES];
        }else if (indexPath.row == 3) {
            CJProfessionViewController *professionControl = [[CJProfessionViewController alloc] init];
            professionControl.delegate = self;
            [self.navigationController pushViewController:professionControl animated:YES];
        }else if (indexPath.row == 4) {
            CJEmailController *emailControl = [[CJEmailController alloc] init];
            emailControl.delegate = self;
            [self.navigationController pushViewController:emailControl animated:YES];
        }else {
            CJGraduationViewController *graduationControl = [[CJGraduationViewController alloc] init];
            graduationControl.delegate = self;
            [self.navigationController pushViewController:graduationControl animated:YES];
        }
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
    [getinBt setTitle:@"提交" forState:UIControlStateNormal];
    getinBt.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [getinBt addTarget:self action:@selector(getIn:) forControlEvents:UIControlEventTouchUpInside];
    getinBt.backgroundColor = kColor(93, 201, 16, 1);
    [footView addSubview:getinBt];
    return footView;
}
-(void)getIn:(id)sender {
    NSLog(@"提交");
    NSError *error;
    NSData *jsonDate;
    NSString *jsonStr;
    GroupType type;
    if (![_campString isEqualToString:@"F"]) {
        //在职财务、待业
        [_commitDic setObject:nameStr forKey:@"name"];
        [_commitDic setObject:companyStr forKey:@"company_name"];
        [_commitDic setObject:jobStr forKey:@"position"];
        [_commitDic setObject:emailStr forKey:@"company_email"];
        [_commitDic setObject:telStr forKey:@"mobilephone"];
        [_commitDic setObject:self.emailRegisterStr forKey:@"email"];

        if ([_campString isEqualToString:@"E"]) {
            //财务圈相关人士
            type = GroupE;
            [_commitDic setObject:businessStr forKey:@"business_range"];
        }else if ([_campString isEqualToString:@"P"]) {
            //感兴趣
            [_commitDic setObject:interestingStr forKey:@"interested_reason"];
            type = GroupP;
        }else if ([_campString isEqualToString:@"A"]) {
            type = GroupA;
        }else if ([_campString isEqualToString:@"I"]) {
            type = GroupI;
        }
    }else {
        //学生
        [_commitDic setObject:nameStr forKey:@"name"];
        [_commitDic setObject:schoolStr forKey:@"school"];
        [_commitDic setObject:professionStr forKey:@"specialty"];
        [_commitDic setObject:self.emailRegisterStr forKey:@"email"];
        [_commitDic setObject:telStr forKey:@"mobilephone"];
        [_commitDic setObject:graduationStr forKey:@"graduation_time"];
        [_commitDic setObject:emailStr forKey:@"company_email"];
        type = GroupF;
    }
    
    jsonDate = [NSJSONSerialization dataWithJSONObject:_commitDic options:NSJSONWritingPrettyPrinted error:&error];
    jsonStr = [[NSString alloc] initWithData:jsonDate encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonStr);
    
    [CJRequestFormat addPersonalInformationWithJson:jsonStr groupType:type finished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            NSData *userdate = [response dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:userdate options:NSJSONReadingAllowFragments error:&error];
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary *)jsonObject;
                NSString *msg = [dic objectForKey:@"msg"];
                if ([msg isEqualToString:@"error"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"填写错误" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }else {
                    NSLog(@"注册全部完成");
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
        }else if (status == 1) {
            NSLog(@"数据请求出错");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络不稳定请重新尝试" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }else {
            NSLog(@"数据请求成功返回出错");
        }
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50.0f;
}
//代理方法的实现
-(void)returnMessage:(NSString *)s {
    nameStr = s;
    [_infoTable reloadData];
}
-(void)telMessage:(NSString *)s {
    telStr = s;
    [_infoTable reloadData];
}
-(void)companyMessage:(NSString *)s {
    companyStr = s;
    [_infoTable reloadData];
}
-(void)jobMessage:(NSString *)s {
    jobStr = s;
    [_infoTable reloadData];
}
-(void)emailMessage:(NSString *)s {
    emailStr = s;
    [_infoTable reloadData];
}
-(void)schoolMessage:(NSString *)s {
    schoolStr = s;
    [_infoTable reloadData];
}
-(void)professionMessage:(NSString *)s {
    professionStr = s;
    [_infoTable reloadData];
}
-(void)graduationMessage:(NSString *)s {
    graduationStr = s;
    [_infoTable reloadData];
}
-(void)businessMessage:(NSString *)s {
    businessStr = s;
    [_infoTable reloadData];
}
-(void)interestingMessage:(NSString *)s {
    interestingStr = s;
    [_infoTable reloadData];
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
