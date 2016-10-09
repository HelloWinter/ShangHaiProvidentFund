//
//  CDPayAccountItem.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDPayAccountItem : CDBaseItem

@property (nonatomic, copy) NSString *debtaccount;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *opendate;
@property (nonatomic, copy) NSString *limit;
@property (nonatomic, copy) NSString *returnwaycode;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *surplus;
@property (nonatomic, copy) NSString *lastmonth;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *bankname;

@end
