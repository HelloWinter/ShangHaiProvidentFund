//
//  SCYAnnualBonusCalculateRulesItem.h
//  ProvidentFund
//
//  Created by cdd on 17/1/17.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "CDBaseItem.h"

@interface SCYAnnualBonusCalculateRulesItem : CDBaseItem

@property (nonatomic, copy, readonly) NSString *left;
@property (nonatomic, copy, readonly) NSString *center;
@property (nonatomic, copy, readonly) NSString *right;

+ (SCYAnnualBonusCalculateRulesItem *)itemWithLeft:(NSString *)left center:(NSString *)center right:(NSString *)right;

@end
