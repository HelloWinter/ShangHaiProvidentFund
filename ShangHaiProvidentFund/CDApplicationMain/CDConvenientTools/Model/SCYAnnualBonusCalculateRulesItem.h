//
//  SCYAnnualBonusCalculateRulesItem.h
//  ProvidentFund
//
//  Created by cdd on 17/1/17.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "CDBaseItem.h"

@interface SCYAnnualBonusCalculateRulesItem : CDBaseItem

@property (nonatomic, copy) NSString *left;
@property (nonatomic, copy) NSString *center;
@property (nonatomic, copy) NSString *right;

+ (SCYAnnualBonusCalculateRulesItem *)itemWithLeft:(NSString *)left center:(NSString *)center right:(NSString *)right;

@end
