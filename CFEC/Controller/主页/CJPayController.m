//
//  CJPayController.m
//  CFEC
//
//  Created by SumFlower on 14-8-28.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJPayController.h"

@interface CJPayController ()<UITextFieldDelegate>
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
    self.view.backgroundColor = kColor(243, 243, 243, 1);
    self.navigationItem.title = @"活动支付";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
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
    _VIPlevelLabel.text = @"普通会员";
    [self.view addSubview:_VIPlevelLabel];
    UILabel *sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 60, 30)];
    sumLabel.font = [UIFont systemFontOfSize:12.0f];
    sumLabel.text = @"可用积分:";
    [self.view addSubview:sumLabel];
    _sumIntegralLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 110, 60, 30)];
    _sumIntegralLabel.font = [UIFont systemFontOfSize:12.0f];
    _sumIntegralLabel.text = @"50";
    [self.view addSubview:_sumIntegralLabel];
    UILabel *useLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 136, 60, 30)];
    useLabel.font = [UIFont systemFontOfSize:12.0f];
    useLabel.text = @"使用积分:";
    [self.view addSubview:useLabel];
    _useIntegralTextfiled = [[UITextField alloc] initWithFrame:CGRectMake(80, 136, 60, 30)];
    _useIntegralTextfiled.backgroundColor = [UIColor whiteColor];
    _useIntegralTextfiled.delegate = self;
    _useIntegralTextfiled.layer.cornerRadius = 8.0f;
    _useIntegralTextfiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _useIntegralTextfiled.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:_useIntegralTextfiled];
    
    _payBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBt.frame = CGRectMake(0, 206, self.view.frame.size.width, 50);
    _payBt.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _payBt.backgroundColor = kColor(228, 77, 40, 1);
    [_payBt setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [_payBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_payBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
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

@end
