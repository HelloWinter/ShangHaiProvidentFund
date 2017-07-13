//
//  CDHouseLoanRateModel.h
//  ShangHaiProvidentFund
//
//  Created by cd on 2017/7/13.
//  Copyright © 2017年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDHouseLoanRateModel : CDBaseItem

@property (nonatomic, copy) NSArray *businessloan;//商贷利率列表
@property (nonatomic, copy) NSString *lessfive;//公积金贷款利率（贷款期限<=5年）
@property (nonatomic, copy) NSString *morefive;//公积金贷款利率（贷款期限>5年）

@end
