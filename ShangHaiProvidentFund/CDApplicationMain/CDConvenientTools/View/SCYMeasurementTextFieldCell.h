//
//  SCYMeasurementTextFieldCell.h
//  ProvidentFund
//
//  Created by cdd on 15/12/25.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@class SCYRowItem,SCYMortgageCalculatorCellItem;

@interface SCYMeasurementTextFieldCell : CDBaseTableViewCell

- (void)setupLeftText:(NSString *)left RightText:(NSString *)right defaultText:(NSString *)defaultText IndexPath:(NSIndexPath *)path;

//- (void)setupRowItem:(SCYRowItem *)item IndexPath:(NSIndexPath *)path;

- (void)setupMortgageCalculatorCellItem:(SCYMortgageCalculatorCellItem *)item IndexPath:(NSIndexPath *)path;

- (void)setupTextFieldText:(NSString *)text;

- (NSString *)cellText;

- (void)textfieldBecomeFirstResponder;

@end