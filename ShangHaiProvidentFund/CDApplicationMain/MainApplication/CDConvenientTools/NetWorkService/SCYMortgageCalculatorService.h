//
//  SCYMortgageCalculatorService.h
//  ProvidentFund
//
//  Created by cdd on 16/3/18.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDJSONBaseNetworkService.h"

@interface SCYMortgageCalculatorService : CDJSONBaseNetworkService

@property (nonatomic, copy, readonly) NSString *lessfive;//公积金贷款利率（贷款期限<=5年）
@property (nonatomic, copy, readonly) NSString *morefive;//公积金贷款利率（贷款期限>5年）
@property (nonatomic, copy, readonly) NSArray *businessloan;//商贷利率列表

/**
 *  获取房贷计算器利率
 *
 *  @param ignore 是否忽略缓存
 *  @param show   是否显示网络加载进度指示器
 */
- (void)loadWithIgnoreCache:(BOOL)ignore showIndicator:(BOOL) show;

@end
