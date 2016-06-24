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

- (void)setupCellItem:(CDNewsItem *)item;

@end
