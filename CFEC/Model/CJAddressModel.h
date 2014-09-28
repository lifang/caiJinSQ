//
//  CJAddressModel.h
//  CFEC
//
//  Created by SumFlower on 14-9-28.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJAddressModel : NSObject
@property (strong, nonatomic) NSString *addressChinese;
@property (strong, nonatomic) NSString *addressEnglish;
@property (strong, nonatomic) NSString *addressPhone;
@property (assign, nonatomic) int number;
@end
