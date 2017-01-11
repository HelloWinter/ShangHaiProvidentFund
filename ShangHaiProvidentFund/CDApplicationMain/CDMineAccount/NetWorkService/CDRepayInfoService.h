//
//  CDRepayInfoService.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

/**
 *  冲还贷
 */

#import "CDJSONBaseNetworkService.h"

@interface CDRepayInfoService : CDJSONBaseNetworkService

//@property (nonatomic, copy, readonly) NSArray *basic;
//@property (nonatomic, copy, readonly) NSArray *chr;
@property (nonatomic, copy, readonly) NSArray *arrData;

- (void)loadWithAccountNum:(NSString *)accountNum ignoreCache:(BOOL)ignore showIndicator:(BOOL)show;

@end
