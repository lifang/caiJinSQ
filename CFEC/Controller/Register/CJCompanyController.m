//
//  CJCompanyController.m
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJCompanyController.h"

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
    _companyTextfield.placeholder = @"德胜集团";
    _companyTextfield.font = [UIFont systemFontOfSize:14.0f];
    _companyTextfield.delegate = self;
    _companyTextfield.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 250, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    [self.view addSubview:lineView];
    [self.view addSubview:_companyTextfield];
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
