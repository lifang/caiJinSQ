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
#import "CJOrderModel.h"
#import "UIImageView+WebCache.h"

@interface CJMyordersController ()<UITableViewDataSource,UITableViewDelegate,deleteDelegate,cancelDelegate,payDelegate>
{
    CJUserModel *user;
    NSMutableArray *noPayArray;
    NSMutableArray *payedArray;
    NSMutableArray *tableViewArray;
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
    noPayArray = [NSMutableArray array];
    payedArray = [NSMutableArray array];
    tableViewArray = [NSMutableArray array];
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
    return tableViewArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *first = @"first";
    CJPayedCell *cell = [tableView dequeueReusableCellWithIdentifier:first];
    if (cell == nil) {
        cell = [[CJPayedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:first];
    }
    cell.delegateCancel = self;
    cell.delegateDelete = self;
    cell.delegatePay = self;
    if (_segControl.selectedSegmentIndex == 1) {
        cell.cancelButton.hidden = NO;
        cell.payButton.hidden = NO;
        cell.deleteButton.hidden = YES;
    }else if (_segControl.selectedSegmentIndex == 0) {
        cell.cancelButton.hidden = YES;
        cell.payButton.hidden = YES;
        cell.deleteButton.hidden = NO;
    }
    CJOrderModel *order = tableViewArray[indexPath.row];
    [cell.giftImage sd_setImageWithURL:[NSURL URLWithString:order.image] placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
    NSString *name = [NSString stringWithFormat:@"%@",order.goodName];
    NSString *price = [NSString stringWithFormat:@"%@",order.price];
    NSString *number = [NSString stringWithFormat:@"%@",order.quantity];
    int priceInt = [price intValue];
    int numberInt = [number intValue];
    int sumPrice = priceInt * numberInt;
    cell.giftTitleLabel.text = name;
    cell.organizerLabel.text = @"CEFC";
    cell.priceLabel.text = price;
    cell.numberLabel.text = [NSString stringWithFormat:@"数量%@件",number];
    cell.sumLabel.text = [NSString stringWithFormat:@"金额:￥%d",sumPrice];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)segmentAction:(UISegmentedControl*)segment {
    if (segment.selectedSegmentIndex == 0) {
        tableViewArray = payedArray;
        [_giftTable reloadData];
    }else {
        tableViewArray = noPayArray;
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
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSMutableArray *jsonArray = (NSMutableArray *)jsonObject;
                for (int i = 0; i < jsonArray.count; i++) {
                    NSMutableDictionary *dic = jsonArray[i];
                    CJOrderModel *order = [[CJOrderModel alloc] init];
                    order.goodName = [dic objectForKey:@"goodName"];
                    order.image = [dic objectForKey:@"picture"];
                    order.price = [dic objectForKey:@"price"];
                    order.quantity = [dic objectForKey:@"quantity"];
                    order.tradeStatus = [dic objectForKey:@"tradeStatus"];
                    order.orderNo = [dic objectForKey:@"orderNo"];
                    if ([order.tradeStatus isEqualToString:@"TRADE_NOSUCCESS"]) {
                        [noPayArray addObject:order];
                    }else {
                        [payedArray addObject:order];
                    }
                }
                tableViewArray = payedArray;
                [_giftTable reloadData];
            }
        }else if (status == 1) {
            NSLog(@"请求出错");
        }else if (status == 2) {
            NSLog(@"请求成功，返回出错");
        }
    }];
}
-(void)deleteAction:(UIButton *)bt {
    for (UIView* next = [bt superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[CJPayedCell class]]) {
            CJPayedCell *cell = (CJPayedCell *)nextResponder;
            NSIndexPath *index = [_giftTable indexPathForCell:cell];
            NSLog(@"%ld",(long)index.row);
            CJOrderModel *orderModel = [[CJOrderModel alloc] init];
            orderModel = payedArray[index.row];
            [CJRequestFormat deleteMobileOrder:orderModel.orderNo finished:^(ResponseStatus status, NSString *response) {
                if (status == 0) {
                    NSLog(@"请求成功");
                }else if (status == 1) {
                    NSLog(@"网络故障");
                    [self returnAlert:@"网络故障"];
                }else if (status == 2) {
                    NSLog(@"请求成功返回失败");
                    [self returnAlert:@"请求成功返回失败"];
                }
            }];
        }
    }
}
-(void)cancelAction:(UIButton *)bt {
    NSLog(@"cancel");
    for (UIView* next = [bt superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[CJPayedCell class]]) {
            CJPayedCell *cell = (CJPayedCell *)nextResponder;
            NSIndexPath *index = [_giftTable indexPathForCell:cell];
            CJOrderModel *orderModel = [[CJOrderModel alloc] init];
            orderModel = noPayArray[index.row];
            [CJRequestFormat deleteMobileOrder:orderModel.orderNo finished:^(ResponseStatus status, NSString *response) {
                if (status == 0) {
                    [noPayArray removeObjectAtIndex:index.row];
                    [_giftTable reloadData];
                }else if (status == 1) {
                    NSLog(@"网络故障");
                    [self returnAlert:@"网络故障"];
                }else if (status == 2) {
                    NSLog(@"请求成功返回失败");
                    [self returnAlert:@"请求成功返回失败"];
                }
            }];
        }
    }
}
-(void)payAction:(UIButton *)bt {
    NSLog(@"pay");
}
-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
@end
