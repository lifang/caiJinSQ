//
//  CJNameController.h
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol nameDelegate <NSObject>

-(void)returnMessage:(NSString *)s;

@end
#import <UIKit/UIKit.h>

@interface CJNameController : UIViewController <UITextFieldDelegate>
@property (nonatomic ,assign) id<nameDelegate>delegate;

@property (nonatomic, assign) BOOL isShow;

@end
