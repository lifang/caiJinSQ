//
//  CJIntegralController.m
//  CFEC
//
//  Created by SumFlower on 14-8-29.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJIntegralController.h"
#import "CJMainViewController.h"
#import "CJAppDelegate.h"
#import "CJUserModel.h"
@interface CJIntegralController ()<UIActionSheetDelegate>
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UIButton *getIntegralButton;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation CJIntegralController
@synthesize integralLabel = _integralLabel;
@synthesize getIntegralButton = _getIntegralButton;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)initUI {
    self.navigationItem.title = @"积分";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
//    [self setRightNavBarItemWithImageName:@"订单_03-05@2x"];
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 94, 150, 15)];
    titlelabel.font = [UIFont systemFontOfSize:13.0f];
    titlelabel.text = @"您当前所有积分为 :";
    [self.view addSubview:titlelabel];
    _integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 94, 100, 15)];
    _integralLabel.textColor = [UIColor redColor];
    _integralLabel.font = [UIFont systemFontOfSize:13.0f];
    CJUserModel *user = [CJAppDelegate shareCJAppDelegate].user;
    NSString *integral = [NSString stringWithFormat:@"%@",user.integral];
    _integralLabel.text = integral;
    [self.view addSubview:_integralLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 280, 1)];
    line.backgroundColor = kColor(221, 221, 221, 1);
    [self.view addSubview:line];
    
    _getIntegralButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _getIntegralButton.frame = CGRectMake(90, 150, 150, 40);
    _getIntegralButton.layer.backgroundColor = kColor(130, 130, 130, 1).CGColor;
    _getIntegralButton.layer.cornerRadius = 10.0f;
    [_getIntegralButton setTitle:@"如何获取积分" forState:UIControlStateNormal];
    [_getIntegralButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_getIntegralButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_getIntegralButton addTarget:self action:@selector(getIntrgral:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getIntegralButton];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, line.frame.origin.y + 10, self.view.frame.size.width, kScreenHeight - _webView.frame.origin.y -1)];
}
-(IBAction)getIntrgral:(UIButton *)sender {
    [self.view addSubview:_webView];
    [self loadWebPageWithString:@"http://www.cfec.pro/member.html"];
}
-(void)setLeftNavBarItemWithImageName:(NSString *)name {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
}
-(void)setRightNavBarItemWithImageName:(NSString *)name {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 25, 25);
    [rightButton setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
}
#pragma mark -- 分享
-(void)share:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"转发给微信好友",@"转发给微博好友", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];
}
-(void)back:(id)sender {
    CJMainViewController *mainC = [[CJMainViewController alloc] init];
    [[[[CJAppDelegate shareCJAppDelegate] rootController] navController] setCenterViewController:mainC withCloseAnimation:YES completion:nil];
}
-(void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for (UIView *subView in actionSheet.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *bt = (UIButton *)subView;
            if (bt.tag == 3) {
                [bt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
        }
    }
}
- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

@end
