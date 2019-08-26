//
//  CDBMKLocationManager.m
//  ShangHaiProvidentFund
//
//  Created by chengdong on 2019/8/24.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import "CDBMKLocationManager.h"
#import <BMKLocationKit/BMKLocationComponent.h>

@interface CDBMKLocationManager ()<BMKLocationAuthDelegate,BMKLocationManagerDelegate>{
    BMKLocationManager *_locationManager;
}

@end

@implementation CDBMKLocationManager

DEF_SINGLETON(CDBMKLocationManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[BMKLocationAuth sharedInstance] checkPermisionWithKey:MapKey authDelegate:self];
        //初始化实例
        _locationManager = [[BMKLocationManager alloc] init];
        //设置delegate
        _locationManager.delegate = self;
        //设置返回位置的坐标系类型
        _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        //设置距离过滤参数
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置预期精度参数
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置应用位置类型
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        //设置是否自动停止位置更新
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        //设置是否允许后台定位
        //_locationManager.allowsBackgroundLocationUpdates = YES;
        //设置位置获取超时时间
        _locationManager.locationTimeout = 10;
        //设置获取地址信息超时时间
        _locationManager.reGeocodeTimeout = 10;
    }
    return self;
}

- (void)startLocation{
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        if (error){
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            [CDCacheManager removeUserLocation];
        }
        if (location) {//得到定位信息，添加annotation
            if (location.location) {
                NSLog(@"LOC = %@",location.location);
                NSString *strCoordinate=[NSString stringWithFormat:@"%f,%f",location.location.coordinate.latitude,location.location.coordinate.longitude];
                [CDCacheManager saveUserLocation:strCoordinate];
            }
            if (location.rgcData) {
                NSLog(@"rgc = %@",[location.rgcData description]);
            }
        }
        NSLog(@"netstate = %d",state);
    }];
}

@end
