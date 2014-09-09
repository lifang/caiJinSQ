//
//  CJInterestingWhyViewController.m
//  CFEC
//
//  Created by SumFlower on 14-9-1.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJInterestingWhyViewController.h"

@interface CJInterestingWhyViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *interestingTextField;
@end

@implementation CJInterestingWhyViewController
@synthesize interestingTextField = _interestingTextField;
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
    self.navigationItem.title = @"感兴趣原因";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _interestingTextField = [[UITextField alloc] init];
    _interestingTextField.frame = CGRectMake(0, 90, 240, 25);
    _interestingTextField.returnKeyType = UIReturnKeyDone;
    _interestingTextField.borderStyle = UITextBorderStyleNone;
    _interestingTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _interestingTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _interestingTextField.leftViewMode = UITextFieldViewModeAlways;
    _interestingTextField.leftView = backView;
    _interestingTextField.placeholder = @"原因";
    _interestingTextField.font = [UIFont systemFontOfSize:14.0f];
    _interestingTextField.delegate = self;
    _interestingTextField.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 250, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    [self.view addSubview:lineView];
    [self.view addSubview:_interestingTextField];
    [_interestingTextField becomeFirstResponder];

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
    if ([self.delegate respondsToSelector:@selector(interestingMessage:)]) {
        [self.delegate interestingMessage:_interestingTextField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField  {
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

@end
