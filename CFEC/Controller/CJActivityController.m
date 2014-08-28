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
@interface CJActivityController ()

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
       [listArray insertObject:[KxMenuItem menuItem:@"最新活动" image:nil target:self action:@selector(lastActivityClick)] atIndex:1];
        rect = CGRectMake(50, 104, 0, 0);
    }else if (segment.selectedSegmentIndex == 1) {
        NSLog(@"举办方");
        listArray = [NSMutableArray arrayWithObjects:[KxMenuItem menuItem:@"全部" image:nil target:segment action:@selector(allClack:)], nil];
        [listArray insertObject:[KxMenuItem menuItem:@"CFEC主办" image:nil target:self action:@selector(zhubanClick:)] atIndex:1];
        [listArray insertObject:[KxMenuItem menuItem:@"CFEC支持" image:nil target:self action:@selector(zhichiClick:)] atIndex:2];
        rect = CGRectMake(150, 104, 0, 0);
    }else {
        NSLog(@"所在地");
        listArray = [NSMutableArray arrayWithObjects:[KxMenuItem menuItem:@"全部" image:nil target:self action:@selector(allPlaceClick:)], nil];
        [listArray insertObject:[KxMenuItem menuItem:@"北京" image:nil target:self action:@selector(beijinClick:)] atIndex:1];
        [listArray insertObject:[KxMenuItem menuItem:@"上海" image:nil target:self action:@selector(shanghaiClick:)] atIndex:2];
        [listArray insertObject:[KxMenuItem menuItem:@"其他" image:nil target:self action:@selector(otherClick:)] atIndex:3];
        rect = CGRectMake(250, 104, 0, 0);
    }
    KxMenuItem *first = listArray[0];
    first.foreColor = [UIColor greenColor];
    first.alignment = NSTextAlignmentNatural;
    [KxMenu showMenuInView:self.view fromRect:rect menuItems:listArray];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    CJActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CJActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.mainContentLabel.text = @"2014中国财务精英高峰论坛 - 北京站";
    cell.holdLable.text = @"CFEC主办";
    cell.spendLabel.text = @"20.000";
    cell.holdImage.image = [UIImage imageNamed:@"活动1_06@2x.png"];
    cell.spendImage.image = [UIImage imageNamed:@"活动_03@2x.png"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
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
