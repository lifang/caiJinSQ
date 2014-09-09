//
//  CJTelController.m
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJTelController.h"

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
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![self isValidateTel:textField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号码格式错误" message:@"请重新填写" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
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
