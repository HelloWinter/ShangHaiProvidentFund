//
//  CDNewsAndTrendsService.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDJSONBaseNetworkService.h"

@interface CDNewsAndTrendsService : CDJSONBaseNetworkService

@property (nonatomic, copy, readonly) NSArray *arrData;

- (void)loadNewsAndTrendsIgnoreCache:(BOOL)ignore showIndicator:(BOOL)show;

@end
