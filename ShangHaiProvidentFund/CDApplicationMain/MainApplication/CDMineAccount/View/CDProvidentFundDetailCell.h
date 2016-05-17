//
//  CDProvidentFundDetailCell.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@class CDAccountDetailItem;

@interface CDProvidentFundDetailCell : CDBaseTableViewCell

- (void)setupLeftWidth:(CGFloat)left centerWidth:(CGFloat)center rightWidth:(CGFloat)right;

- (void)setCellItem:(CDAccountDetailItem *)cellItem;

@end
