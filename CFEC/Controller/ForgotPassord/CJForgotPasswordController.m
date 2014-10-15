//
//  CJForgotPasswordController.m
//  CFEC
//
//  Created by SumFlower on 14-8-20.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJForgotPasswordController.h"
#import "CJRootViewController.h"
#import "CJRequestFormat.h"
@interface CJForgotPasswordController ()<UIAlertViewDelegate>

@end

@implementation CJForgotPasswordController

@synthesize telAndemailTextfield = _telAndemailTextfield;
@synthesize getButton = _getButton;

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
    self.title = @"找回密码";
    self.view.backgroundColor = kColor(234, 234, 234, 1);
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
-(void)initUI {
    //textfiled
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    _telAndemailTextfield = [[UITextField alloc] init];
    _telAndemailTextfield.frame = CGRectMake(0, 107, self.view.frame.size.width, 52);
    _telAndemailTextfield.returnKeyType = UIReturnKeyDone;
    _telAndemailTextfield.borderStyle = UITextBorderStyleNone;
    _telAndemailTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _telAndemailTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _telAndemailTextfield.leftViewMode = UITextFieldViewModeAlways;
    _telAndemailTextfield.leftView = backView;
    _telAndemailTextfield.placeholder = @"输入正确的邮箱地址或手机号";
    _telAndemailTextfield.font = [UIFont systemFontOfSize:13.0f];
    _telAndemailTextfield.delegate = self;
    _telAndemailTextfield.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_telAndemailTextfield];
    
    //button
    _getButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, 45)];
    _getButton.backgroundColor = kColor(93, 201, 16, 1);
    [_getButton setTitle:@"获取新密码" forState:UIControlStateNormal];
    _getButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_getButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_getButton addTarget:self action:@selector(sendInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getButton];
}
#pragma mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)sendInfo:(id)sender {
    NSLog(@"获取新密码");
    if ([_telAndemailTextfield.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮箱或号码不能为空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    [CJRequestFormat findPasswordWithEmail:_telAndemailTextfield.text finished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            NSData *userdate = [response dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:userdate options:NSJSONReadingAllowFragments error:&error];
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary *)jsonObject;
                NSString *s = [dic objectForKey:@"msg"];
                if ([s isEqualToString:@"error"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮箱错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                }else {
                    [self returnAlert:@"密码找回成功,请去邮箱重新填写密码"];
                }
            }
        }else if (status == 1){
            NSLog(@"请求失败");
        }else {
            NSLog(@"请求成功，服务端返回错误");
        }
    }];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    alert.delegate = self;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
