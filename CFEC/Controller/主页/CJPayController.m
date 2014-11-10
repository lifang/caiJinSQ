//
//  CJPayController.m
//  CFEC
//
//  Created by SumFlower on 14-8-28.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJPayController.h"
#import "CJUserModel.h"
#import "CJAppDelegate.h"
#import "CJRequestFormat.h"
#import "AlixLibService.h"
#import "AlixPayResult.h"
#import "CJCreatePayOrder.h"
#import "PartnerConfig.h"
#import "DataVerifier.h"

@interface CJPayController ()<UITextFieldDelegate>
{
    CJUserModel *user;
}
@property (nonatomic, strong) UILabel *VIPlevelLabel;//会员等级
@property (nonatomic, strong) UILabel *sumIntegralLabel;//总积分
@property (nonatomic, strong) UITextField *useIntegralTextfiled;//使用积分
@property (nonatomic, strong) UIButton *payBt;//支付宝支付
@end

@implementation CJPayController
@synthesize VIPlevelLabel = _VIPlevelLabel;
@synthesize sumIntegralLabel = _sumIntegralLabel;
@synthesize useIntegralTextfiled = _useIntegralTextfiled;
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
    user = [CJAppDelegate shareCJAppDelegate].user;
    self.view.backgroundColor = kColor(243, 243, 243, 1);
    self.navigationItem.title = @"活动支付";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    // Do any additional setup after loading the view.
}
-(void)valueChange:(NSNotification *)notification
{
    
    int reducePrice = [self returnPrice];
    
    int userSumIntegral = [user.integral intValue];
    
    int userPrintIntergal = [_useIntegralTextfiled.text intValue];
    
    int intrgral;
    
    if (reducePrice >= userSumIntegral) {
        if (userPrintIntergal <= userSumIntegral) {
            intrgral = userPrintIntergal;
        }else {
            intrgral = userSumIntegral;
        }
    }else {
        if (userPrintIntergal <= reducePrice) {
            intrgral = userPrintIntergal;
        }else {
            intrgral = reducePrice;
        }
    }
    
    _useIntegralTextfiled.text = [NSString stringWithFormat:@"%d",intrgral];

    
    if (userPrintIntergal <= 0) {
        _useIntegralTextfiled.text = @"";
    }
    
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
    UILabel *level = [[UILabel alloc] initWithFrame:CGRectMake(20, 84, 60, 30)];
    level.font = [UIFont systemFontOfSize:12.0f];
    level.text = @"会员等级:";
    [self.view addSubview:level];
    _VIPlevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 84, 60, 30)];
    _VIPlevelLabel.font = [UIFont systemFontOfSize:12.0f];
    _VIPlevelLabel.text = [self returnMemberType];
    [self.view addSubview:_VIPlevelLabel];
    UILabel *sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 60, 30)];
    sumLabel.font = [UIFont systemFontOfSize:12.0f];
    sumLabel.text = @"可用积分:";
    [self.view addSubview:sumLabel];
    _sumIntegralLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 110, 60, 30)];
    _sumIntegralLabel.font = [UIFont systemFontOfSize:12.0f];
    NSString *userIntegral = [NSString stringWithFormat:@"%@",user.integral];
    _sumIntegralLabel.text = userIntegral;
    [self.view addSubview:_sumIntegralLabel];
    
    UILabel *canUse = [[UILabel alloc] initWithFrame:CGRectMake(20, 136, 200, 30)];
    canUse.font = [UIFont systemFontOfSize:12.0f];
    int price = [self returnPrice];
    canUse.text = [NSString stringWithFormat:@"当前活动可用积分: %d",price];
    [self.view addSubview:canUse];
    
    UILabel *useLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 136 + 26, 60, 30)];
    useLabel.font = [UIFont systemFontOfSize:12.0f];
    useLabel.text = @"使用积分:";
    [self.view addSubview:useLabel];
    _useIntegralTextfiled = [[UITextField alloc] initWithFrame:CGRectMake(80, 136 + 26, 60, 30)];
    _useIntegralTextfiled.backgroundColor = [UIColor whiteColor];
    _useIntegralTextfiled.delegate = self;
