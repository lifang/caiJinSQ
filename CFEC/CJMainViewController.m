//
//  CJMainViewController.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJMainViewController.h"
#import "CJHomeViewController.h"
#import "CJShareViewController.h"
#import "CJActivityController.h"
#import "CJGiftController.h"
#import "CJAppDelegate.h"

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
    [[self tabBar] setTintColor:kColor(121, 222, 19, 1)];
    [[self tabBar] setBarTintColor:[UIColor blackColor]];
    [self initControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Controllers 

- (void)initControllers {
    CJHomeViewController *vc1 = [[CJAppDelegate shareCJAppDelegate] homeController];
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                   image:[UIImage imageNamed:@"首页_09.png"]
                                                     tag:1];
    vc1.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    [CJAppDelegate setNavigationBarTinColor:nav1];
    
    CJShareViewController *vc2 = [[CJShareViewController alloc] init];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                   image:[UIImage imageNamed:@"首页_23.png"]
                                                     tag:2];
    vc2.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    [CJAppDelegate setNavigationBarTinColor:nav2];
    
    CJActivityController *vc3 = [[CJActivityController alloc] init];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                   image:[UIImage imageNamed:@"首页_14.png"]
                                                     tag:3];
    vc3.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    [CJAppDelegate setNavigationBarTinColor:nav3];
    
    CJGiftController *vc4 = [[CJGiftController alloc] init];
    vc4.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                   image:[UIImage imageNamed:@"首页_16.png"]
                                                     tag:4];
    vc4.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    [CJAppDelegate setNavigationBarTinColor:nav4];
    
    self.viewControllers = [NSArray arrayWithObjects:nav1,nav3,nav4,nav2, nil];
}

@end
