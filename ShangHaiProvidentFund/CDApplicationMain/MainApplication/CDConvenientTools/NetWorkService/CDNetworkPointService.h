//
//  CDNetworkPointService.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDJSONBaseNetworkService.h"

@interface CDNetworkPointService : CDJSONBaseNetworkService

@property (nonatomic, copy, readonly) NSArray *arrData;

- (void)loadNetworkPointIgnoreCache:(BOOL)ignore ShowIndicator:(BOOL)show;

@end
