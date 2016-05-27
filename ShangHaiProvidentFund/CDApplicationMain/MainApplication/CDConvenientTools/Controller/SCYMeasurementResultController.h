//
//  SCYGuideMeasurementController.h
//  ProvidentFund
//
//  Created by cdd on 15/12/23.
//  Copyright © 2015年 9188. All rights reserved.
//

//贷款或提取测算结果


#import "CDBaseTableViewController.h"
#import "CDLoanExtractConfigure.h"


@interface SCYMeasurementResultController : CDBaseTableViewController

/**
 *  提取（贷款）测算（必传）
 */
@property (nonatomic, assign) SCYGuideMeasurementType guideMeasurementType;


@end
