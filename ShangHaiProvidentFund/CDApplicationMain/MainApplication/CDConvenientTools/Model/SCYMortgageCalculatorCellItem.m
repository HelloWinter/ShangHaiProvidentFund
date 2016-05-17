//
//  SCYMortgageCalculatorCellItem.m
//  ProvidentFund
//
//  Created by cdd on 16/3/18.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYMortgageCalculatorCellItem.h"
#import "SCYLoanRateItem.h"

@implementation SCYMortgageCalculatorCellItem

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"paramsubitemsdata":@"SCYLoanRateItem"
             };
}

@end
