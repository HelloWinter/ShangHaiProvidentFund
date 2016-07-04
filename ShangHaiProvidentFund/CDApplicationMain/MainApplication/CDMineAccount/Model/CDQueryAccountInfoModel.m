//
//  CDQueryAccountInfoModel.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDQueryAccountInfoModel.h"
#import "CDConvenientToolsItem.h"
#import "CDAccountInfoItem.h"

@implementation CDQueryAccountInfoModel

- (instancetype)init{
    self=[super init];
    if (self) {
        [self setupArrdata];
    }
    return self;
}

- (void)setupArrdata{
//    CDConvenientToolsItem *item0=[CDConvenientToolsItem itemWithImageName:@"mine_account1" title:@"个人账户"];
    
    CDConvenientToolsItem *item1=[CDConvenientToolsItem itemWithImageName:@"mine_account2" title:@"账户明细"];
    
    CDConvenientToolsItem *item2=[CDConvenientToolsItem itemWithImageName:@"mine_account3" title:@"贷款信息"];
    CDConvenientToolsItem *item7=[CDConvenientToolsItem itemWithImageName:@"mine_account8" title:@"冲还贷信息"];
    
    CDConvenientToolsItem *item4=[CDConvenientToolsItem itemWithImageName:@"mine_account5" title:@"贷款进度"];
//    CDConvenientToolsItem *item3=[CDConvenientToolsItem itemWithImageName:@"mine_account4" title:@"模拟查询"];
//    CDConvenientToolsItem *item5=[CDConvenientToolsItem itemWithImageName:@"mine_account6" title:@"用户管理"];
    
    [self.arrData addObjectsFromArray:@[@[item1],@[item2,item7],@[item4]]];//@[item0],
}

@end
