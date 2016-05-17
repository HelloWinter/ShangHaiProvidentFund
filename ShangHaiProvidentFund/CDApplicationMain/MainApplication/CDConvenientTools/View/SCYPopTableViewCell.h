//
//  SCYPopTableViewCell.h
//  ProvidentFund
//
//  Created by cdd on 16/3/21.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@class SCYLoanRateItem;

@interface SCYPopTableViewCell : CDBaseTableViewCell

- (void)setupCellItem:(SCYLoanRateItem *)item indexPath:(NSIndexPath *)path;

@end
