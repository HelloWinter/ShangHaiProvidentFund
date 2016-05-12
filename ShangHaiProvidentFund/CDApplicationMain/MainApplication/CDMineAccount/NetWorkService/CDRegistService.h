//
//  CDRegistService.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDJSONBaseNetworkService.h"

@interface CDRegistService : CDJSONBaseNetworkService

- (void)loadWithParams:(NSDictionary *)params showIndicator:(BOOL)show;

@end
