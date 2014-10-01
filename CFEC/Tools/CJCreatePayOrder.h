//
//  CJCreatePayOrder.h
//  CFEC
//
//  Created by 徐宝桥 on 14-9-12.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJGiftModel.h"
#import "CJActivityModel.h"

@interface CJCreatePayOrder : NSObject

+ (NSString *)createGiftOrderWithGift:(CJGiftModel *)gift
                          countNumber:(int)count;

+ (NSString *)createActivityOrderWithActivity:(CJActivityModel *)activity
                                  countNumber:(int)count andReducePrice:(int)reduce;

@end
