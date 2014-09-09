//
//  CJTelController.h
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol telDelegate <NSObject>

-(void)telMessage:(NSString *)s;

@end
#import <UIKit/UIKit.h>

@interface CJTelController : UIViewController
@property (nonatomic ,assign) id<telDelegate>delegate;
@property (nonatomic, assign) BOOL isShow;
@end
