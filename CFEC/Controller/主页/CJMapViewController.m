//
//  CJMapViewController.m
//  CFEC
//
//  Created by SumFlower on 14/10/30.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJMapViewController.h"
//#import <MAMapKit/MAMapKit.h>

@interface CJMapViewController ()<AMapSearchDelegate,MAMapViewDelegate>


@property (strong, nonatomic) AMapSearchAPI *search;

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) NSMutableArray *annotations;

@property (nonatomic, strong) UIButton *daoHangBt;

@end

@implementation CJMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地图";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];

    
    self.mapView=[[MAMapView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.mapView.delegate = self;
    CLLocationCoordinate2D location;
    location.latitude = _endGeoCode.location.latitude;
    location.longitude = _endGeoCode.location.longitude;
    [self.mapView setCenterCoordinate:location animated:YES];
    
    MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
    red.coordinate = CLLocationCoordinate2DMake(_endGeoCode.location.latitude, _endGeoCode.location.longitude);
    red.title = _activityModel.meetingAddress;
    [self.mapView addAnnotation:red];
    
    
    [self.view addSubview:self.mapView];
    
    _daoHangBt = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect = [[UIScreen mainScreen] bounds];

    _daoHangBt.frame = CGRectMake(rect.size.width/2 - 50, rect.size.height, 100, 44);
    [_daoHangBt setTitle:@"去导航" forState:UIControlStateNormal];
    [_daoHangBt setTitleColor:kColor(118, 180, 60, 1) forState:UIControlStateNormal];
    [_daoHangBt setTitle:@"去导航" forState:UIControlStateHighlighted];
    [_daoHangBt addTarget:self action:@selector(goDaoHang:) forControlEvents:UIControlEventTouchUpInside];
    _daoHangBt.layer.masksToBounds = YES;
    _daoHangBt.layer.borderWidth = 1;
    _daoHangBt.layer.cornerRadius = 8.0;
    _daoHangBt.layer.borderColor = kColor(118, 180, 60, 1).CGColor;
    [self.view addSubview:_daoHangBt];
    [UIView animateWithDuration:2 animations:^{
        
        _daoHangBt.frame = CGRectMake(rect.size.width/2 - 50, rect.size.height - 80, 100, 44);
        
    }];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)goDaoHang:(UIButton *)bt
{
    CJGPSNaviViewController *gpsC = [[CJGPSNaviViewController alloc] init];
    gpsC.activityModel = self.activityModel;
    gpsC.endGeoCode = self.endGeoCode;
    [self.navigationController pushViewController:gpsC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    //
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{

    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier"; MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView
                                                                                                                                     dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            annotationView.canShowCallout= YES;
            annotationView.animatesDrop = YES;
            annotationView.draggable = YES;

        }
        return annotationView;
    }
    return nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
}
@end
