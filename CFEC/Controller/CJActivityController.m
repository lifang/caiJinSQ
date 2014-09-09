//
//  CJActivityController.m
//  CFEC
//
//  Created by SumFlower on 14-8-22.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJActivityController.h"
#import "KxMenu.h"
#import "CJActivityCell.h"
#import "CJAppDelegate.h"
#import "CJActivityModel.h"
#import "CJActivityDetailController.h"
@interface CJActivityController ()
{
    NSArray *allActivityarr;//所有活动未作处理的
    NSArray *tableArray;
}
@end

@implementation CJActivityController

@synthesize filtrateSegment = _filtrateSegment;
@synthesize activityTable = _activityTable;
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
    self.navigationItem.title = @"活动";
    self.view.backgroundColor = [UIColor whiteColor];
    allActivityarr = [CJAppDelegate shareCJAppDelegate].allActivityArray;
    tableArray = [NSArray array];
    tableArray = allActivityarr;
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUI {
    NSArray *arr = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    _filtrateSegment = [[UISegmentedControl alloc] initWithItems:arr];
    _filtrateSegment.frame = CGRectMake(10, 74, 300, 30);
    _filtrateSegment.tintColor = kColor(147, 209, 27, 1);
    [_filtrateSegment setImage:[UIImage imageNamed:@"时间2@2x.png"] forSegmentAtIndex:0];
    [_filtrateSegment setImage:[UIImage imageNamed:@"举办方2@2x.png"] forSegmentAtIndex:1];
    [_filtrateSegment setImage:[UIImage imageNamed:@"所在地2@2x.png"] forSegmentAtIndex:2];
    _filtrateSegment.userInteractionEnabled = YES;
    [_filtrateSegment addTarget:self action:@selector(selectIndex:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_filtrateSegment];
    _activityTable = [[UITableView alloc] initWithFrame:CGRectMake(0 , 104 + 10, self.view.frame.size.width, self.view.frame.size.height - 80) style:UITableViewStyleGrouped];
    _activityTable.delegate = self;
    _activityTable.dataSource = self;
    _activityTable.backgroundColor = [UIColor whiteColor];
    _activityTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _activityTable.separatorInset = UIEdgeInsetsMake(0, -2, 0, 2);
    [self.view addSubview:_activityTable];
}
-(void)selectIndex:(UISegmentedControl *)segment {
    CGRect rect;
    NSMutableArray *listArray;
    
    _filtrateSegment.momentary = YES;

    if (segment.selectedSegmentIndex == 0) {
        NSLog(@"时间");
        listArray = [NSMutableArray arrayWithObjects:[KxMenuItem menuItem:@"默认" image:nil target:self action:@selector(defaultClick:)], nil];
        [listArray insertObject:[KxMenuItem menuItem:@"最新活动" image:nil target:self action:@selector(lastActivityClick:)] atIndex:1];
        rect = CGRectMake(60, 104, 0, 0);
    }else if (segment.selectedSegmentIndex == 1) {
        NSLog(@"举办方");
        listArray = [NSMutableArray arrayWithObjects:[KxMenuItem menuItem:@"全部" image:nil target:self action:@selector(allHoldClick:)], nil];
        [listArray insertObject:[KxMenuItem menuItem:@"CFEC主办" image:nil target:self action:@selector(mainHoldClick:)] atIndex:1];
        [listArray insertObject:[KxMenuItem menuItem:@"CFEC支持" image:nil target:self action:@selector(supportClick:)] atIndex:2];
        rect = CGRectMake(160, 104, 0, 0);
    }else {
        NSLog(@"所在地");
        listArray = [NSMutableArray arrayWithObjects:[KxMenuItem menuItem:@"全部" image:nil target:self action:@selector(allPlaceClick:)], nil];
        [listArray insertObject:[KxMenuItem menuItem:@"北京" image:nil target:self action:@selector(beijinClick:)] atIndex:1];
        [listArray insertObject:[KxMenuItem menuItem:@"上海" image:nil target:self action:@selector(shanghaiClick:)] atIndex:2];
        [listArray insertObject:[KxMenuItem menuItem:@"其他" image:nil target:self action:@selector(otherCityClick:)] atIndex:3];
        rect = CGRectMake(260, 104, 0, 0);
    }
    KxMenuItem *first = listArray[0];
//    first.foreColor = [UIColor greenColor];
    first.alignment = NSTextAlignmentNatural;
    [KxMenu showMenuInView:self.view fromRect:rect menuItems:listArray];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    CJActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CJActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    CJActivityModel *activityModel = tableArray[indexPath.row];
    if ([activityModel.activityGenre isEqualToString:@"0"]) {
        cell.titleImage.image = [UIImage imageNamed:@"财务沙龙-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"1"]) {
        cell.titleImage.image = [UIImage imageNamed:@"财务沙龙-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"2"]) {
        cell.titleImage.image = [UIImage imageNamed:@"财智学苑-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"3"]) {
        cell.titleImage.image = [UIImage imageNamed:@"商务学院-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"4"]) {
        cell.titleImage.image = [UIImage imageNamed:@"乐活节-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"5"]) {
        cell.titleImage.image = [UIImage imageNamed:@"行业峰会-透明_03@2x.png"];
    }else if ([activityModel.activityGenre isEqualToString:@"6"]) {
        cell.titleImage.image = [UIImage imageNamed:@"税务学苑-透明_03@2x.png"];
    }
    cell.mainContentLabel.text = [NSString stringWithFormat:@"%@ - %@",activityModel.title,activityModel.meetingAddress];
    if ([activityModel.activityType isEqualToString:@"0"]) {
        cell.holdLable.text = @"CFEC主办";
    }else {
        cell.holdLable.text = @"CFEC支持";
    }
    cell.spendLabel.text = activityModel.meetingCost;
    cell.holdImage.image = [UIImage imageNamed:@"活动1_06@2x.png"];
    cell.spendImage.image = [UIImage imageNamed:@"活动_03@2x.png"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CJActivityDetailController *detailControl = [[CJActivityDetailController alloc] init];
    detailControl.hidesBottomBarWhenPushed = YES;
    detailControl.activityModel = tableArray[indexPath.row];
    [self.navigationController pushViewController:detailControl animated:YES];
}
-(void)defaultClick:(id)sender {
    tableArray = allActivityarr;
    [_activityTable reloadData];
}
-(void)lastActivityClick:(id)sender {
    NSArray *temparray = [NSArray array];
    temparray = tableArray;
    tableArray = [self getLastArrWay:temparray];
    [_activityTable reloadData];
}
-(void)allHoldClick:(id)sender {
    tableArray = allActivityarr;
    [_activityTable reloadData];
}
-(void)mainHoldClick:(id)sender {
    [self judgeIsHost:allActivityarr];
    [_activityTable reloadData];
}
-(void)supportClick:(id)sender {
    [self judgeIsSupport:allActivityarr];
    [_activityTable reloadData];
}
-(void)allPlaceClick:(id)sender {
    tableArray = allActivityarr;
    [_activityTable reloadData];
}
-(void)beijinClick:(id)sender {
    [self judgeIsBeijin:allActivityarr];
    [_activityTable reloadData];
}
-(void)shanghaiClick:(id)sender {
    [self judgeIsShanghai:allActivityarr];
    [_activityTable reloadData];
}
-(void)otherCityClick:(id)sender {
    [self judgeIsOther:allActivityarr];
    [_activityTable reloadData];
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
//判断主办和支持
-(void)judgeIsHost:(NSArray *)arr {
    NSMutableArray *okArr = [NSMutableArray array];
    for (CJActivityModel *model in arr) {
        if ([model.activityType isEqualToString:@"0"]) {
            [okArr addObject:model];
        }
    }
    tableArray = okArr;
}
-(void)judgeIsSupport:(NSArray *)arr {
    NSMutableArray *okArr = [NSMutableArray array];
    for (CJActivityModel *model in arr) {
        if ([model.activityType isEqualToString:@"1"]) {
            [okArr addObject:model];
        }
    }
    tableArray = okArr;
}
//判断城市
-(void)judgeIsBeijin:(NSArray *)arr {
    NSMutableArray *okArr = [NSMutableArray array];
    for (CJActivityModel *model in arr) {
        if ([model.meetingAddress isEqualToString:@"北京"]) {
            [okArr addObject:model];
        }
    }
    tableArray = okArr;
}
-(void)judgeIsShanghai:(NSArray *)arr {
    NSMutableArray *okArr = [NSMutableArray array];
    for (CJActivityModel *model in arr) {
        if ([model.meetingAddress isEqualToString:@"上海"]) {
            [okArr addObject:model];
        }
    }
    tableArray = okArr;

}
-(void)judgeIsOther:(NSArray *)arr {
    NSMutableArray *okArr = [NSMutableArray array];
    for (CJActivityModel *model in arr) {
        if (![model.meetingAddress isEqualToString:@"北京"]&&![model.meetingAddress isEqualToString:@"上海"]) {
            [okArr addObject:model];
        }
    }
    tableArray = okArr;
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
