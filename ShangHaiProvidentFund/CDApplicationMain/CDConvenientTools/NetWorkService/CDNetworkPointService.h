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

/**
 公积金中心网点

 @param ignore 是否忽略缓存
 @param show 是否显示网络加载提示
 */
- (void)loadNetworkPointIgnoreCache:(BOOL)ignore ShowIndicator:(BOOL)show;

@end
