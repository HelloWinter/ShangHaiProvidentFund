//
//  SCYMortgageCalculatorController.h
//  ProvidentFund
//
//  Created by cdd on 16/3/17.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseTableViewController.h"

typedef NS_ENUM(NSUInteger,SCYMortgageType) {
    /**
     *  公积金贷款
     */
    SCYMortgageTypeProvidentFundLoan,
    /**
     *  商业贷款
     */
    SCYMortgageTypeCommercialLoan,
    /**
     *  组合贷款
     */
    SCYMortgageTypeCombinedLoan
};

@interface SCYMortgageCalculatorController : CDBaseTableViewController



@end
