//
//  CJGPSNaviViewController.m
//  CFEC
//
//  Created by SumFlower on 14-10-13.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJGPSNaviViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "ASPin.h"

//#import <MAMapKit/MAMapKit.h>
@interface CJGPSNaviViewController ()<AMapNaviViewControllerDelegate,CLLocationManagerDelegate,AMapSearchDelegate,MAMapViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, strong) AMapNaviViewController *naviViewController;

@property (nonatomic, strong) AMapNaviPoint* startPoint;
@property (nonatomic, strong) AMapNaviPoint* endPoint;

@property (strong, nonatomic)    CLLocationManager* locationManager;

@property (strong, nonatomic) AMapSearchAPI *search;

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) NSMutableArray *annotations;

@property (nonatomic, strong) UIButton *daoHangBt;

@property (nonatomic, strong) CLLocationManager *Manager;

@property (nonatomic, strong) MKMapView *map;

@end

@implementation CJGPSNaviViewController

#pragma mark - Life Cycle

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    [self.locationManager startUpdatingLocation];
    
    [self initNaviViewController];
    
    //实例化位置管理器
    _map = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_map];
    CLLocationCoordinate2D location;
    location.latitude = _endGeoCode.location.latitude;
    location.longitude= _endGeoCode.location.longitude;
//    _map.center = location;
    
//    _map.centerCoordinate = location;
    _Manager = [[CLLocationManager alloc] init];
    _Manager.delegate =self;
    
    //设置最佳经度
    _Manager.desiredAccuracy =kCLLocationAccuracyBest;
    //位置过滤:10m更新一次
    _Manager.distanceFilter =10.0;
    
    //启动位置服务
    [_Manager startUpdatingLocation];
    
    //设置地图代理
    _map.delegate =self;
    //确定地图类型
    _map.mapType =MKMapTypeStandard;
    
    //默认显示用户当前位置
    _map.showsUserLocation =YES;
    
    //为地图添加注解：这里只做示例添加一个注解点
    CLLocationCoordinate2D coordinate = {_endGeoCode.location.latitude,_endGeoCode.location.longitude};
    ASPin *pin =[[ASPin alloc]initWithCoordinate:coordinate andTitle:_activityModel.meetingAddress];
//    pin.title = _activityModel.meetingAddress;
    [_map addAnnotation:pin];
//
    [self.view addSubview:_map];
    
    // Do any additional setup after loading the view.
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
//    UILabel *startPointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 20)];
//    
//    startPointLabel.textAlignment = NSTextAlignmentCenter;
//    startPointLabel.font = [UIFont systemFontOfSize:14];
//    startPointLabel.text = @"起点:当前所在位置";
//    
//    [self.view addSubview:startPointLabel];
//    
//    UILabel *endPointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, 320, 20)];
//    
//    endPointLabel.textAlignment = NSTextAlignmentCenter;
//    endPointLabel.font = [UIFont systemFontOfSize:14];
//    endPointLabel.text = [NSString stringWithFormat:@"终点:%@",_activityModel.meetingAddress];
//    
//    [self.view addSubview:endPointLabel];
//    
//    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    startBtn.layer.borderColor  = [UIColor lightGrayColor].CGColor;
//    startBtn.layer.borderWidth  = 0.5;
//    startBtn.layer.cornerRadius = 5;
//    
//    [startBtn setFrame:CGRectMake(60, 160, 200, 30)];
//    [startBtn setTitle:@"实时导航" forState:UIControlStateNormal];
//    [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    startBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
//    
//    [startBtn addTarget:self action:@selector(startGPSNavi:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview:startBtn];
//    self.navigationItem.title = @"地图";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    
    
//    self.mapView=[[MAMapView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.mapView.delegate = self;
//    CLLocationCoordinate2D location;
//    location.latitude = _endGeoCode.location.latitude;
//    location.longitude = _endGeoCode.location.longitude;
//    [self.mapView setCenterCoordinate:location animated:YES];
//    
//    MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
//    red.coordinate = CLLocationCoordinate2DMake(_endGeoCode.location.latitude, _endGeoCode.location.longitude);
//    red.title = _activityModel.meetingAddress;
//    [self.mapView addAnnotation:red];
//    
//    
//    [self.view addSubview:self.mapView];
    
    _daoHangBt = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    _daoHangBt.frame = CGRectMake(rect.size.width/2 - 50, rect.size.height - 80, 100, 44);
    [_daoHangBt setTitle:@"去导航" forState:UIControlStateNormal];
    [_daoHangBt setTitleColor:kColor(118, 180, 60, 1) forState:UIControlStateNormal];
    [_daoHangBt setTitle:@"去导航" forState:UIControlStateHighlighted];
    [_daoHangBt addTarget:self action:@selector(startGPSNavi:) forControlEvents:UIControlEventTouchUpInside];
    _daoHangBt.layer.masksToBounds = YES;
    _daoHangBt.layer.borderWidth = 1;
    _daoHangBt.layer.cornerRadius = 8.0;
    _daoHangBt.layer.borderColor = kColor(118, 180, 60, 1).CGColor;
    [self.view addSubview:_daoHangBt];
//    [UIView animateWithDuration:2 animations:^{
//        
//        _daoHangBt.frame = CGRectMake(rect.size.width/2 - 50, rect.size.height - 80, 100, 44);
//        
//    }];
}

//-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
//{
//    
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndetifier = @"pointReuseIndetifier"; MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView
//                                                                                                                                     dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
//            annotationView.canShowCallout= YES;
//            annotationView.animatesDrop = YES;
//            annotationView.draggable = YES;
//            
//        }
//        return annotationView;
//    }
//    return nil;
//}

-(void)setLeftNavBarItemWithImageName:(NSString *)name {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
}
-(void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;

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


-(void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
//    self.mapView=[[MAMapView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.mapView.delegate = self;
//    CLLocationCoordinate2D location;
//    location.latitude = _endGeoCode.location.latitude;
//    location.longitude = _endGeoCode.location.longitude;
//    [self.mapView setCenterCoordinate:location animated:YES];
//    
//    MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
//    red.coordinate = CLLocationCoordinate2DMake(_endGeoCode.location.latitude, _endGeoCode.location.longitude);
//    red.title = _activityModel.meetingAddress;
//    [self.mapView addAnnotation:red];
//    
//    
//    [self.view addSubview:self.mapView];

}
#pragma mark - MKMapViewDelegate

//添加注解
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    MKPinAnnotationView *pinView =nil;
    static NSString *defaultPinID = @"AS.PIN";
    
    
    pinView = (MKPinAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if(pinView==nil)
    {
        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.canShowCallout =YES; //是否点击显示注释文字
        pinView.animatesDrop =NO;
        
    }
    return pinView;
    
}

@end
