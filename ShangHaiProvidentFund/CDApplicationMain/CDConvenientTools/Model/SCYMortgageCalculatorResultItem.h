//
//  SCYMortgageCalculatorResultItem.h
//  ProvidentFund
//
//  Created by cdd on 16/3/21.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseItem.h"

@interface SCYMortgageCalculatorResultItem : CDBaseItem

@property (nonatomic, assign) CGFloat capitalization;//贷款额（元）
@property (nonatomic, assign) CGFloat payType;//还款类型 : 0,等额本息，1,等额本金

@property (nonatomic, assign) NSInteger duetime;//贷款期限（月）
@property (nonatomic, assign) CGFloat totalInterest;//总利息
@property (nonatomic, assign) CGFloat totalRepayment;//总应还
@property (nonatomic, assign) CGFloat monthlyRepayment;//月供(等额本息),首月供(等额本金)

@end
