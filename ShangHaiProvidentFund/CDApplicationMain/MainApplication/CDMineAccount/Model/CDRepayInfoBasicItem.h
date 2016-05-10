//
//  CDRepayInfoBasicItem.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/10.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDRepayInfoBasicItem : CDBaseItem

@property (nonatomic, copy) NSString *bank_code;
@property (nonatomic, copy) NSString *sign_date;
@property (nonatomic, copy) NSString *debt_type;
@property (nonatomic, copy) NSString *c_debt_account;
@property (nonatomic, copy) NSString *debt_account;
@property (nonatomic, copy) NSString *chd_type;
@property (nonatomic, copy) NSString *wts_code;

@end
