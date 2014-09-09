//
//  CJContactusController.m
//  CFEC
//
//  Created by SumFlower on 14-8-29.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJContactusController.h"
#import "CJMainViewController.h"
#import "CJAppDelegate.h"
@interface CJContactusController ()
@property (nonatomic, strong) UILabel *contacttelLabel;
@property (nonatomic, strong) UILabel *contactemailLabel;
@end

@implementation CJContactusController
@synthesize contacttelLabel = _contacttelLabel;
@synthesize contactemailLabel = _contactemailLabel;
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
    self.navigationItem.title = @"联系我们";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 94, 150, 15)];
    titlelabel.font = [UIFont systemFontOfSize:13.0f];
    titlelabel.text = @"联系电话 :";
    [self.view addSubview:titlelabel];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 115, 280, 1)];
    line.backgroundColor = kColor(221, 221, 221, 1);
    [self.view addSubview:line];
    UILabel *titlelabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 145, 150, 15)];
    titlelabel2.font = [UIFont systemFontOfSize:13.0f];
    titlelabel2.text = @"联系邮箱 :";
    [self.view addSubview:titlelabel2];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(20, 168, 280, 1)];
    line2.backgroundColor = kColor(221, 221, 221, 1);
    [self.view addSubview:line2];
    
    _contacttelLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 94, 100, 15)];
    _contacttelLabel.text = @"400-820-3872";
    _contacttelLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:_contacttelLabel];
    
    _contactemailLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 145, 200, 15)];
    _contactemailLabel.font = [UIFont systemFontOfSize:13.0f];
    _contactemailLabel.text = @"member-service@cfec.pro";
    [self.view addSubview:_contactemailLabel];
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
