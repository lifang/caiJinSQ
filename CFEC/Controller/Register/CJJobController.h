//
//  CJJobController.h
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol jobDelegate <NSObject>

-(void)jobMessage:(NSString *)s;

@end
#import <UIKit/UIKit.h>

@interface CJJobController : UIViewController
@property (nonatomic, assign) id<jobDelegate>delegate;
@property (nonatomic, assign) BOOL isShow;
@end
