//
//  SCYMortgageCalculatorCellItem.h
//  ProvidentFund
//
//  Created by cdd on 16/3/18.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseItem.h"

@interface SCYMortgageCalculatorCellItem : CDBaseItem

@property (nonatomic, copy) NSString *paramkey;
@property (nonatomic, copy) NSString *paramtype;
@property (nonatomic, copy) NSString *paramvalue;
@property (nonatomic, copy) NSString *paramdesc;
@property (nonatomic, copy) NSString *paramunit;
@property (nonatomic, copy) NSString *paramunitvalue;
@property (nonatomic, copy) NSString *paramemptytip;
@property (nonatomic, copy) NSString *paramselect;
@property (nonatomic, strong) NSMutableArray *paramsubitemsdata;

@end
