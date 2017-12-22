//
//  CDChangePSWService.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDJSONBaseNetworkService.h"

@interface CDChangePSWService : CDJSONBaseNetworkService

- (void)loadChangePWDWith:(NSDictionary *)params;

@end
