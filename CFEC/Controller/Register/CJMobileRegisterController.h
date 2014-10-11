//
//  CJMobileRegisterController.h
//  CFEC
//
//  Created by SumFlower on 14-10-11.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJMobileRegisterController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *positionField;

@property (weak, nonatomic) IBOutlet UITextField *companyField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *password;
@end
