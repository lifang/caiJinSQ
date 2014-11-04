//
//  CJGPSNaviViewController.h
//  CFEC
//
//  Created by SumFlower on 14-10-13.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJBaseNaviViewController.h"
#import <AMapSearchKit/AMapSearchAPI.h>

#import "CJActivityModel.h"
@interface CJGPSNaviViewController : CJBaseNaviViewController
@property (nonatomic, strong) CJActivityModel *activityModel;
@property (nonatomic, strong) AMapGeocode *endGeoCode;

@end
