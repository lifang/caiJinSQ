//
//  CJMobileRegisterController.m
//  CFEC
//
//  Created by SumFlower on 14-10-11.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJMobileRegisterController.h"
#import "CJRequestFormat.h"
@interface CJMobileRegisterController ()<UITextFieldDelegate,UIAlertViewDelegate>
@end

@implementation CJMobileRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(234, 234, 234, 1);
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    self.title = @"手机注册";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)initUI {
    UIButton *getinBt = [UIButton buttonWithType:UIButtonTypeCustom];
    getinBt.frame = CGRectMake(0, _emailField.frame.origin.y + _emailField.frame.size.height + 40, self.view.frame.size.width, 44);
    [getinBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getinBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [getinBt setTitle:@"提交" forState:UIControlStateNormal];
    getinBt.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [getinBt addTarget:self action:@selector(getIn:) forControlEvents:UIControlEventTouchUpInside];
    getinBt.backgroundColor = kColor(93, 201, 16, 1);
    [self.view addSubview:getinBt];
    
    _nameField.delegate = self;
    _positionField.delegate = self;
    _companyField.delegate = self;
    _emailField.delegate = self;
}
-(void)getIn:(UIButton *)bt {
    
    if (![_nameField.text isEqualToString:@""]) {
        if (![_positionField.text isEqualToString:@""]) {
            if (![_companyField.text isEqualToString:@""]) {
                if ([self isValidateEmail:_emailField.text]) {
                    [self submitInfo];
                }else {
                    [self returnAlert:@"请输入正确的邮箱号码"];
                }
            }else {
                [self returnAlert:@"公司名称不能为空"];
            }
        }else {
            [self returnAlert:@"职位不能为空"];
        }
    }else {
        [self returnAlert:@"姓名不能为空"];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
-(void)submitInfo {
    NSString *phoneNumber = _phoneNumber;
    NSString *password = _password;
    NSString *email = _emailField.text;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_nameField.text forKey:@"nickname"];
    [dic setObject:_positionField.text forKey:@"position"];
    [dic setObject:_companyField.text forKey:@"companyName"];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [CJRequestFormat registerByMobilephoneLast:phoneNumber andPassword:password andEmail:email andUserInfo:jsonStr finished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            NSLog(@"请求成功");
            NSError *error;
            NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
            id resppnseObj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dic = (NSDictionary *)resppnseObj;
            if ([[dic objectForKey:@"msg"] isEqualToString:@"ok"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                alert.tag = 1;
                [alert show];
            }
        }else if (status == 1) {
            NSLog(@"网络故障");
            [self returnAlert:@"网络故障"];
        }else if (status == 2) {
            NSLog(@"请求成功,返回失败");
        }
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
