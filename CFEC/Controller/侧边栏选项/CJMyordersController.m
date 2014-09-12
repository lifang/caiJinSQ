//
//  CJMyordersController.m
//  CFEC
//
//  Created by SumFlower on 14-8-29.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJMyordersController.h"
#import "CJAppDelegate.h"
#import "CJMainViewController.h"
#import "CJPayedCell.h"
#import "CJRequestFormat.h"
#import "CJUserModel.h"
@interface CJMyordersController ()<UITableViewDataSource,UITableViewDelegate>
{
    CJUserModel *user;
}
@property (nonatomic ,strong) UISegmentedControl *segControl;
@property (nonatomic, strong) UITableView *giftTable;
@end

@implementation CJMyordersController
@synthesize segControl = _segControl;
@synthesize giftTable = _giftTable;
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
    [self initUI];
    [self getDateFromNet];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    _segControl = [[UISegmentedControl alloc] initWithItems:@[@"已支付",@"待支付"]];
    _segControl.frame = CGRectMake(0, 0, 150, 20);
    _segControl.tintColor = [UIColor whiteColor];
    _segControl.selectedSegmentIndex = 0;
    [_segControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segControl;
    
    _giftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _giftTable.delegate = self;
    _giftTable.dataSource = self;
    [self.view addSubview:_giftTable];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *first = @"first";
    CJPayedCell *cell = [tableView dequeueReusableCellWithIdentifier:first];
    if (cell == nil) {
        cell = [[CJPayedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:first];
    }
    if (_segControl.selectedSegmentIndex == 1) {
        cell.cancelButton.hidden = NO;
        cell.payButton.hidden = NO;
        cell.deleteButton.hidden = YES;
    }else if (_segControl.selectedSegmentIndex == 0) {
        cell.cancelButton.hidden = YES;
        cell.payButton.hidden = YES;
        cell.deleteButton.hidden = NO;
    }
    cell.giftImage.image = [UIImage imageNamed:@"活动2@2x.png"];
    cell.giftTitleLabel.text = @"2014中国财务精英高峰论坛--北京站";
    cell.organizerLabel.text = @"CEFC";
    cell.priceLabel.text = @"20,000";
    cell.numberLabel.text = @"数量 1 件";
    cell.sumLabel.text = @"金额: $20,000";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)segmentAction:(UISegmentedControl*)segment {
    if (segment.selectedSegmentIndex == 0) {
        [_giftTable reloadData];
    }else {
        [_giftTable reloadData];
    }
}
-(void)getDateFromNet {
    user = [CJAppDelegate shareCJAppDelegate].user;
    [CJRequestFormat getMobileOrderWithUserID:user.userId finished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            NSError *error;
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"------%@",jsonObject);
        }else if (status == 1) {
            NSLog(@"请求出错");
        }else if (status == 2) {
            NSLog(@"请求成功，返回出错");
        }
    }];
}
@end
