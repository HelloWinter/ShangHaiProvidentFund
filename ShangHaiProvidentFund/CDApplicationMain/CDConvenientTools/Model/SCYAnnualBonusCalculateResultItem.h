//
//  SCYAnnualBonusCalculateResultItem.h
//  ProvidentFund
//
//  Created by cdd on 17/1/17.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "CDBaseItem.h"

@interface SCYAnnualBonusCalculateResultItem : CDBaseItem

@property (nonatomic, copy) NSNumber *before;
@property (nonatomic, copy) NSNumber *after;

+ (SCYAnnualBonusCalculateResultItem *)itemWithBefore:(NSNumber *)before after:(NSNumber *)after;

@end
