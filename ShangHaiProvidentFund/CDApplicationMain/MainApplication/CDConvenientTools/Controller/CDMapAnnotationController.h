//
//  CDMapAnnotationController.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/20.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface CDMapAnnotationController : CDBaseViewController

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *districts;
@property (nonatomic, copy) NSString *address;

@end
