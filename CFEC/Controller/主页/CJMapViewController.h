//
//  CJMapViewController.h
//  CFEC
//
//  Created by SumFlower on 14/10/30.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJActivityModel.h"
//#import <AMapSearchKit/AMapSearchAPI.h>
#import "CJGPSNaviViewController.h"

@interface CJMapViewController : UIViewController
@property (strong, nonatomic) CJActivityModel *activityModel;

@property (nonatomic, strong) AMapGeocode *endGeoCode;

@end
