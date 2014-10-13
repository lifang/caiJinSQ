//
//  CJGPSNaviViewController.m
//  CFEC
//
//  Created by SumFlower on 14-10-13.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJGPSNaviViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

//#import <MAMapKit/MAMapKit.h>
@interface CJGPSNaviViewController ()<AMapNaviViewControllerDelegate,CLLocationManagerDelegate,AMapSearchDelegate,MAMapViewDelegate>

@property (nonatomic, strong) AMapNaviViewController *naviViewController;

@property (nonatomic, strong) AMapNaviPoint* startPoint;
@property (nonatomic, strong) AMapNaviPoint* endPoint;
@property (nonatomic, strong) AMapGeocode *endGeoCode;

@property (strong, nonatomic)    CLLocationManager* locationManager;

@property (strong, nonatomic) AMapSearchAPI *search;

@end

@implementation CJGPSNaviViewController

#pragma mark - Life Cycle

- (id)init
{
    self = [super init];
    if (self)
    {
//        _startPoint = [AMapNaviPoint locationWithLatitude:39.989614 longitude:116.481763];
//        _endPoint   = [AMapNaviPoint locationWithLatitude:39.983456 longitude:116.315495];
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.search = [[AMapSearchAPI alloc] initWithSearchKey: APIKey Delegate:self];
    AMapGeocodeSearchRequest *geoRequest = [[AMapGeocodeSearchRequest alloc] init]; geoRequest.searchType = AMapSearchType_Geocode;
    geoRequest.address = [NSString stringWithFormat:@"%@",_activityModel.meetingAddress];
    [self.search AMapGeocodeSearch: geoRequest];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    [self.locationManager startUpdatingLocation];
    
    [self initNaviViewController];
    
    // Do any additional setup after loading the view.
}
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%f,%f",obj.location.latitude,obj.location.longitude);
        _endGeoCode = obj;
    }];

    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    NSString *text1 = [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.latitude];
//    NSString *text2 = [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.longitude];
    _startPoint = [AMapNaviPoint locationWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    _endPoint   = [AMapNaviPoint locationWithLatitude:_endGeoCode.location.latitude longitude:_endGeoCode.location.longitude];
    [self configSubViews];
    [_locationManager stopUpdatingLocation];
//    NSLog(@"%@,%@",text1,text2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)initNaviViewController
{
    if (_naviViewController == nil)
    {
        _naviViewController = [[AMapNaviViewController alloc] initWithMapView:self.mapView delegate:self];
    }
}

- (void)configSubViews
{
    UILabel *startPointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 20)];
    
    startPointLabel.textAlignment = NSTextAlignmentCenter;
    startPointLabel.font = [UIFont systemFontOfSize:14];
    startPointLabel.text = @"起点:当前所在位置";
    
    [self.view addSubview:startPointLabel];
    
    UILabel *endPointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, 320, 20)];
    
    endPointLabel.textAlignment = NSTextAlignmentCenter;
    endPointLabel.font = [UIFont systemFontOfSize:14];
    endPointLabel.text = [NSString stringWithFormat:@"终点:%@",_activityModel.meetingAddress];
    
    [self.view addSubview:endPointLabel];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    startBtn.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    startBtn.layer.borderWidth  = 0.5;
    startBtn.layer.cornerRadius = 5;
    
    [startBtn setFrame:CGRectMake(60, 160, 200, 30)];
    [startBtn setTitle:@"实时导航" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    
    [startBtn addTarget:self action:@selector(startGPSNavi:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startBtn];
}


#pragma mark - Utility

- (void)startGPSNavi:(id)sender
{
    // 算路
    [self calculateRoute];
}

- (void)calculateRoute
{
    NSArray *startPoints = @[_startPoint];
    NSArray *endPoints   = @[_endPoint];
    
    [self.naviManager calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:0];
}


#pragma mark - AMapNaviManager Delegate

- (void)AMapNaviManager:(AMapNaviManager *)naviManager didPresentNaviViewController:(UIViewController *)naviViewController
{
    [super AMapNaviManager:naviManager didPresentNaviViewController:naviViewController];
    
    [self.naviManager startGPSNavi];
}

- (void)AMapNaviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
{
    [super AMapNaviManagerOnCalculateRouteSuccess:naviManager];
    
    [self.naviManager presentNaviViewController:self.naviViewController animated:YES];
}

- (void)AMapNaviManager:(AMapNaviManager *)naviManager onCalculateRouteFailure:(NSError *)error
{
    [super AMapNaviManager:naviManager onCalculateRouteFailure:error];
    [self.view makeToast:@"算路失败"
                duration:2.0
                position:[NSValue valueWithCGPoint:CGPointMake(160, 240)]];
}

#pragma mark - AManNaviViewController Delegate

- (void)AMapNaviViewControllerCloseButtonClicked:(AMapNaviViewController *)naviViewController
{
    [self.iFlySpeechSynthesizer stopSpeaking];
    [self.naviManager stopNavi];
    [self.naviManager dismissNaviViewControllerAnimated:YES];
}

- (void)AMapNaviViewControllerMoreButtonClicked:(AMapNaviViewController *)naviViewController
{
    if (self.naviViewController.viewShowMode == AMapNaviViewShowModeCarNorthDirection)
    {
        self.naviViewController.viewShowMode = AMapNaviViewShowModeMapNorthDirection;
    }
    else
    {
        self.naviViewController.viewShowMode = AMapNaviViewShowModeCarNorthDirection;
    }
}

- (void)AMapNaviViewControllerTrunIndicatorViewTapped:(AMapNaviViewController *)naviViewController
{
    [self.naviManager readNaviInfoManual];
}

@end
