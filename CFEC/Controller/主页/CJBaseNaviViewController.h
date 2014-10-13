//
//  CJBaseNaviViewController.h
//  CFEC
//
//  Created by SumFlower on 14-10-13.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "Toast+UIView.h"
#import "UIView+Geometry.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySetting.h"

@interface CJBaseNaviViewController : UIViewController<MAMapViewDelegate,AMapNaviManagerDelegate,
IFlySpeechSynthesizerDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

@property (nonatomic, strong) AMapNaviManager *naviManager;

- (void)returnAction;

@end
