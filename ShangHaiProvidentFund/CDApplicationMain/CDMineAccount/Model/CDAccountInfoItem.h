//
//  CDAccountInfoItem.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDAccountInfoItem : CDBaseItem

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *last_pay_month;
@property (nonatomic, copy) NSString *surplus_def;
@property (nonatomic, copy) NSString *open_date;
@property (nonatomic, copy) NSString *pri_account;
@property (nonatomic, copy) NSString *unit_code;
@property (nonatomic, copy) NSString *unit_name;
@property (nonatomic, copy) NSString *month_pay;

@end
