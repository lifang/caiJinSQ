//
//  CJBusinessRangeViewController.h
//  CFEC
//
//  Created by SumFlower on 14-9-1.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol businessDelegate <NSObject>

-(void)businessMessage:(NSString *)s;

@end
#import <UIKit/UIKit.h>

@interface CJBusinessRangeViewController : UIViewController
@property (nonatomic, assign) id<businessDelegate>delegate;
@end
