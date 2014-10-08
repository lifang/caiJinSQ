//
//  CJGiftIntrgralPayController.h
//  CFEC
//
//  Created by SumFlower on 14-10-3.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJGiftModel.h"
@interface CJGiftIntrgralPayController : UIViewController
@property (nonatomic, strong) CJGiftModel *giftModel;
@property (assign, nonatomic) int count;
@property (nonatomic, strong) NSString *addressStr;
@end
