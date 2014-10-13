//
//  CJCompanyController.m
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJCompanyController.h"
#import "CJUserModel.h"
#import "CJAppDelegate.h"
#import "CJRequestFormat.h"

@interface CJCompanyController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *companyTextfield;

@end
@implementation CJCompanyController
@synthesize companyTextfield = _companyTextfield;

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
    self.title = @"公司";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self initUI];
    self.view.backgroundColor = [UIColor whiteColor];

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
    if ([self.delegate respondsToSelector:@selector(companyMessage:)]) {
        [self.delegate companyMessage:_companyTextfield.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initUI {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _companyTextfield = [[UITextField alloc] init];
    _companyTextfield.frame = CGRectMake(0, 90, 240, 25);
    _companyTextfield.returnKeyType = UIReturnKeyDone;
    _companyTextfield.borderStyle = UITextBorderStyleNone;
    _companyTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _companyTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _companyTextfield.leftViewMode = UITextFieldViewModeAlways;
    _companyTextfield.leftView = backView;
    _companyTextfield.placeholder = @"公司";
    _companyTextfield.font = [UIFont systemFontOfSize:14.0f];
    _companyTextfield.delegate = self;
    _companyTextfield.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 250, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    [self.view addSubview:lineView];
    [self.view addSubview:_companyTextfield];
    [_companyTextfield becomeFirstResponder];
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
-(void)setIsShow:(BOOL)isShow
{
    if (isShow) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(0, 0, 25, 25);
        [rightButton setBackgroundImage:[UIImage imageNamed:@"save@2x.png"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = right;
    }
    
}
-(void)save:(id)sender {
    if (_companyTextfield.text.length > 16) {
        [self returnAlert:@"输入字符太长"];
        return;
    }

    CJUserModel *user = [CJAppDelegate shareCJAppDelegate].user;
    NSData *jsonData;
    NSError *error;
    NSString *jsonStr;
    if (![_companyTextfield.text isEqualToString:@""]) {
        NSMutableDictionary *_commitDic = [NSMutableDictionary dictionary];
//        int camp = [user.camp intValue];
        [CJAppDelegate shareCJAppDelegate].user.companyName = _companyTextfield.text;
//        if ((camp == 1||camp == 4)) {
//            [_commitDic setObject:user.name forKey:@"name"];
            [_commitDic setObject:_companyTextfield.text forKey:@"companyName"];
//            [_commitDic setObject:user.position forKey:@"position"];
//            [_commitDic setObject:user.companyEmail forKey:@"companyEmail"];
//            [_commitDic setObject:user.mobilephone forKey:@"mobilephone"];
//            [_commitDic setObject:user.email forKey:@"email"];
        
            jsonData = [NSJSONSerialization dataWithJSONObject:_commitDic options:NSJSONWritingPrettyPrinted error:&error];
            jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            [CJRequestFormat modifyUserInformationWithUserID:user.userId userJson:jsonStr finished:^(ResponseStatus status, NSString *response) {
                if (status == 0) {
                    NSLog(@"保存成功");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                }else if (status == 1) {
                    NSLog(@"请求失败");
                }else {
                    NSLog(@"返回失败");
                }
            }];
//        }
        }else {
            NSLog(@"不能为空");
        }
}
-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

@end
