//
//  CJFindWithPhoneController.m
//  CFEC
//
//  Created by SumFlower on 14/11/4.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJFindWithPhoneController.h"
#import "CJInputPassWordControllerViewController.h"

@interface CJFindWithPhoneController ()<UITextFieldDelegate>
@property (strong, nonatomic) UIButton *getButton;
@property (strong, nonatomic) UITextField *codeTextfield;

@end

@implementation CJFindWithPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kDevice >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationItem.title = @"找回密码";
    [self initUI];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];

    // Do any additional setup after loading the view from its nib.
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
-(void)initUI
{

    self.codeTextfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 45)];
    self.codeTextfield.placeholder = @"请输入验证码";
    self.codeTextfield.delegate = self;
    self.codeTextfield.textAlignment = NSTextAlignmentCenter;
    self.codeTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTextfield.returnKeyType = UIReturnKeyDone;
    self.codeTextfield.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.codeTextfield];
    
    
    //button
    _getButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _codeTextfield.frame.origin.y + _codeTextfield.frame.size.height + 30, self.view.frame.size.width, 45)];
    _getButton.backgroundColor = kColor(93, 201, 16, 1);
    [_getButton setTitle:@"确认验证码" forState:UIControlStateNormal];
    _getButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_getButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_getButton addTarget:self action:@selector(sendInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getButton];
}
-(IBAction)sendInfo:(id)sender
{
    //
    NSString *code = [NSString stringWithFormat:@"%@",_code];
    [_codeTextfield resignFirstResponder];
    NSString *inputStr = _codeTextfield.text;

    if ([inputStr isEqualToString:code]) {
        
        CJInputPassWordControllerViewController *inputC = [[CJInputPassWordControllerViewController alloc] initWithNibName:@"CJInputPassWordControllerViewController" bundle:nil];
        inputC.phone = self.phone;
        [self.navigationController pushViewController:inputC animated:YES];
    }else {
        [self returnAlert:@"验证码不正确"];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    alert.delegate = self;
    [alert show];
}

@end
