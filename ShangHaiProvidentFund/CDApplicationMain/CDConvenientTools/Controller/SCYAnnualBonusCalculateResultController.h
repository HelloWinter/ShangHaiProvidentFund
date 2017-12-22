//
//  SCYAnnualBonusCalculateResultController.h
//  ProvidentFund
//
//  Created by Cheng on 17/1/15.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "CDBaseTableViewController.h"
#import "SCYAnnualBonusCalculateTool.h"


@interface SCYAnnualBonusCalculateResultController : CDBaseTableViewController

@property (nonatomic, assign) SCYAnnualBonusCalculateType bonusCalculateType;
@property (nonatomic, copy) NSArray *arrData;

@end
