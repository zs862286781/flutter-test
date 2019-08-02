//
//  MapVC.m
//  Runner
//
//  Created by 颂张 on 2019/6/27.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "MapVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
@interface MapVC ()<MAMapViewDelegate,AMapNaviDriveManagerDelegate>
{
    MAMapView *_mapView;
    AMapNaviPoint *startPoint;
    AMapNaviPoint *endPoint;
    UIButton *backBtn;
    double latitude;
    double longitude;
}
@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    latitude = [_result[@"latitude"] doubleValue];
    longitude = [_result[@"longitude"] doubleValue];
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
//    _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.99, 116.47);
    
    ///把地图添加至view
    _mapView.zoomLevel = 16;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [self initProperties];
    [self createback];
}

- (void)createback {
    backBtn = [UIButton new];
    backBtn.frame = CGRectMake(20, 40, 80, 40);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    backBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:backBtn];
}

- (void)back {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (void)initProperties
{
    startPoint = [AMapNaviPoint locationWithLatitude:latitude longitude:longitude];
    endPoint   = [AMapNaviPoint locationWithLatitude:31.96 longitude:118.80];
    [[AMapNaviDriveManager sharedInstance] setDelegate:self];
    [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPoints:@[startPoint] endPoints:@[endPoint] wayPoints:nil drivingStrategy:0];
}

- (void)dealloc
{
    [[AMapNaviDriveManager sharedInstance] stopNavi];
//    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    BOOL success = [AMapNaviDriveManager destroyInstance];
    NSLog(@"单例是否销毁成功 : %d",success);
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    CLLocationCoordinate2D commonPolylineCoords[driveManager.naviRoute.routeCoordinates.count];
    //显示路径或开启导航
    for (int i = 0; i<driveManager.naviRoute.routeCoordinates.count; i++) {
        AMapNaviPoint *obj = driveManager.naviRoute.routeCoordinates[i];
        commonPolylineCoords[i].latitude = obj.latitude;
        commonPolylineCoords[i].longitude = obj.longitude;
    }
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:driveManager.naviRoute.routeCoordinates.count];
//    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
    
//    NSLog(@"%ld",driveManager.naviRouteID);
//    BOOL success =  [[AMapNaviDriveManager sharedInstance] selectNaviRouteWithRouteID:driveManager.naviRouteID];
//    NSLog(@"路线获取成功 : %d",success);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    latitude = [_result[@"latitude"] doubleValue];
    longitude = [_result[@"longitude"] doubleValue];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    pointAnnotation.title = _result[@"formattedAddress"];
    //    pointAnnotation.subtitle = @"阜通东大街6号";
    [_mapView addAnnotation:pointAnnotation];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 5.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

@end
