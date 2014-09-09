//
//  CJAppDelegate.h
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CJRootViewController.h"
#import "CJUserModel.h"
#import "WXApi.h"

@interface CJAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CJRootViewController *rootController;
//登录用户信息 初始时从本地读取
@property (nonatomic, strong) CJUserModel *user;
@property (nonatomic, strong) NSMutableDictionary *userDic;
//所有活动
@property (nonatomic, strong) NSArray *allActivityArray;


+ (CJAppDelegate *)shareCJAppDelegate;
+ (void)setNavigationBarTinColor:(UINavigationController *)nav;
@end
