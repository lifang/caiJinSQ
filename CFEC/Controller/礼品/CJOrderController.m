//
//  CJOrderController.m
//  CFEC
//
//  Created by SumFlower on 14-9-4.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJOrderController.h"
#import "CJTransportAddressController.h"
#import "AlixLibService.h"
#import "AlixPayResult.h"
#import "CJCreatePayOrder.h"
#import "PartnerConfig.h"
#import "DataVerifier.h"

@interface CJOrderController ()<UITableViewDataSource,UITableViewDelegate,sendTansportDelegate>
@property (nonatomic, strong) UITableView *orderTable;
@property (nonatomic, strong) UISwitch *integralSwitch;
@property (nonatomic, strong) UISwitch *giftCardSwitch;
@property (nonatomic, strong) UISwitch *zhiFuBaoSwitch;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UILabel *giftNameLable;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *maxBt;
@property (nonatomic, strong) UIButton *minBt;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *integral;

@property (nonatomic, assign) int number;
@end

@implementation CJOrderController

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
    self.number = 1;
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
-(void)setRightNavBarItemWithImageName:(NSString *)name {
    UIBarButtonItem *rightbt = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStyleBordered target:self action:@selector(address:)];
    rightbt.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightbt;
}
-(void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- CJTransportAddressController代理方法
-(void)sendAddress:(NSDictionary *)dic
{
    //传过来的地址
    NSLog(@"地址");
}

-(void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"确认订单";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self setRightNavBarItemWithImageName:@"收货地址"];
    
    _orderTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _orderTable.delegate = self;
    _orderTable.dataSource = self;
    _orderTable.separatorInset = UIEdgeInsetsMake(0, -2, 0, 2);
    [self.view addSubview:_orderTable];
    _orderTable.tableFooterView = [self footerView];
    _orderTable.tableHeaderView = [self headerView];
}
-(void)address:(id)sender {
    CJTransportAddressController *addressControl = [[CJTransportAddressController alloc] init];
    addressControl.delegate = self;
    [self.navigationController pushViewController:addressControl animated:YES];
}

- (UIView *)headerView {
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 160)];
    backView.layer.cornerRadius = 4;
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:1].CGColor;
    backView.layer.masksToBounds = YES;
    [headview addSubview:backView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 80, 30)];
    label1.font = [UIFont boldSystemFontOfSize:14.0f];
    label1.text = @"商品名称";
    [headview addSubview:label1];
    
    _giftNameLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 210, 30)];
    _giftNameLable.font = [UIFont systemFontOfSize:14.0f];
    _giftNameLable.text = self.giftModel.name;
    [headview addSubview:_giftNameLable];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 80, 30)];
    label2.font = [UIFont boldSystemFontOfSize:14.0f];
    label2.text = @"商品价格";
    [headview addSubview:label2];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 200, 30)];
    _priceLabel.font = [UIFont systemFontOfSize:14.0f];
    float price = [self.giftModel.price floatValue];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f ￥",_number * price];
    [headview addSubview:_priceLabel];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 80, 30)];
    label3.font = [UIFont boldSystemFontOfSize:14.0f];
    label3.text = @"购买数量";
    [headview addSubview:label3];
    
    _maxBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _maxBt.frame = CGRectMake(100, 100, 40, 30);
    _maxBt.backgroundColor = kColor(135, 135, 135, 1);
    [_maxBt setTitle:@"+" forState:UIControlStateNormal];
    [_maxBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_maxBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_maxBt addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    _maxBt.layer.cornerRadius = 8.0f;
    [headview addSubview:_maxBt];
    //数量显示
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, 35, 30)];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.font = [UIFont systemFontOfSize:14.0f];
    _numberLabel.layer.cornerRadius = 10.0f;
    _numberLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _numberLabel.text = [NSString stringWithFormat:@"%d",_number];
    [headview addSubview:_numberLabel];
    _minBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _minBt.frame = CGRectMake(195, 100, 40, 30);
    _minBt.backgroundColor = kColor(135, 135, 135, 1);
    [_minBt setTitle:@"-" forState:UIControlStateNormal];
    [_minBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_minBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_minBt addTarget:self action:@selector(reduce:) forControlEvents:UIControlEventTouchUpInside];
    _minBt.layer.cornerRadius = 8.0f;
    [headview addSubview:_minBt];
    
    UILabel *integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 80, 30)];
    integralLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    integralLabel.text = @"可用积分";
    [headview addSubview:integralLabel];
    
    _integral = [[UILabel alloc] initWithFrame:CGRectMake(100, 140, 30, 30)];
    _integral.font = [UIFont systemFontOfSize:14.0f];
    _integral.text = @"50";
    [headview addSubview:_integral];

    return headview;
}


- (UIView *)footerView {
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame = CGRectMake(0, 30, self.view.frame.size.width, 40);
    _confirmButton.backgroundColor = kColor(228, 77, 40, 1);
    [_confirmButton setTitle:@"使用支付宝支付" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:_confirmButton];
    return footview;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    if (indexPath.row == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 100, 20)];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.text = @"用积分抵用元";
        [cell.contentView addSubview:label];
        
        _integralSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(250, 8, 10, 10)];
        [cell.contentView addSubview:_integralSwitch];
    }else if (indexPath.row == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 150, 20)];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.text = @"用礼品卡进行兑换";
        [cell.contentView addSubview:label];
        
        _giftCardSwitch = [[UISwitch alloc] initWithFrame:_integralSwitch.frame];
        [cell.contentView addSubview:_giftCardSwitch];
    }else {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 100, 20)];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.text = @"用支付宝购买";
        [cell.contentView addSubview:label];
        
        _zhiFuBaoSwitch = [[UISwitch alloc] initWithFrame:_integralSwitch.frame];
        [cell.contentView addSubview:_zhiFuBaoSwitch];
    }
    return cell;
}
-(void)add:(id)sender {
    _number ++;
    _numberLabel.text = [NSString stringWithFormat:@"%d",_number];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f",_number * [_giftModel.price floatValue]];
}
-(void)reduce:(id)sender {
    if (_number >= 1) {
        _number --;
    }
    _numberLabel.text = [NSString stringWithFormat:@"%d",_number];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f",_number * [_giftModel.price floatValue]];
}
-(void)confirm:(id)sender {
    NSString *orderString = [CJCreatePayOrder createGiftOrderWithGift:_giftModel
                                                          countNumber:_number];
    [AlixLibService payOrder:orderString
                   AndScheme:kAlipayScheme
                     seletor:@selector(payResult:)
                      target:self];
}


#pragma mark - 支付结果

- (void)payResult:(NSString *)resultString {
    AlixPayResult *result = [[AlixPayResult alloc] initWithString:resultString];
    if (result) {
        if (result.statusCode == 9000) {
            id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(AlipayPubKey);
			if ([verifier verifyString:result.resultString withSign:result.signString]) {
                //验证签名成功，交易结果无篡改
                NSLog(@"success");
			}
        }
        else if (result.statusCode == 8000) {
            NSLog(@"正在处理");
        }
        else if (result.statusCode == 4000) {
            NSLog(@"支付失败");
        }
        else if (result.statusCode == 6001) {
            NSLog(@"中途取消");
        }
        else if (result.statusCode == 6002) {
            NSLog(@"网络出错");
        }
    }
}

@end
