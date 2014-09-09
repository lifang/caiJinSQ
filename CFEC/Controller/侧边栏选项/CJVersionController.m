//
//  CJVersionController.m
//  CFEC
//
//  Created by SumFlower on 14-8-29.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJVersionController.h"
#import "CJMainViewController.h"
#import "CJAppDelegate.h"
@interface CJVersionController ()
@property (nonatomic, strong) UILabel *versionNumberLabel;//版本号
@property (nonatomic, strong) UILabel *versionDescribeLabel;//版本描述
@end

@implementation CJVersionController
@synthesize versionNumberLabel = _versionNumberLabel;
@synthesize versionDescribeLabel = _versionDescribeLabel;
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
    self.navigationItem.title = @"版本号";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 94, 150, 15)];
    titlelabel.font = [UIFont systemFontOfSize:13.0f];
    titlelabel.text = @"当前版本号:";
    [self.view addSubview:titlelabel];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 280, 1)];
    line.backgroundColor = kColor(221, 221, 221, 1);
    [self.view addSubview:line];
    _versionNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 94, 100, 15)];
    _versionNumberLabel.font = [UIFont systemFontOfSize:13.0f];
    _versionNumberLabel.text = @"0.0.1";
    [self.view addSubview:_versionNumberLabel];
    
    _versionDescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 94, 150, 15)];
    _versionDescribeLabel.textColor = [UIColor redColor];
    _versionDescribeLabel.font = [UIFont systemFontOfSize:13.0f];
    _versionDescribeLabel.text = @"当前已是最新版本";
    [self.view addSubview:_versionDescribeLabel];


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
    CJMainViewController *mainC = [[CJMainViewController alloc] init];
    [[[[CJAppDelegate shareCJAppDelegate] rootController] navController] setCenterViewController:mainC withCloseAnimation:YES completion:nil];
}

@end
