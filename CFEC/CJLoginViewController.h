//
//  CJLoginViewController.h
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJLoginViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, assign) BOOL isShow; //判断登陆界面是否显示
@property (nonatomic, assign) BOOL isremember;//判断是否记住密码
@property (nonatomic, strong) NSMutableDictionary *userInfoDic;
@end
