//
//  CDNewsAndTrendsCell.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@class CDNewsItem;

@interface CDNewsAndTrendsCell : CDBaseTableViewCell

+ (instancetype)newsAndTrendsCell;

- (void)setupCellItem:(CDNewsItem *)item;

@end
