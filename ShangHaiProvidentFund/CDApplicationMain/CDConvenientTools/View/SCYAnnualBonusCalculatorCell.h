//
//  SCYAnnualBonusCalculatorCell.h
//  ProvidentFund
//
//  Created by Cheng on 17/1/15.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "CDBaseTextFieldCell.h"

@interface SCYAnnualBonusCalculatorCell : CDBaseTextFieldCell

- (void)setupLeftText:(NSString *)left indexPath:(NSIndexPath *)path;

- (void)setupTextFieldText:(NSString *)text;

@end
