//
//  CJNameController.m
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJNameController.h"

@interface CJNameController ()

@property (nonatomic, strong) UITextField *nameTextfield;

@end
@implementation CJNameController

@synthesize nameTextfield = _nameTextfield;

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
    self.title = @"姓名";
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
    _nameTextfield = [[UITextField alloc] init];
    _nameTextfield.frame = CGRectMake(0, 90, 240, 25);
    _nameTextfield.returnKeyType = UIReturnKeyDone;
    _nameTextfield.borderStyle = UITextBorderStyleNone;
    _nameTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameTextfield.leftViewMode = UITextFieldViewModeAlways;
    _nameTextfield.leftView = backView;
    _nameTextfield.placeholder = @"王兴胜";
    _nameTextfield.font = [UIFont systemFontOfSize:14.0f];
    _nameTextfield.delegate = self;
    _nameTextfield.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 250, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    [self.view addSubview:lineView];
    [self.view addSubview:_nameTextfield];
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
