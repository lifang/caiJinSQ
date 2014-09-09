//
//  CJEmailController.h
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol emailDelegate <NSObject>

-(void)emailMessage:(NSString *)s;

@end
#import <UIKit/UIKit.h>

@interface CJEmailController : UIViewController
@property (nonatomic, assign) id<emailDelegate>delegate;
@property (nonatomic, assign) BOOL isShow;
@end
