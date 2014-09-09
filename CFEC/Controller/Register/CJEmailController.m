//
//  CJEmailController.m
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJEmailController.h"

@interface CJEmailController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *emailTextfield;

@end

@implementation CJEmailController
@synthesize emailTextfield = _emailTextfield;
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
    self.title = @"邮箱";
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
    
    if (![self isValidateEmail:_emailTextfield.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮箱格式错误" message:@"请重新填写" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else {
        if ([self.delegate respondsToSelector:@selector(emailMessage:)]) {
            [self.delegate emailMessage:_emailTextfield.text];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)initUI {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _emailTextfield = [[UITextField alloc] init];
    _emailTextfield.frame = CGRectMake(0, 90, 240, 25);
    _emailTextfield.returnKeyType = UIReturnKeyDone;
    _emailTextfield.borderStyle = UITextBorderStyleNone;
    _emailTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _emailTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _emailTextfield.leftViewMode = UITextFieldViewModeAlways;
    _emailTextfield.leftView = backView;
    _emailTextfield.placeholder = @"邮箱";
    _emailTextfield.font = [UIFont systemFontOfSize:14.0f];
    _emailTextfield.delegate = self;
    _emailTextfield.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 250, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    [self.view addSubview:lineView];
    [self.view addSubview:_emailTextfield];
    [_emailTextfield becomeFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
//判断邮箱格式是否正确
- (BOOL)isValidateEmail:(NSString *)email{
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
        return [emailTest evaluateWithObject:email];
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
