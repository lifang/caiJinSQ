//
//  CJCompanyController.h
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol companyDelegate <NSObject>

-(void)companyMessage:(NSString *)s;

@end

#import <UIKit/UIKit.h>

@interface CJCompanyController : UIViewController
@property (nonatomic, assign) id<companyDelegate>delegate;
@property (nonatomic, assign) BOOL isShow;
@end
