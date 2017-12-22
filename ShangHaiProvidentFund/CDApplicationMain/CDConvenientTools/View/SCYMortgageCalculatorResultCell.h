//
//  SCYMortgageCalculatorResultCell.h
//  ProvidentFund
//
//  Created by cdd on 16/3/21.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@interface SCYMortgageCalculatorResultCell : CDBaseTableViewCell

+ (instancetype)resultCell;

- (void)setupPayAllMoney:(CGFloat)allMoney monthNumber:(NSInteger)monthNum interest:(CGFloat)interest monthPay:(CGFloat)monthPay payType:(CGFloat)paytype;

@end
