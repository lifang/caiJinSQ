//
//  CJRegisterServiceController.m
//  CFEC
//
//  Created by SumFlower on 14-9-29.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJRegisterServiceController.h"
#import "CJAppDelegate.h"
#import "CJRegisterController.h"
@interface CJRegisterServiceController ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation CJRegisterServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)initUI {
    self.navigationItem.title = @"服务条款";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"serviceContent" ofType:@"txt"];
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13.0],NSFontAttributeName, nil];
    //    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    //    float high = rect.size.height;
    UITextView *label = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, kScreenHeight)];
    label.font = [UIFont systemFontOfSize:13.0];
    label.text = text;
    [self.view addSubview:label];
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

@end
