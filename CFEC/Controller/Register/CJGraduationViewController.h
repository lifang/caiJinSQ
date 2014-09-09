//
//  CJGraduationViewController.h
//  CFEC
//
//  Created by SumFlower on 14-9-1.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol graduationDelegate <NSObject>

-(void)graduationMessage:(NSString *)s;

@end
#import <UIKit/UIKit.h>

@interface CJGraduationViewController : UIViewController
@property (nonatomic, assign) id<graduationDelegate>delegate;
@end
