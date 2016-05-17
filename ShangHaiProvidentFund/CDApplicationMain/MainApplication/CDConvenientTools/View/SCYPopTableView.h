//
//  SCYPopTableView.h
//  ProvidentFund
//
//  Created by cdd on 16/3/21.
//  Copyright © 2016年 9188. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SCYPopTableViewType) {
    /**
     *  还款方式
     */
    SCYPopTableViewTypePayType,
    /**
     *  选择利率
     */
    SCYPopTableViewTypeSelectRate
};

@class SCYLoanRateItem,SCYMortgageCalculatorCellItem;

typedef void(^CellTouched)(NSInteger ,SCYMortgageCalculatorCellItem *);

@interface SCYPopTableView : UIView

@property (nonatomic, copy) CellTouched cellTouched;

- (void)setupViewData:(SCYMortgageCalculatorCellItem *)item popType:(SCYPopTableViewType)type indexPath:(NSIndexPath *)path;

- (void)show:(BOOL)animated;

- (void)dismiss:(BOOL)animated;

@end
