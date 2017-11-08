//
//  SCYMortgageCalculatorSelectCell.h
//  ProvidentFund
//
//  Created by cdd on 16/3/21.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@class SCYMortgageCalculatorCellItem;

@interface SCYMortgageCalculatorSelectCell : CDBaseTableViewCell

- (void)setupCellItem:(SCYMortgageCalculatorCellItem *)item indexPath:(NSIndexPath *)path;

@end
