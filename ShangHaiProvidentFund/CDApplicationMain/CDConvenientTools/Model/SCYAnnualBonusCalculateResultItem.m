//
//  SCYAnnualBonusCalculateResultItem.m
//  ProvidentFund
//
//  Created by cdd on 17/1/17.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "SCYAnnualBonusCalculateResultItem.h"

@implementation SCYAnnualBonusCalculateResultItem

+ (SCYAnnualBonusCalculateResultItem *)itemWithBefore:(NSNumber *)before after:(NSNumber *)after{
    SCYAnnualBonusCalculateResultItem *item=[[SCYAnnualBonusCalculateResultItem alloc]init];
    item.before=before;
    item.after=after;
    return item;
}

@end
