//
//  CJPayController.h
//  CFEC
//
//  Created by SumFlower on 14-8-28.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJActivityModel.h"
@interface CJPayController : UIViewController
@property (nonatomic, strong) CJActivityModel *activityModel;
@property (assign, nonatomic) int count;
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *phone;
@property (nonatomic ,strong) NSString *email;
@property (nonatomic ,strong) NSString *companyName;
@end
