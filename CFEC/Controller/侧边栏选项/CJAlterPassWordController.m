//
//  CJAlterPassWordController.m
//  CFEC
//
//  Created by SumFlower on 14/10/27.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJAlterPassWordController.h"
#import "CJUserModel.h"
#import "CJAppDelegate.h"
#import "CJRequestFormat.h"
@interface CJAlterPassWordController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    CJUserModel *user;
}
@property (nonatomic ,strong) UIButton *rightButton;
@end

@implementation CJAlterPassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kDevice >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    user = [[CJAppDelegate shareCJAppDelegate] user];
    
    self.navigationItem.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self setRightNavigationItem];
    self.newpwTextfield.delegate = self;
    self.confirmpd.delegate = self;
    self.oldpdTextfield.delegate = self;
    self.oldpdTextfield.tag = 100;
    self.newpwTextfield.tag = 101;
    self.newpwTextfield.secureTextEntry = YES;
    self.confirmpd.secureTextEntry = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setRightNavigationItem {
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(0, 0, 25, 25);
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"save@2x.png"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = right;
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

#pragma mark -- TextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 100) {
        if (![textField.text isEqualToString:user.password]) {
            [self returnAlert:@"旧密码错误请重新输入"];
        }
    }
    if (textField.tag == 101) {
        if ([textField.text isEqualToString:user.password]) {
//            [self returnAlert:@"新密码不能与旧密码相同"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新密码不能与旧密码相同" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            alert.tag = 101;
            [alert show];
        }
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)save:(UIButton *)bt {
    if ([self.oldpdTextfield.text isEqualToString:user.password]) {
        if (self.newpwTextfield.text.length >= 6&&self.confirmpd.text.length <= 16) {
            if ([self.newpwTextfield.text isEqualToString:self.confirmpd.text]) {
                //修改
                [CJRequestFormat ChangeOldPassWord:user.email andOld:self.oldpdTextfield.text andNew:self.newpwTextfield.text finished:^(ResponseStatus status, NSString *response) {
                    if (status == 0) {
                        NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
                        id obj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
                        NSDictionary *dic = (NSDictionary *)obj;
                        if ([[dic objectForKey:@"msg"] isEqualToString:@"ok"]) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码修改成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                            alert.tag = 100;
                            [alert show];
                        }
                    }
                }];
            }else {
                [self returnAlert:@"两次输入的密码不一致"];
            }
        }else {
            [self returnAlert:@"新密码位数不够"];
        }
    }else {
        [self returnAlert:@"旧密码错误请重新输入"];
    }
}
-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (alertView.tag == 101) {
        self.newpwTextfield.text = @"";
        [self.newpwTextfield becomeFirstResponder];
    }
    
}
@end
