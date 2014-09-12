//
//  CJHomeViewController.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJHomeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "CJCompleteInfoCell.h"
#import "CJAppDelegate.h"
#import "CJActivityDetailController.h"
#import "CJRequestFormat.h"
#import "CJActivityModel.h"
#import "UIImageView+WebCache.h"

@interface CJHomeViewController ()
{
    NSMutableArray *activityArr0;//财务沙龙
    NSMutableArray *activityArr1;//财智学院
    NSMutableArray *activityArr2;//行业峰会
    NSMutableArray *activityArr3;//乐活节
    NSMutableArray *activityArr4;//商务学院
    NSMutableArray *activityArr5;//税务学院
    NSMutableArray *activityArr6;
    NSMutableArray *lastArray;//当前显示的活动数组
}
@end

@implementation CJHomeViewController

@synthesize mainTable = _mainTable;

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
    self.navigationItem.title = @"CFEC";
    [self setLeftNavBarItemWithImageName:@"首页_03@2x"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self GetActivityMessage];//获取活动信息
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
    [leftButton addTarget:self action:@selector(list:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
}
#pragma mark - Action

- (IBAction)list:(id)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(void)initUI {
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _mainTable.backgroundColor = [UIColor whiteColor];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.tableHeaderView = [self setTableHeadView];
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _mainTable.separatorInset = UIEdgeInsetsMake(0, -2, 0, 2);
    [self.view addSubview:_mainTable];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _newsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    CJCompleteInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    CJActivityModel *activityModel = _newsArray[indexPath.row];
    
    if ([activityModel.activityGenre isEqualToString:@"0"]) {
        cell.headImage.image = [UIImage imageNamed:@"财务沙龙-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"1"]) {
        cell.headImage.image = [UIImage imageNamed:@"财务沙龙-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"2"]) {
        cell.headImage.image = [UIImage imageNamed:@"财智学苑-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"3"]) {
        cell.headImage.image = [UIImage imageNamed:@"商务学院-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"4"]) {
        cell.headImage.image = [UIImage imageNamed:@"乐活节-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"5"]) {
        cell.headImage.image = [UIImage imageNamed:@"行业峰会-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"6"]) {
        cell.headImage.image = [UIImage imageNamed:@"税务学苑-透明_03@2x.png"];
    }
//    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:activityModel.pictures] placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
    cell.infoName.text = activityModel.title;
    return cell;
}

-(UIView *)setTableHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 176.0f)];
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 176.0f)];
    headImage.image = [UIImage imageNamed:@"首页_06.png"];
    [headView addSubview:headImage];
    return headView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CJActivityDetailController *detailControl = [[CJActivityDetailController alloc] init];
    detailControl.activityModel = _newsArray[indexPath.row];
    
//    CJUserModel *user = [CJAppDelegate shareCJAppDelegate].user;
//    CJActivityModel *model = _newsArray[indexPath.row];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"2404" forKey:@"userId"];
//    [dic setObject:@"M20140910140000" forKey:@"orderNo"];
//    [dic setObject:model.ID forKey:@"activityId"];
//    [dic setObject:model.title forKey:@"activityName"];
//    [dic setObject:model.mobileContent forKey:@"activityDescribe"];
//    [dic setObject:user.name forKey:@"name"];
//    [dic setObject:user.email forKey:@"email"];
//    [dic setObject:user.mobilephone forKey:@"telephone"];
//    [dic setObject:user.companyName forKey:@"companyName"];
//    [dic setObject:@"2000" forKey:@"price"];
//    [dic setObject:@"2000" forKey:@"orderAmount"];
//    [dic setObject:@"1" forKey:@"quantity"];
//    NSError *error;
//    NSData *data;
//    data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    [CJRequestFormat createOrderWithOrderJson:jsonStr finished:^(ResponseStatus status, NSString *response) {
//        if (status == 0) {
//            NSLog(@"成功");
//        }else if (status == 1) {
//            NSLog(@"请求出错");
//        }else if (status == 2) {
//            NSLog(@"请求成功，返回出错");
//        }
//    }];
    
    detailControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailControl animated:YES];
}
-(void)GetActivityMessage {
    activityArr0 = [NSMutableArray array];
    activityArr1 = [NSMutableArray array];
    activityArr2 = [NSMutableArray array];
    activityArr3 = [NSMutableArray array];
    activityArr4 = [NSMutableArray array];
    activityArr5 = [NSMutableArray array];
    activityArr6 = [NSMutableArray array];
    lastArray = [NSMutableArray array];
    [CJRequestFormat getActivityTitleFinished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            NSError *error;
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *titleActivityArray = [NSMutableArray array];
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSArray *receiveArray = (NSArray *)jsonObject;
                for (int i = 0; i<receiveArray.count; i++) {
                    NSDictionary *dic = [receiveArray objectAtIndex:i];
                    CJActivityModel *activityModel = [[CJActivityModel alloc] init];
                    activityModel.activityGenre = [dic objectForKey:@"activityGenre"];
                    activityModel.activityType = [dic objectForKey:@"activityType"];
                    activityModel.commonCost = [dic objectForKey:@"commonCost"];
                    activityModel.diamondCost = [dic objectForKey:@"diamondCost"];
                    activityModel.endTime = [dic objectForKey:@"endTime"];
                    activityModel.goldCost = [dic objectForKey:@"goldCost"];
                    activityModel.ID = [dic objectForKey:@"id"];
                    activityModel.inviteTarget = [dic objectForKey:@"inviteTarget"];
                    activityModel.meetingAddress = [dic objectForKey:@"meetingAddress"];
                    activityModel.meetingCost = [dic objectForKey:@"meetingCost"];
                    activityModel.meetingNumber = [dic objectForKey:@"meetingNumber"];
                    activityModel.mobileContent = [dic objectForKey:@"mobileContent"];
                    activityModel.picture = [dic objectForKey:@"picture"];
                    activityModel.pictures = [dic objectForKey:@"pictures"];
                    activityModel.platinumCost = [dic objectForKey:@"platinumCost"];
                    activityModel.startTime = [dic objectForKey:@"startTime"];
                    activityModel.title = [dic objectForKey:@"title"];
                    [titleActivityArray addObject:activityModel];
//                    NSLog(@"%@",activityModel.activityGenre);
                }
                [CJAppDelegate shareCJAppDelegate].allActivityArray = titleActivityArray;
                NSLog(@"count:%d",titleActivityArray.count);
                for (int i = 0; i<titleActivityArray.count;i++) {
                    CJActivityModel *activity = titleActivityArray[i];
                    if ([activity.activityGenre isEqualToString:@"0"]) {
                        [activityArr0 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"1"]) {
                        [activityArr1 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"2"]) {
                        [activityArr2 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"3"]) {
                        [activityArr3 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"4"]) {
                        [activityArr4 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"5"]){
                        [activityArr5 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"6"]){
                        [activityArr6 addObject:activity];
                    }
                }
//                NSLog(@"count: %d,%d,%d,%d,%d,%d",activityArr0.count,activityArr1.count,activityArr2.count,activityArr3.count,activityArr4.count,activityArr5.count);                
            }
            [self getLastArr];
            [_mainTable reloadData];
        }
    }];
}
- (NSArray *)getLastArrWay:(NSArray *)contactList {
    return [contactList sortedArrayUsingComparator:^NSComparisonResult(CJActivityModel *model1, CJActivityModel *model2) {
        NSDate *date1 = [self dateWithString:model1.startTime];
        NSDate *date2 = [self dateWithString:model2.startTime];
//        if (!date1 && date2) {
//            return NSOrderedDescending;
//        }
//        if (date1 && !date2) {
//            return NSOrderedAscending;
//        }
        NSComparisonResult result = [date1 compare:date2];
        return result;
    }];
}
- (NSDate *)dateWithString:(NSString *)string {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [format dateFromString:string];
}
-(void)getLastArr {
    NSArray *paixuarr0 = [self getLastArrWay:activityArr0];
    NSArray *paixuarr1 = [self getLastArrWay:activityArr1];
    NSArray *paixuarr2 = [self getLastArrWay:activityArr2];
    NSArray *paixuarr3 = [self getLastArrWay:activityArr3];
    NSArray *paixuarr4 = [self getLastArrWay:activityArr4];
    NSArray *paixuarr5 = [self getLastArrWay:activityArr5];
    NSArray *paixuarr6 = [self getLastArrWay:activityArr6];
    _newsArray = [NSMutableArray array];
    if ([paixuarr0 count] > 0) {
        [_newsArray addObject:[paixuarr0 objectAtIndex:0]];
    }
    if ([paixuarr1 count] > 0) {
        [_newsArray addObject:[paixuarr1 objectAtIndex:0]];
    }
    if ([paixuarr2 count] > 0) {
        [_newsArray addObject:[paixuarr2 objectAtIndex:0]];
    }
    if ([paixuarr3 count] > 0) {
        [_newsArray addObject:[paixuarr3 objectAtIndex:0]];
    }
    if ([paixuarr4 count] > 0) {
        [_newsArray addObject:[paixuarr4 objectAtIndex:0]];
    }
    if ([paixuarr5 count] > 0) {
        [_newsArray addObject:[paixuarr5 objectAtIndex:0]];
    }
    if([paixuarr6 count] > 0) {
        [_newsArray addObject:[paixuarr6 objectAtIndex:0]];
    }
//    NSLog(@"--------%d",_newsArray.count);
}
@end
