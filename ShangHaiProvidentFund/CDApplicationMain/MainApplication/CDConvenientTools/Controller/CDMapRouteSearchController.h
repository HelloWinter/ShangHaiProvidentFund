//
//  CDMapRouteSearchController.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/20.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface CDMapRouteSearchController : CDBaseViewController

@property (nonatomic, assign) CLLocationCoordinate2D startCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D endCoordinate;

@property (nonatomic, copy) NSString *destinationName;
@property (nonatomic, copy) NSString *destinationAddress;

@property (nonatomic, copy) NSString *cityname;

@end
