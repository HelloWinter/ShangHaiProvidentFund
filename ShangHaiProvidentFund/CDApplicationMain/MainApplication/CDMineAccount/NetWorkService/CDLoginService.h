//
//  CDLoginService.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDJSONBaseNetworkService.h"


@class CDLoginModel;

@interface CDLoginService : CDJSONBaseNetworkService

@property (nonatomic, strong, readonly) CDLoginModel *loginModel;

- (void)loadWithParams:(NSDictionary *)params showIndicator:(BOOL)show;

@end
