//
//  CJRootViewController.h
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMDrawerController.h"
#import "CJLoginViewController.h"


@interface CJRootViewController : UIViewController

@property (nonatomic, strong) UINavigationController *loginNav;

@property (nonatomic, strong) CJLoginViewController *loginC;


@property (nonatomic, strong) MMDrawerController *navController;

@property (nonatomic, strong) NSMutableArray *newsArray;//最新的六个活动


- (void)showMainController;

- (void)showLoginController;
- (void)setLoginController;
@end
