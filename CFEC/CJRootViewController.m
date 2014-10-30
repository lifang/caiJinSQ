//
//  CJRootViewController.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJRootViewController.h"
#import "CJLoginViewController.h"
#import "CJMainViewController.h"
#import "CJLeftViewController.h"
#import "CJAppDelegate.h"

@interface CJRootViewController ()
@property (strong, nonatomic) CJMainViewController *mainC;
@end

@implementation CJRootViewController

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
    [self setLoginController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login View Controller

- (void)setLoginController {

    CJLoginViewController *loginC = [[CJLoginViewController alloc] init];
    _loginNav = [[UINavigationController alloc] initWithRootViewController:loginC];
    [CJAppDelegate setNavigationBarTinColor:_loginNav];

    _loginNav.view.frame = self.view.bounds;
    [self.view addSubview:_loginNav.view];
}

- (void)showMainController {
    CJLeftViewController *leftC = [[CJLeftViewController alloc] init];
    UINavigationController *navL = [[UINavigationController alloc] initWithRootViewController:leftC];
    
    _mainC = [[CJMainViewController alloc] init];
    
    _navController = [[MMDrawerController alloc] initWithCenterViewController:_mainC
                                                     leftDrawerViewController:navL];
    [_navController setMaximumLeftDrawerWidth:220];
    [_navController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_navController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeTapCenterView | MMCloseDrawerGestureModePanningCenterView];
    _navController.view.frame = self.view.bounds;
    [self.view addSubview:_navController.view];
}

- (void)showLoginController {
    
    if (_navController) {
        [UIView beginAnimations:@"disappear" context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        _navController.view.transform = CGAffineTransformMakeTranslation(320, 0);
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(disappearMainController)];
        [UIView commitAnimations];
    }
}

#pragma mark - Animation

- (void)disappearMainController {
    [_navController.view removeFromSuperview];
    _navController = nil;
}

@end
