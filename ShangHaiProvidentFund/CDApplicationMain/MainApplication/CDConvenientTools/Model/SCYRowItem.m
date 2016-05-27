//
//  SCYRowItem.m
//  ProvidentFund
//
//  Created by cdd on 16/2/29.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYRowItem.h"
#import "SCYSubItem.h"

@implementation SCYRowItem

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"radiosubitemsdata" : @"SCYSubItem",
             };
}

@end
