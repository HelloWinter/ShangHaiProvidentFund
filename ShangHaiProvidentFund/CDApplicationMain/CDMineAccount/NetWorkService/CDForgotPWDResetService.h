//
//  CDForgotPWDResetService.h
//  ShangHaiProvidentFund
//
//  Created by cd on 2017/9/11.
//  Copyright © 2017年 cheng dong. All rights reserved.
//

#import "CDJSONBaseNetworkService.h"

@interface CDForgotPWDResetService : CDJSONBaseNetworkService

- (void)loadResetServiceWithParams:(NSDictionary *)dict;

@end
