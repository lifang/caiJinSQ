//
//  CJTelController.m
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJTelController.h"
#import "CJUserModel.h"
#import "CJAppDelegate.h"
#import "CJRequestFormat.h"

@interface CJTelController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *telTextfield;

@end

@implementation CJTelController

@synthesize telTextfield = _telTextfield;

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
    self.title = @"电话";
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
    if ([self.delegate respondsToSelector:@selector(telMessage:)]) {
        [self.delegate telMessage:_telTextfield.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _telTextfield = [[UITextField alloc] init];
    _telTextfield.frame = CGRectMake(0, 90, 240, 25);
    _telTextfield.returnKeyType = UIReturnKeyDone;
    _telTextfield.borderStyle = UITextBorderStyleNone;
    _telTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _telTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _telTextfield.leftViewMode = UITextFieldViewModeAlways;
    _telTextfield.leftView = backView;
    _telTextfield.placeholder = @"电话";
    _telTextfield.font = [UIFont systemFontOfSize:14.0f];
    _telTextfield.delegate = self;
    _telTextfield.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 250, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    [self.view addSubview:lineView];
    [self.view addSubview:_telTextfield];
    [_telTextfield becomeFirstResponder];
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//验证电话号码
-(BOOL)isValidateTel:(NSString *)tel
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:tel];
    
    return isMatch;
}
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
    CJUserModel *user = [CJAppDelegate shareCJAppDelegate].user;
    NSData *jsonData;
    NSError *error;
    NSString *jsonStr;
    if ([self isValidateTel:_telTextfield.text]) {
        NSMutableDictionary *_commitDic = [NSMutableDictionary dictionary];
        int camp = [user.camp intValue];
        [CJAppDelegate shareCJAppDelegate].user.mobilephone = _telTextfield.text;
        if ((camp == 1||camp == 4)) {
            [_commitDic setObject:user.name forKey:@"name"];
            [_commitDic setObject:user.companyName forKey:@"companyName"];
            [_commitDic setObject:user.position forKey:@"position"];
            [_commitDic setObject:user.companyEmail forKey:@"companyEmail"];
            [_commitDic setObject:_telTextfield.text forKey:@"mobilephone"];
            [_commitDic setObject:user.email forKey:@"email"];
            
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
        }
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号码格式错误" message:@"请重新填写" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];

    }
}
@end
