//
//  CJSchoolViewController.h
//  CFEC
//
//  Created by SumFlower on 14-9-1.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol schoolDelegate <NSObject>

-(void)schoolMessage:(NSString *)s;

@end
#import <UIKit/UIKit.h>

@interface CJSchoolViewController : UIViewController
@property (nonatomic ,assign) id<schoolDelegate>delegate;
@end
