//
//  CDAccountBasicInfoCell.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@class CDAccountInfoItem;

@interface CDAccountBasicInfoCell : CDBaseTableViewCell

+ (instancetype)basicInfoCell;

- (void)setupCellItem:(CDAccountInfoItem *)item isLogined:(BOOL)islogined;

@end
