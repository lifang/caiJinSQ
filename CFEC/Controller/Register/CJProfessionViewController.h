//
//  CJProfessionViewController.h
//  CFEC
//
//  Created by SumFlower on 14-9-1.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol professionDelegate <NSObject>

-(void)professionMessage:(NSString *)s;

@end
#import <UIKit/UIKit.h>

@interface CJProfessionViewController : UIViewController
@property (nonatomic, assign) id<professionDelegate>delegate;
@end
