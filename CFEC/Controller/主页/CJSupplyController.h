//
//  CJSupplyController.h
//  CFEC
//
//  Created by SumFlower on 14-8-27.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJUserModel.h"
#import "CJActivityModel.h"
@interface CJSupplyController : UIViewController
@property (nonatomic, strong) CJUserModel *user;
@property (nonatomic, strong) CJActivityModel *activity;
@end
