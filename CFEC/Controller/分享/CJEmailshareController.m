//
//  CJEmailshareController.m
//  CFEC
//
//  Created by SumFlower on 14-8-28.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJEmailshareController.h"

@interface CJEmailshareController ()
@property (nonatomic, strong) UITextField *emailTextfield;
@property (nonatomic, strong) UIButton *sendBt;
@end

@implementation CJEmailshareController
@synthesize emailTextfield = _emailTextfield;
@synthesize sendBt = _sendBt;
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"填写邮箱";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self initUI];
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
    _emailTextfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 74, 280, 30)];
//    _emailTextfield.backgroundColor = [UIColor greenColor];
    _emailTextfield.placeholder = @"name@web.com";
    [self.view addSubview:_emailTextfield];
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(20, 104, 280, 1)];
    lineview.backgroundColor = kColor(221, 221, 221, 1);
    [self.view addSubview:lineview];
    _sendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendBt.backgroundColor = kColor(130, 130, 130, 1);
    _sendBt.frame = CGRectMake(70, 134, 180, 40);
    _sendBt.layer.cornerRadius = 8.0;
    [_sendBt setTitle:@"确认发送邀请" forState:UIControlStateNormal];
    [_sendBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.view addSubview:_sendBt];
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
