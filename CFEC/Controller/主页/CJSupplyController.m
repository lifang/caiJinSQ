//
//  CJSupplyController.m
//  CFEC
//
//  Created by SumFlower on 14-8-27.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJSupplyController.h"
#import "CJPayController.h"
#import "CJSupplyCell.h"
#import "CJAppDelegate.h"
#import "AlixLibService.h"
#import "AlixPayResult.h"
#import "CJCreatePayOrder.h"
#import "PartnerConfig.h"
#import "DataVerifier.h"

@interface CJSupplyController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *supplyTable;
@property (nonatomic, strong) UILabel *activityNameLable;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIButton *maxBt;//增加
@property (nonatomic, strong) UIButton *minBt;//减少
@property (nonatomic, strong) UIButton *payBt;//支付
@property (nonatomic ,strong) UITextField *infoTextField;
@property (nonatomic ,strong) UITextField *infoTelTextField;
@property (nonatomic ,strong) UITextField *infoEmailTextField;
@property (nonatomic ,strong) UITextField *infoCompanyTextField;
@property (nonatomic) int number;//数量
@end

@implementation CJSupplyController
@synthesize supplyTable = _supplyTable;
@synthesize activityNameLable = _activityNameLable;
@synthesize priceLabel = _priceLabel;
@synthesize numberLabel = _numberLabel;
@synthesize maxBt = _maxBt;
@synthesize minBt = _minBt;
@synthesize payBt = _payBt;
@synthesize number = _number;
@synthesize activity = _activity;
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
    self.navigationItem.title = @"报名";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    self.number = 1;
    [self initUI];
    _user = [CJAppDelegate shareCJAppDelegate].user;
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
    _supplyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _supplyTable.delegate = self;
    _supplyTable.dataSource = self;
    _supplyTable.backgroundColor = kColor(234, 234, 234, 1);
    [self.view addSubview:_supplyTable];
    
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
    static NSString *first = @"first";
    CJSupplyCell *cell = [[CJSupplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:first];
    
    _infoTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, cell.contentView.frame.size.width - 80, 30)];
    _infoTextField.textAlignment = NSTextAlignmentRight;
    _infoTextField.font = [UIFont systemFontOfSize:13.0f];
    [cell.contentView addSubview:_infoTextField];
    _infoTextField.hidden = YES;
    _infoTextField.delegate = self;

    _infoTelTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, cell.contentView.frame.size.width - 80, 30)];
    _infoTelTextField.textAlignment = NSTextAlignmentRight;
    _infoTelTextField.font = [UIFont systemFontOfSize:13.0f];
    [cell.contentView addSubview:_infoTelTextField];
    _infoTelTextField.hidden = YES;
    _infoTelTextField.delegate = self;
    
    _infoEmailTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, cell.contentView.frame.size.width - 80, 30)];
    _infoEmailTextField.textAlignment = NSTextAlignmentRight;
    _infoEmailTextField.font = [UIFont systemFontOfSize:13.0f];
    [cell.contentView addSubview:_infoEmailTextField];
    _infoEmailTextField.hidden = YES;
    _infoEmailTextField.delegate = self;

    _infoCompanyTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, cell.contentView.frame.size.width - 80, 30)];
    _infoCompanyTextField.textAlignment = NSTextAlignmentRight;
    _infoCompanyTextField.font = [UIFont systemFontOfSize:13.0f];
    [cell.contentView addSubview:_infoCompanyTextField];
    _infoCompanyTextField.hidden = YES;
    _infoCompanyTextField.delegate = self;

    
    if (indexPath.row == 0) {
        cell.infoName.text = @"姓名";
        _infoTextField.hidden = NO;
        _infoTextField.text = self.user.name;
    }else if (indexPath.row == 1) {
        cell.infoName.text = @"联系电话";
        _infoTelTextField.hidden = NO;
        _infoTelTextField.text = self.user.mobilephone;
    }else if (indexPath.row == 2) {
        cell.infoName.text = @"电子邮箱";
        _infoEmailTextField.hidden = NO;
        _infoEmailTextField.text = self.user.email;
    }else if (indexPath.row == 3) {
        cell.infoName.text = @"公司名称";
        _infoCompanyTextField.hidden = NO;
        _infoCompanyTextField.text = self.user.companyName;
    }
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] init];
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, 280, 50)];
    textview.textAlignment = NSTextAlignmentLeft;
    textview.text = [NSString stringWithFormat:@"您正在参加%@活动，请确认您的个人信息",_activity.title];
    textview.backgroundColor = [UIColor clearColor];
    textview.userInteractionEnabled = NO;
    [headView addSubview:textview];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footview = [[UIView alloc]init];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 80, 30)];
    label1.font = [UIFont boldSystemFontOfSize:14.0f];
    label1.text = @"活动名称:";
    [footview addSubview:label1];
    
    _activityNameLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 210, 30)];
    _activityNameLable.font = [UIFont systemFontOfSize:14.0f];
    _activityNameLable.text = _activity.title;
    [footview addSubview:_activityNameLable];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 80, 30)];
    label2.font = [UIFont boldSystemFontOfSize:14.0f];
    label2.text = @"活动价格";
    [footview addSubview:label2];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 200, 30)];
    _priceLabel.font = [UIFont systemFontOfSize:14.0f];
    float price = [_activity.meetingCost floatValue];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f ￥",_number * price];
    [footview addSubview:_priceLabel];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 80, 30)];
    label3.font = [UIFont boldSystemFontOfSize:14.0f];
    label3.text = @"购买数量";
    [footview addSubview:label3];
    
    _maxBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _maxBt.frame = CGRectMake(100, 100, 40, 30);
    _maxBt.backgroundColor = kColor(135, 135, 135, 1);
    [_maxBt setTitle:@"+" forState:UIControlStateNormal];
    [_maxBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_maxBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_maxBt addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    _maxBt.layer.cornerRadius = 8.0f;
    [footview addSubview:_maxBt];
    //数量显示
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, 35, 30)];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.font = [UIFont systemFontOfSize:14.0f];
    _numberLabel.layer.cornerRadius = 10.0f;
    _numberLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _numberLabel.text = [NSString stringWithFormat:@"%d",_number];
    [footview addSubview:_numberLabel];
    _minBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _minBt.frame = CGRectMake(195, 100, 40, 30);
    _minBt.backgroundColor = kColor(135, 135, 135, 1);
    [_minBt setTitle:@"-" forState:UIControlStateNormal];
    [_minBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_minBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_minBt addTarget:self action:@selector(reduce:) forControlEvents:UIControlEventTouchUpInside];

    _minBt.layer.cornerRadius = 8.0f;
    [footview addSubview:_minBt];
    //支付
    _payBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBt.frame = CGRectMake(0, 150, self.view.frame.size.width, 40);
    _payBt.backgroundColor = kColor(228, 77, 40, 1);
    [_payBt setTitle:@"去支付" forState:UIControlStateNormal];
    [_payBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_payBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_payBt addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:_payBt];
    return footview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  300.0f;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)add:(id)sender {
    _number ++;
    _numberLabel.text = [NSString stringWithFormat:@"%d",_number];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f ￥",_number * [_activity.meetingCost floatValue]];
}
-(void)reduce:(id)sender {
    if (_number > 1) {
        _number --;
    }
    _numberLabel.text = [NSString stringWithFormat:@"%d",_number];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f ￥",_number * [_activity.meetingCost floatValue]];
}
-(void)pay:(id)sender {
    CJPayController *payControl = [[CJPayController alloc] init];
    payControl.activityModel = self.activity;
    payControl.count = _number;
    if ([_infoTextField.text isEqualToString:@""]) {
        [self returnAlert:@"姓名不能为空"];
        return;
    }else {
        payControl.name = _infoTextField.text;
    }
    if (![self isValidateTel:_infoTelTextField.text]) {
        [self returnAlert:@"电话号码不正确"];
        return;
    }else {
        payControl.phone = _infoTelTextField.text;
    }
    if (![self isValidateEmail:_infoEmailTextField.text]) {
        [self returnAlert:@"邮箱不正确"];
        return;
    }else {
        payControl.email = _infoEmailTextField.text;
    }
    if ([_infoCompanyTextField.text isEqualToString:@""]) {
        [self returnAlert:@"公司名称不能为空"];
        return;
    }else {
        payControl.companyName = _infoCompanyTextField.text;
    }
    
    [self.navigationController pushViewController:payControl animated:YES];
//    NSString *orderString = [CJCreatePayOrder createActivityOrderWithActivity:_activity
//                                                                  countNumber:_number];
//    [AlixLibService payOrder:orderString
//                   AndScheme:kAlipayScheme
//                     seletor:@selector(payResult:)
//                      target:self];
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


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
//判断邮箱格式是否正确
- (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}
//验证电话号码
-(BOOL)isValidateTel:(NSString *)tel
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:tel];
    
    return isMatch;
}
@end
