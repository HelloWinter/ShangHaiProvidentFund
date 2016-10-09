//
//  CDLoginModel.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/12.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDLoginModel.h"
#import "CDAccountInfoItem.h"
#import "CDAccountDetailItem.h"
#import "CDPayAccountItem.h"
#import "CDDynamicdetailItem.h"


@implementation CDLoginModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"basic" : @"CDAccountInfoItem",
             @"supply" : @"CDAccountInfoItem",
             @"basicpridetail" : @"CDAccountDetailItem",
             @"supplypridetail" : @"CDAccountDetailItem",
             @"account" : @"CDPayAccountItem",
             @"dynamicdetail" : @"CDDynamicdetailItem"
             };
}

MJExtensionCodingImplementation

@end
