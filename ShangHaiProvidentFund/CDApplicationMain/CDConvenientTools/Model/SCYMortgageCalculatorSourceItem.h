//
//  SCYMortgageCalculatorSourceItem.h
//  ProvidentFund
//
//  Created by cdd on 16/3/21.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseItem.h"

@interface SCYMortgageCalculatorSourceItem : CDBaseItem

@property (nonatomic, assign) CGFloat capitalization; //贷款额（元）
@property (nonatomic, assign) CGFloat rate;//年利率
@property (nonatomic, assign) CGFloat payType;//还款类型 :0,等额本息，1,等额本金
@property (nonatomic, assign) NSInteger duetime;//贷款期限（月）

@end
