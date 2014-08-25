//
//  CJAppDelegate.h
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CJRootViewController.h"

@interface CJAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CJRootViewController *rootController;


+ (CJAppDelegate *)shareCJAppDelegate;
+ (void)setNavigationBarTinColor:(UINavigationController *)nav;
@end
