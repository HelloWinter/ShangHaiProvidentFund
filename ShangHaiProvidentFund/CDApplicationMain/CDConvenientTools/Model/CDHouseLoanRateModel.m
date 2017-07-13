//
//  CDHouseLoanRateModel.m
//  ShangHaiProvidentFund
//
//  Created by cd on 2017/7/13.
//  Copyright © 2017年 cheng dong. All rights reserved.
//

#import "CDHouseLoanRateModel.h"
#import "SCYLoanRateItem.h"

@implementation CDHouseLoanRateModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"businessloan":@"SCYLoanRateItem"};
}

@end
