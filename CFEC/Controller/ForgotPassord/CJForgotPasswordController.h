//
//  CJForgotPasswordController.h
//  CFEC
//
//  Created by SumFlower on 14-8-20.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJForgotPasswordController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *telAndemailTextfield;
@property (nonatomic, strong) UIButton *getButton;
@end
