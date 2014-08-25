//
//  CJShareViewController.m
//  CFEC
//
//  Created by SumFlower on 14-8-22.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJShareViewController.h"

@interface CJShareViewController ()

@end

@implementation CJShareViewController

@synthesize addressFriendBt = _addressFriendBt;
@synthesize weiboFriendBt = _weiboFriendBt;
@synthesize weixinFriendBt = _weixinFriendBt;
@synthesize emailFriendBt = _emailFriendBt;

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
    self.navigationItem.title = @"分享";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUI {
    _addressFriendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _addressFriendBt.frame = CGRectMake(15, 84, 134, 134);
    [_addressFriendBt setBackgroundImage:[UIImage imageNamed:@"分享_03@2x.png"] forState:UIControlStateNormal];
    [_addressFriendBt addTarget:self action:@selector(addressAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addressFriendBt];
    _weiboFriendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _weiboFriendBt.frame = CGRectMake(164, 84, 134, 134);
    [_weiboFriendBt setBackgroundImage:[UIImage imageNamed:@"分享_03-05@2x.png"] forState:UIControlStateNormal];
    [_weiboFriendBt addTarget:self action:@selector(weiboAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weiboFriendBt];
    _weixinFriendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _weixinFriendBt.frame = CGRectMake(15, 233, 134, 134);
    [_weixinFriendBt setBackgroundImage:[UIImage imageNamed:@"分享_03-09@2x.png"] forState:UIControlStateNormal];
    [_weixinFriendBt addTarget:self action:@selector(weixinAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weixinFriendBt];
    _emailFriendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _emailFriendBt.frame = CGRectMake(164, 233, 134, 134);
    [_emailFriendBt setBackgroundImage:[UIImage imageNamed:@"分享_03-10@2x.png"] forState:UIControlStateNormal];
    [_emailFriendBt addTarget:self action:@selector(emailAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_emailFriendBt];
}
-(void)addressAction:(id)sender {
    NSLog(@"邀请通讯录好友");
}
-(void)weiboAction:(id)sender {
    NSLog(@"邀请微博好友");
}
-(void)weixinAction:(id)sender {
    NSLog(@"邀请微信好友");
}
-(void)emailAction:(id)sender {
    NSLog(@"邀请邮箱好友");
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
