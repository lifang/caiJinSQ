//
//  CJGraduationViewController.m
//  CFEC
//
//  Created by SumFlower on 14-9-1.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJGraduationViewController.h"

@interface CJGraduationViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *graduationTextField;
@end

@implementation CJGraduationViewController
@synthesize graduationTextField = _graduationTextField;
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
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUI {
    self.navigationItem.title = @"毕业时间";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _graduationTextField = [[UITextField alloc] init];
    _graduationTextField.frame = CGRectMake(0, 90, 240, 25);
    _graduationTextField.returnKeyType = UIReturnKeyDone;
    _graduationTextField.borderStyle = UITextBorderStyleNone;
    _graduationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _graduationTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _graduationTextField.leftViewMode = UITextFieldViewModeAlways;
    _graduationTextField.leftView = backView;
    _graduationTextField.placeholder = @"毕业时间";
    _graduationTextField.keyboardType = UIKeyboardTypeNumberPad;
    _graduationTextField.font = [UIFont systemFontOfSize:14.0f];
    _graduationTextField.delegate = self;
    _graduationTextField.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 126, 250, 15)];
    title.font = [UIFont systemFontOfSize:11.0f];
    title.text = @"例如2013年6月30日毕业请输入20130630";
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 250, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    [self.view addSubview:lineView];
    [self.view addSubview:title];
    [self.view addSubview:_graduationTextField];
    [_graduationTextField becomeFirstResponder];
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
    
    NSString *Str = [self becomeStringFromDate];
    
    if ([self.delegate respondsToSelector:@selector(graduationMessage:)]) {
        [self.delegate graduationMessage:Str];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(NSString *)becomeStringFromDate{
    //日期格式转换
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *inputDate = [inputFormatter dateFromString:_graduationTextField.text];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *Str = [formatter stringFromDate:inputDate];
    return Str;
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