//    _useIntegralTextfiled.text = @"0";
    _useIntegralTextfiled.layer.cornerRadius = 8.0f;
    _useIntegralTextfiled.keyboardType = UIKeyboardTypeNumberPad;
    _useIntegralTextfiled.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:_useIntegralTextfiled];
    
    _payBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBt.frame = CGRectMake(0, 206, self.view.frame.size.width, 50);
    _payBt.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _payBt.backgroundColor = kColor(228, 77, 40, 1);
    [_payBt setTitle:@"确认支付" forState:UIControlStateNormal];
    [_payBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_payBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_payBt addTarget:self action:@selector(payNow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payBt];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
-(IBAction)payNow:(UIButton *)sender {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *orderNumber = [self getOrderNumber];
    int sumPrice = [self getSumPrice:_count andPrice:_activityModel.meetingCost];
    int userPrintIntegral;
    if ([_useIntegralTextfiled.text isEqualToString:@""]) {
        userPrintIntegral = 0;
    }else {
        userPrintIntegral = [_useIntegralTextfiled.text intValue];
    }
    
    int userIntrgral = [user.integral intValue];
    [CJAppDelegate shareCJAppDelegate].user.integral = [NSString stringWithFormat:@"%d",userIntrgral - userPrintIntegral];
    
    int shouldPay = sumPrice - userPrintIntegral;
    NSString *numberStr = [NSString stringWithFormat:@"%d",_count];
    NSString *shouldPayStr = [NSString stringWithFormat:@"%d",shouldPay];
//    NSString *name = [NSString stringWithFormat:@"%@",user.name];
//    NSString *companyStr = [NSString stringWithFormat:@"%@",user.companyName];
    
    [dic setObject:user.userId forKey:@"userId"];
    [dic setObject:orderNumber forKey:@"orderNo"];
    [dic setObject:_activityModel.ID forKey:@"activityId"];
    [dic setObject:_activityModel.title forKey:@"activityDescribe"];
    [dic setObject:_activityModel.title forKey:@"activityName"];
    [dic setObject:_name forKey:@"name"];
    [dic setObject:_email forKey:@"email"];
    [dic setObject:_phone forKey:@"telephone"];
    [dic setObject:_companyName forKey:@"companyName"];
    [dic setObject:_activityModel.meetingCost forKey:@"price"];
    [dic setObject:shouldPayStr forKey:@"orderAmount"];
    [dic setObject:numberStr forKey:@"quantity"];
    
    NSError *error;
    NSData *dicData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dicStr = [[NSString alloc] initWithData:dicData encoding:NSUTF8StringEncoding];
    
    [CJRequestFormat createOrderWithOrderJson:dicStr finished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            NSLog(@"请求成功");
            if (shouldPay == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"已报名" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }else {
                NSString *orderString = [CJCreatePayOrder createActivityOrderWithActivity:_activityModel
                                                                              countNumber:_count andReducePrice:userPrintIntegral];
                [AlixLibService payOrder:orderString
                               AndScheme:kAlipayScheme
                                 seletor:@selector(payResult:)
                                  target:self];

            }
        }else if (status == 1) {
            NSLog(@"网络请求出错");
            [self returnAlert:@"网络故障"];
        }else if (status == 2) {
            NSLog(@"服务出错");
        }
    }];
}
-(int)canReduceMoney:(int)goodPrice andGoodCount:(int)number andUser:(CJUserModel *)userModel {
    int memberType = [[NSString stringWithFormat:@"%@",userModel.memberType] intValue];
    int sumPrice = goodPrice * number;
    if (memberType == 0) {
        return 0;
    }else if (memberType == 1) {
        if (sumPrice <= 50) {
            return 0;
        }else if (sumPrice > 50&&sumPrice <= 1000) {
            return sumPrice * 0.4;
        }else if (sumPrice > 1000&& sumPrice <= 3000) {
            return sumPrice * 0.3;
        }else if (sumPrice > 3000&&sumPrice <= 6000) {
            return sumPrice * 0.2;
        }else  {
            return sumPrice * 0.1;
        }
    }else if (memberType == 2) {
        if (sumPrice <= 50) {
            return 0;
        }else if (sumPrice > 50&&sumPrice <= 1000) {
            return sumPrice * 0.5;
        }else if (sumPrice > 1000&& sumPrice <= 3000) {
            return sumPrice * 0.4;
        }else if (sumPrice > 3000&&sumPrice <= 6000) {
            return sumPrice * 0.3;
        }else {
            return sumPrice * 0.2;
        }
    }else if (memberType == 3) {
        if (sumPrice <= 50) {
            return 0;
        }else if (sumPrice > 50&&sumPrice <= 1000) {
            return sumPrice * 0.6;
        }else if (sumPrice > 1000&& sumPrice <= 3000) {
            return sumPrice * 0.5;
        }else if (sumPrice > 3000&&sumPrice <= 6000) {
            return sumPrice * 0.4;
        }else {
            return sumPrice * 0.3;
        }
    }else {
        if (sumPrice <= 50) {
            return 0;
        }else if (sumPrice > 50&&sumPrice <= 1000) {
            return sumPrice * 0.8;
        }else if (sumPrice > 1000&& sumPrice <= 3000) {
            return sumPrice * 0.7;
        }else if (sumPrice > 3000&&sumPrice <= 6000) {
            return sumPrice * 0.6;
        }else {
            return sumPrice * 0.5;
        }
    }
}
//未打折前的价格
-(int)getSumPrice:(int)count andPrice:(NSString *)price {
    int onePrice = [price intValue];
    int allPrice = count * onePrice;
    return allPrice;
}
-(int)returnPrice {
    NSString *priceStr = [NSString stringWithFormat:@"%@",self.activityModel.meetingCost];
    int price = [priceStr intValue];
    int redecePrice = [self canReduceMoney:price andGoodCount:self.count andUser:user];
    return redecePrice;
}
//订单号
-(NSString *)getOrderNumber {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date ]];
    NSString *orderNumber = [NSString stringWithFormat:@"M%@",currentDate];
    return orderNumber;
}
//判断会员等级
-(NSString *)returnMemberType {
    NSString *memberTypeStr = [NSString stringWithFormat:@"%@",user.memberType];
    int memberType = [memberTypeStr intValue];
    NSString *str;
    if (memberType == 0) {
        str = @"游客";
    }else if (memberType == 1) {
        str = @"普通会员";
    }else if (memberType == 2) {
        str  = @"黄金会员";
    }else if (memberType == 3) {
        str = @"白金会员";
    }else {
        str = @"钻石会员";
    }
    return str;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
                [self returnAlert:@"交易成功"];
            }
        }
        else if (result.statusCode == 8000) {
            NSLog(@"正在处理");
            [self returnAlert:@"正在处理"];
        }
        else if (result.statusCode == 4000) {
            NSLog(@"支付失败");
            [self returnAlert:@"支付失败"];
        }
        else if (result.statusCode == 6001) {
            NSLog(@"中途取消");
            [self returnAlert:@"中途取消"];
        }
        else if (result.statusCode == 6002) {
            NSLog(@"网络出错");
            [self returnAlert:@"网络出错"];
        }

    }
}

-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

@end
