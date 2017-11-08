//
//  CDProvidentFundDetailCell.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTableViewCell.h"

typedef NS_ENUM(NSUInteger,CDCellLayoutType){
    CDCellLayoutTypeAccountDetail,
    CDCellLayoutTypeLoanDetail
};

@class CDAccountDetailItem,CDDynamicdetailItem;

@interface CDProvidentFundDetailCell : CDBaseTableViewCell

@property (nonatomic, assign) CDCellLayoutType cellLayoutType;

- (void)setupAccountDetailItem:(CDAccountDetailItem *)cellItem;

- (void)setupLoanDetailItem:(CDDynamicdetailItem *)cellItem;

@end
