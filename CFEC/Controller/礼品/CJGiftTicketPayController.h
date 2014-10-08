//
//  CJGiftTicketPayController.h
//  CFEC
//
//  Created by SumFlower on 14-10-4.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJGiftModel.h"
@interface CJGiftTicketPayController : UIViewController
@property (nonatomic, strong) CJGiftModel *gift;
@property (nonatomic, strong) NSString *addressStr;
@property (nonatomic, assign) int count;
@end
