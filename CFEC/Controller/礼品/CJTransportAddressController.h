//
//  CJTransportAddressController.h
//  CFEC
//
//  Created by SumFlower on 14-9-5.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol sendTansportDelegate <NSObject>

-(void)sendAddress:(NSString *)addressid;

@end
#import <UIKit/UIKit.h>

@interface CJTransportAddressController : UIViewController
@property (nonatomic, assign) id<sendTansportDelegate>delegate;
@property (nonatomic, strong) NSString *addressId;
@end
