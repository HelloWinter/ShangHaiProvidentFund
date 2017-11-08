//
//  CDLoginModel.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/12.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"


@interface CDLoginModel : CDBaseItem

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *loaninfo;
@property (nonatomic, copy) NSString *datatime;
@property (nonatomic, copy) NSArray *basic;
@property (nonatomic, copy) NSArray *supply;
@property (nonatomic, copy) NSArray *basicpridetail;
@property (nonatomic, copy) NSArray *supplypridetail;
@property (nonatomic, copy) NSArray *account;
@property (nonatomic, copy) NSArray *dynamicdetail;

@end
