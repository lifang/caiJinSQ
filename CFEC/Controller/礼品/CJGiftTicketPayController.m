//
//  CJGiftTicketPayController.m
//  CFEC
//
//  Created by SumFlower on 14-10-4.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJGiftTicketPayController.h"
#import "CJUserModel.h"
#import "CJAppDelegate.h"
#import "CJRequestFormat.h"
#import "AlixLibService.h"
#import "AlixPayResult.h"
#import "CJCreatePayOrder.h"
#import "PartnerConfig.h"
#import "DataVerifier.h"
@interface CJGiftTicketPayController ()
{
    CJUserModel *user;
}
@property (nonatomic, strong) UILabel *giftTicketLabel;
@property (nonatomic, strong) UIButton *confirmBt;
@end

@implementation CJGiftTicketPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [CJAppDelegate shareCJAppDelegate].user;
    self.navigationItem.title = @"礼品卡支付";
    self.view.backgroundColor = kColor(243, 243, 243, 1);
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 84, 100, 30)];
    label.text = @"礼品卡余额:";
    [self.view addSubview:label];
    _giftTicketLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x + label.frame.size.width, 84, 100, 30)];
    _giftTicketLabel.textColor = [UIColor redColor];
    _giftTicketLabel.text = [NSString stringWithFormat:@"%@",user.giftTicet];
    [self.view addSubview:_giftTicketLabel];
    
    _confirmBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBt.frame = CGRectMake(0, label.frame.origin.y + label.frame.size.height + 20, 320, 44);
    [_confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_confirmBt setTitle:@"确定" forState:UIControlStateNormal];
    _confirmBt.backgroundColor = kColor(93, 201, 16, 1);
    [_confirmBt addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBt];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)confirm:(UIButton *)sender {
    NSString *giftPrice = [NSString stringWithFormat:@"%@",_gift.price];
    int giftTicket = [giftPrice intValue];
    int sumPrice = giftTicket*_count;
    int userGiftTicket = [user.giftTicet intValue];
    int needPay;
    int usedTicket;
    if (userGiftTicket >= sumPrice) {
        needPay = 0;
        usedTicket = sumPrice;
    }else {
        needPay = sumPrice - userGiftTicket;
        usedTicket = userGiftTicket;
    }
    [CJAppDelegate shareCJAppDelegate].user.giftTicet = [NSString stringWithFormat:@"%d",userGiftTicket - userGiftTicket];
    
    NSString *orderStr = [self getOrderNumber];
    NSString *needPayStr = [NSString stringWithFormat:@"%d",needPay];
    NSString *usedTicketStr = [NSString stringWithFormat:@"%d",usedTicket];
    NSString *numberStr = [NSString stringWithFormat:@"%d",_count];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_addressStr forKey:@"p_delivery_address"];
    [dic setObject:_gift.ID forKey:@"p_goodId"];
    [dic setObject:numberStr forKey:@"p_quantity"];
    [dic setObject:@"2" forKey:@"p_flag"];
    [dic setObject:@"0" forKey:@"p_integral"];
    [dic setObject:usedTicketStr forKey:@"p_giftTicket"];
    [dic setObject:@"0" forKey:@"p_coupon"];
    [dic setObject:needPayStr forKey:@"p_total"];
    [dic setObject:[NSString stringWithFormat:@"%@",_gift.price] forKey:@"p_orderAmount"];
    [dic setObject:orderStr forKey:@"order_no"];
    
    NSError *error;
    NSData *dicData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dicStr = [[NSString alloc] initWithData:dicData encoding:NSUTF8StringEncoding];
    
    [CJRequestFormat payInfomationWithUserID:user.email payJson:dicStr finished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            NSLog(@"请求成功");
            if (needPay == 0) {
                [self returnAlert:@"已用礼品卡支付"];
            }else {
            NSError *error;
            NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
            id responseObj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
            if ([responseObj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *responseDic = (NSDictionary *)responseObj;
                if ([[responseDic objectForKey:@"msg"] isEqualToString:@"ok"]) {
                    NSString *orderString = [CJCreatePayOrder createGiftOrderWithGift:_gift
                                                                          countNumber:_count andReducePrice:userGiftTicket];
                    [AlixLibService payOrder:orderString
                                   AndScheme:kAlipayScheme
                                     seletor:@selector(payResult:)
                                      target:self];
                    
                }
            }
            }
        }else if (status == 1) {
            NSLog(@"请检查网络");
            [self returnAlert:@"网络故障"];
        }else if (status == 2) {
            NSLog(@"请求成功，返回失败");
            [self returnAlert:@"服务出错"];
        }
            
    }];
        
    
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
//订单号
-(NSString *)getOrderNumber {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date ]];
    NSString *orderNumber = [NSString stringWithFormat:@"M%@",currentDate];
    return orderNumber;
}
-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

@end
