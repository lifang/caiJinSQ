//
//  CJRegisterController.m
//  CFEC
//
//  Created by SumFlower on 14-8-20.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJRegisterController.h"
#import "CJCampController.h"
#import "CJRequestFormat.h"
#import "CJRegisterServiceController.h"
#import "CJMobileRegisterController.h"
@interface CJRegisterController ()

{
    BOOL isAgree;
    NSString *codeStr;
}

@property (strong, nonatomic) UITableView *showTable;
@property (strong, nonatomic) UISegmentedControl *judgeSegment;
@property (strong, nonatomic) UITextField *telTextfield;
@property (strong, nonatomic) UITextField *identiyTextfield;
@property (strong, nonatomic) UITextField *passwordTextfield;
@property (strong, nonatomic) UITextField *confirmPasswordTextfield;
@property (strong, nonatomic) UITextField *emailAddressTextfield;
@property (strong, nonatomic) UIButton *sendBt;
@end

@implementation CJRegisterController

@synthesize showTable = _showTable;
@synthesize judgeSegment = _judgeSegment;
@synthesize telTextfield = _telTextfield;
@synthesize identiyTextfield = _identiyTextfield;
@synthesize passwordTextfield = _passwordTextfield;
@synthesize confirmPasswordTextfield = _confirmPasswordTextfield;
@synthesize sendBt = _sendBt;
@synthesize emailAddressTextfield = _emailAddressTextfield;

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
    isAgree = NO;//不同意协议
    self.view.backgroundColor = kColor(234, 234, 234, 1);
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    self.title = @"注册";
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
    //tableView
    _showTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _showTable.dataSource = self;
    _showTable.delegate = self;
    _showTable.tableHeaderView = [self setTableViewHead];
    _showTable.tableFooterView = [self setTableViewFoot];
    [self.view addSubview:_showTable];
    //TextField
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    _telTextfield = [[UITextField alloc] init];
    _telTextfield.frame = CGRectMake(0, 0, 240, 52);
    _telTextfield.returnKeyType = UIReturnKeyDone;
    _telTextfield.borderStyle = UITextBorderStyleNone;
    _telTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _telTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _telTextfield.leftViewMode = UITextFieldViewModeAlways;
    _telTextfield.leftView = backView;
    _telTextfield.placeholder = @"输入正确的手机号";
    _telTextfield.font = [UIFont systemFontOfSize:14.0f];
    _telTextfield.delegate = self;
    _telTextfield.backgroundColor = [UIColor whiteColor];
    
    _sendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendBt.frame = CGRectMake(240, 13, 60, 25);
    [_sendBt setTitle:@"发送验证" forState:UIControlStateNormal];
    _sendBt.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    [_sendBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_sendBt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_sendBt addTarget:self action:@selector(senderIdentiy:) forControlEvents:UIControlEventTouchUpInside];
    _sendBt.layer.cornerRadius = 5.0f;
    _sendBt.layer.borderWidth = 0.5f;
    _sendBt.layer.borderColor = [[UIColor blackColor]CGColor];
    
    UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    _identiyTextfield = [[UITextField alloc] init];
    _identiyTextfield.frame = CGRectMake(0, 0, 240, 52);
    _identiyTextfield.returnKeyType = UIReturnKeyDone;
    _identiyTextfield.borderStyle = UITextBorderStyleNone;
    _identiyTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _identiyTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _identiyTextfield.leftViewMode = UITextFieldViewModeAlways;
    _identiyTextfield.leftView = backView1;
    _identiyTextfield.placeholder = @"输入验证码";
    _identiyTextfield.font = [UIFont systemFontOfSize:14.0f];
    _identiyTextfield.delegate = self;
    _identiyTextfield.backgroundColor = [UIColor whiteColor];
    
    UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    _passwordTextfield = [[UITextField alloc] init];
    _passwordTextfield.frame = CGRectMake(0, 0, 240, 52);
    _passwordTextfield.returnKeyType = UIReturnKeyDone;
    _passwordTextfield.borderStyle = UITextBorderStyleNone;
    _passwordTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordTextfield.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextfield.secureTextEntry = YES;
    _passwordTextfield.leftView = backView2;
    _passwordTextfield.placeholder = @"输入密码 6-12 位";
    _passwordTextfield.font = [UIFont systemFontOfSize:14.0f];
    _passwordTextfield.delegate = self;
    _passwordTextfield.backgroundColor = [UIColor whiteColor];
    
    UIView *backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    _confirmPasswordTextfield = [[UITextField alloc] init];
    _confirmPasswordTextfield.frame = CGRectMake(0, 0, 240, 45);
    _confirmPasswordTextfield.returnKeyType = UIReturnKeyDone;
    _confirmPasswordTextfield.borderStyle = UITextBorderStyleNone;
    _confirmPasswordTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _confirmPasswordTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _confirmPasswordTextfield.leftViewMode = UITextFieldViewModeAlways;
    _confirmPasswordTextfield.secureTextEntry = YES;
    _confirmPasswordTextfield.leftView = backView3;
    _confirmPasswordTextfield.placeholder = @"确认密码";
    _confirmPasswordTextfield.font = [UIFont systemFontOfSize:14.0f];
    _confirmPasswordTextfield.delegate = self;
    _confirmPasswordTextfield.backgroundColor = [UIColor whiteColor];
    
    UIView *backView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    _emailAddressTextfield = [[UITextField alloc] init];
    _emailAddressTextfield.frame = CGRectMake(0, 0, self.view.frame.size.width, 45);
    _emailAddressTextfield.returnKeyType = UIReturnKeyDone;
    _emailAddressTextfield.keyboardType = UIKeyboardTypeEmailAddress;
    _emailAddressTextfield.borderStyle = UITextBorderStyleNone;
    _emailAddressTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _emailAddressTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _emailAddressTextfield.leftViewMode = UITextFieldViewModeAlways;
    _emailAddressTextfield.leftView = backView4;
    _emailAddressTextfield.placeholder = @"请输入正确的邮箱地址";
    _emailAddressTextfield.font = [UIFont systemFontOfSize:14.0f];
    _emailAddressTextfield.delegate = self;
    _emailAddressTextfield.backgroundColor = [UIColor whiteColor];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_judgeSegment.selectedSegmentIndex == 0) {
        return 4;
    }else {
        return 3;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_judgeSegment.selectedSegmentIndex == 0) {
        if (indexPath.row == 0 ) {
            static NSString *ID = @"id";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            [cell.contentView addSubview:_telTextfield];
            [cell.contentView addSubview:_sendBt];
            return cell;
        }else if (indexPath.row == 1) {
            static NSString *ID = @"id";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            [cell.contentView addSubview:_identiyTextfield];
            return cell;
        }else if (indexPath.row == 2) {
            static NSString *ID = @"id";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            [cell.contentView addSubview:_passwordTextfield];
            return cell;
        }else if (indexPath.row == 3) {
            static NSString *ID = @"id";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            [cell.contentView addSubview:_confirmPasswordTextfield];
            return cell;
            
        }
    }else {
        if (indexPath.row == 0) {
            static NSString *ID = @"id";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            [cell.contentView addSubview:_emailAddressTextfield];
            return cell;
        }else if (indexPath.row == 1) {
            static NSString *ID = @"id";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            [cell.contentView addSubview:_passwordTextfield];
            return cell;
        }else if (indexPath.row == 2) {
            static NSString *ID = @"id";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            [cell.contentView addSubview:_confirmPasswordTextfield];
            return cell;
        }
    }

    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49.0f;
}
-(UIView *)setTableViewHead {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    NSArray *segArray = [[NSArray alloc] initWithObjects:@"手机注册",@"邮箱注册", nil];
    _judgeSegment = [[UISegmentedControl alloc] initWithItems:segArray];
    _judgeSegment.frame = CGRectMake(86, 8, 150, 32);
    _judgeSegment.tintColor = kColor(93, 201, 16, 1);
    _judgeSegment.selectedSegmentIndex = 1;
    [_judgeSegment addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    [headView addSubview:_judgeSegment];
//    _judgeSegment.hidden = YES;
    return headView;
}
-(UIView *)setTableViewFoot{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    UIButton *rememberBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rememberBt.frame = CGRectMake(40, 30, 16, 16);
    rememberBt.backgroundColor = [UIColor whiteColor];
    [rememberBt addTarget:self action:@selector(remember:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:rememberBt];
    
//    UILabel *rememberLab = [[UILabel alloc] initWithFrame:CGRectMake(55, 22, 200, 32)];
//    rememberLab.text = @"我已阅读并同意相关服务条款";
//    rememberLab.font = [UIFont systemFontOfSize:13.0f];
//    [footView addSubview:rememberLab];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(55, 22, 200, 32);
    bt.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [bt setTitle:@"我已阅读并同意相关服务条款" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [bt addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:bt];
    
    UIButton *completeButton= [UIButton buttonWithType:UIButtonTypeCustom];
    completeButton.frame = CGRectMake(0, 60, 320, 44);
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    completeButton.backgroundColor = kColor(93, 201, 16, 1);
    [completeButton addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:completeButton];

    return footView;
}
-(IBAction)go:(id)sender {
    CJRegisterServiceController *registerC = [[CJRegisterServiceController alloc] init];
    [self.navigationController pushViewController:registerC animated:YES];
}
#pragma mark -segment事件
-(void)segAction:(UISegmentedControl *)segment {
    if (segment.selectedSegmentIndex == 0) {
        NSLog(@"0");
    }else {
        NSLog(@"1");
    }
    _passwordTextfield.text = nil;
    _confirmPasswordTextfield.text = nil;
    [_showTable reloadData];
}
-(void)complete:(id)sender {
    NSLog(@"完成");
    if (_judgeSegment.selectedSegmentIndex == 1) {
        BOOL isEmail = NO;
        isEmail = [self isValidateEmail:_emailAddressTextfield.text];
        if (isEmail) {
            if (_passwordTextfield.text.length >5&&_passwordTextfield.text.length < 13) {
                if ([_passwordTextfield.text isEqualToString:_confirmPasswordTextfield.text]) {
                    if (isAgree) {
                        //注册全部判断成功,数据请求
                        [CJRequestFormat registerWithEmail:_emailAddressTextfield.text password:_passwordTextfield.text finished:^(ResponseStatus status, NSString *response) {
                            if (status == 0) {
                                NSData *userdate = [response dataUsingEncoding:NSUTF8StringEncoding];
                                NSError *error;
                                id jsonObject = [NSJSONSerialization JSONObjectWithData:userdate options:NSJSONReadingAllowFragments error:&error];
                                if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                                    NSDictionary *dic = (NSDictionary *)jsonObject;
                                    NSString *msg = [dic objectForKey:@"msg"];
                                    if ([msg isEqualToString:@"ok"]) {
                                        //注册成功
                                        CJCampController *campControl = [[CJCampController alloc] init];
                                        //传注册的email
                                        campControl.registerEmail = _emailAddressTextfield.text;
                                        [self.navigationController pushViewController:campControl animated:YES];
                                    }else {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮箱已注册" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                        [alert show];
                                    }
                                }
                            }else if (status == 1) {
//                                NSLog(@"请求出错");
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络不稳定请重新尝试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                [alert show];
                            }else {
//                                NSLog(@"请求成功，返回错误");
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络返回错误请重新尝试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                [alert show];
                            }
                        }];
                    }else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未同意协议" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [alert show];
//                        NSLog(@"不同意协议");
                    }
                }else {
//                    NSLog(@"密码不一致");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码不一致" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                }
            }else {
//                NSLog(@"密码位数不对");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码位数不对" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }else {
//            NSLog(@"邮箱错误");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮箱格式错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }

    }else {
        NSLog(@"功能不明确");
    }
    if (_judgeSegment.selectedSegmentIndex == 0) {
        NSLog(@"手机注册");
        if (![_identiyTextfield.text isEqualToString:@""]) {
            int intcode = [_identiyTextfield.text intValue];
            int intcodestr = [codeStr intValue];
            if (intcode == intcodestr) {
                if (_passwordTextfield.text.length > 5&&_passwordTextfield.text.length < 13) {
                    if ([_passwordTextfield.text isEqualToString:_confirmPasswordTextfield.text]) {
                        if (isAgree) {
                            //
                            CJMobileRegisterController *mobileC = [[CJMobileRegisterController alloc] init];
                            mobileC.phoneNumber = _telTextfield.text;
                            mobileC.password = _passwordTextfield.text;
                            [self.navigationController pushViewController:mobileC animated:YES];
                        }else {
                            [self returnAlert:@"未同意协议"];
                        }
                    }else {
                        [self returnAlert:@"密码不一致"];
                    }
                }else {
                    [self returnAlert:@"密码位数不对"];
                }
            }else {
                [self returnAlert:@"请输入正确的验证码"];
            }
        }else {
            [self returnAlert:@"请输入验证码"];
        }
    }
    
}
-(void)senderIdentiy:(id)sender {
    if ([self isValidateTel:_telTextfield.text]) {
        [CJRequestFormat getCodeWithPhoneNumber:_telTextfield.text finished:^(ResponseStatus status, NSString *response) {
            if (status == 0) {
                NSError *error;
                NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
                id responseObj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
                NSDictionary *dic = (NSDictionary *)responseObj;
                codeStr = [NSString string];
                codeStr = [dic objectForKey:@"mobile_code"];
            }else if (status == 1) {
                [self returnAlert:@"网络故障"];
            }else if (status == 2) {
                NSLog(@"网络请求成功,返回失败");
            }
        }];
    }else {
        [self returnAlert:@"请输入正确的手机号"];
    }
}
-(void)remember:(id)sender {
    //读取用户信息
    UIButton *bt = (UIButton *)sender;
    if (isAgree) {
        isAgree = NO;
        [bt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else {
        [bt setBackgroundImage:[UIImage imageNamed:@"登录_03-11@2x.png"] forState:UIControlStateNormal];
        isAgree = YES;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
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
-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
@end
