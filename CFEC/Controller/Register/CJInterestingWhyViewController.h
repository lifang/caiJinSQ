//
//  CJInterestingWhyViewController.h
//  CFEC
//
//  Created by SumFlower on 14-9-1.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol interestingDelegate <NSObject>

-(void)interestingMessage:(NSString *)s;

@end
#import <UIKit/UIKit.h>

@interface CJInterestingWhyViewController : UIViewController
@property (nonatomic, assign) id<interestingDelegate>delegate;
@end
