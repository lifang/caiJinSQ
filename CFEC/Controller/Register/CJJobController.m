//
//  CJJobController.m
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJJobController.h"
#import "CJUserModel.h"
#import "CJAppDelegate.h"
#import "CJRequestFormat.h"

@interface CJJobController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *jobTextfield;

@end

@implementation CJJobController
@synthesize jobTextfield = _jobTextfield;
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
    self.title = @"职位";
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
    if ([self.delegate respondsToSelector:@selector(jobMessage:)]) {
        [self.delegate jobMessage:_jobTextfield.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initUI {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _jobTextfield = [[UITextField alloc] init];
    _jobTextfield.frame = CGRectMake(0, 90, 240, 25);
    _jobTextfield.returnKeyType = UIReturnKeyDone;
    _jobTextfield.borderStyle = UITextBorderStyleNone;
    _jobTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _jobTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _jobTextfield.leftViewMode = UITextFieldViewModeAlways;
    _jobTextfield.leftView = backView;
    _jobTextfield.placeholder = @"职位";
    _jobTextfield.font = [UIFont systemFontOfSize:14.0f];
    _jobTextfield.delegate = self;
    _jobTextfield.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 250, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    [self.view addSubview:lineView];
    [self.view addSubview:_jobTextfield];
    [_jobTextfield becomeFirstResponder];
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
    if (_jobTextfield.text.length > 16) {
        [self returnAlert:@"字符太长"];
        return;
    }
    CJUserModel *user = [CJAppDelegate shareCJAppDelegate].user;
    NSData *jsonData;
    NSError *error;
    NSString *jsonStr;
    if (![_jobTextfield.text isEqualToString:@""]) {
        NSMutableDictionary *_commitDic = [NSMutableDictionary dictionary];
//        int camp = [user.camp intValue];
        [CJAppDelegate shareCJAppDelegate].user.position = _jobTextfield.text;
//        if ((camp == 1||camp == 4)) {
//            [_commitDic setObject:user.name forKey:@"name"];
//            [_commitDic setObject:user.companyName forKey:@"companyName"];
            [_commitDic setObject:_jobTextfield.text forKey:@"position"];
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
