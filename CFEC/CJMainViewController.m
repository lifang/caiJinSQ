//
//  CJMainViewController.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJMainViewController.h"
#import "CJHomeViewController.h"

@interface CJMainViewController ()

@end

@implementation CJMainViewController

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
    // Do any additional setup after loading the view.
    [self initControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Controllers 

- (void)initControllers {
    CJHomeViewController *vc1 = [[CJHomeViewController alloc] init];
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                   image:[UIImage imageNamed:@"tabbar.png"]
                                                     tag:1];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    CJHomeViewController *vc2 = [[CJHomeViewController alloc] init];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分享"
                                                   image:[UIImage imageNamed:@"tabbar.png"]
                                                     tag:2];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    CJHomeViewController *vc3 = [[CJHomeViewController alloc] init];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"活动"
                                                   image:[UIImage imageNamed:@"tabbar.png"]
                                                     tag:3];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    CJHomeViewController *vc4 = [[CJHomeViewController alloc] init];
    vc4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"礼品"
                                                   image:[UIImage imageNamed:@"tabbar.png"]
                                                     tag:4];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    self.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil];
}

@end
