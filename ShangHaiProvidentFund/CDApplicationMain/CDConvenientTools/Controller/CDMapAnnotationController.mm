//
//  CDMapAnnotationController.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/20.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDMapAnnotationController.h"


@interface CDMapAnnotationController ()<BMKMapViewDelegate>

@property (nonatomic, strong) BMKMapView* mapView;

@end

@implementation CDMapAnnotationController

- (void)dealloc{
    if (_mapView) {
        _mapView=nil;
    }
}

- (instancetype)init{
    self =[super init];
    if (self) {
        self.title=@"地图标注";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    self.mapView.centerCoordinate=self.coordinate;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = self.coordinate;
    annotation.title =self.districts;
    annotation.subtitle=self.address;
    [self.mapView addAnnotation:annotation];
}

- (BMKMapView *)mapView{
    if (_mapView==nil) {
        _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64)];
        _mapView.zoomLevel=17;
    }
    return _mapView;
}

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
