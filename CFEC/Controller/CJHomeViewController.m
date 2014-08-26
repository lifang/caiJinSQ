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

@interface CJHomeViewController ()
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
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _mainTable.backgroundColor = [UIColor whiteColor];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.tableHeaderView = [self setTableHeadView];
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview:_mainTable];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    CJCompleteInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CJCompleteInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.headImage.image = [UIImage imageNamed:@"首页-个人资料_03-07@2x.png"];
    cell.infoName.text = @"中国财务精英论坛";
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
    CJActivityDetailController *detailControl = [[CJActivityDetailController alloc] init];
    [self.navigationController pushViewController:detailControl animated:YES];
}
@end
