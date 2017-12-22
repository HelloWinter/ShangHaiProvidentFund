//
//  SCYAnnualBonusResultCell.h
//  ProvidentFund
//
//  Created by cdd on 17/1/17.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "CDBaseTableViewCell.h"
#import "SCYAnnualBonusCalculateTool.h"

@interface SCYAnnualBonusResultCell : CDBaseTableViewCell

- (void)setupWithBeforeTax:(double)before afterTax:(double)after type:(SCYAnnualBonusCalculateType)type showTips:(BOOL)show indexPath:(NSIndexPath *)path;

@end
