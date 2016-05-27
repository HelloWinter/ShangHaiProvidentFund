//
//  SCYPageItem.m
//  ProvidentFund
//
//  Created by cdd on 16/3/2.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYPageItem.h"
#import "SCYSectionItem.h"
#import "SCYActionItem.h"
#import "SCYButtonItem.h"

@implementation SCYPageItem

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"button" : @"SCYButtonItem",
             @"data" : @"SCYSectionItem",
             @"action" : @"SCYActionItem",
             };
}

@end
