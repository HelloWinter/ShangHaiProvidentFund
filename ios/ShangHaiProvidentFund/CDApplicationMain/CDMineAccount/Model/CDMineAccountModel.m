//
//  CDMineAccountModel.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/4.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDMineAccountModel.h"
#import "CDConvenientToolsItem.h"

@implementation CDMineAccountModel

- (instancetype)init{
    self=[super init];
    if (self) {
        [self setupArrdata];
    }
    return self;
}

- (void)setupArrdata{
    CDConvenientToolsItem *item0=[CDConvenientToolsItem itemWithImageName:@"mine_account1" title:@"个人账户"];
    CDConvenientToolsItem *item1=[CDConvenientToolsItem itemWithImageName:@"mine_account2" title:@"账户明细"];
    CDConvenientToolsItem *item2=[CDConvenientToolsItem itemWithImageName:@"mine_account3" title:@"贷款信息"];
    CDConvenientToolsItem *item3=[CDConvenientToolsItem itemWithImageName:@"mine_account4" title:@"模拟查询"];
    CDConvenientToolsItem *item4=[CDConvenientToolsItem itemWithImageName:@"mine_account5" title:@"贷款进度"];
    CDConvenientToolsItem *item5=[CDConvenientToolsItem itemWithImageName:@"mine_account6" title:@"用户管理"];
    CDConvenientToolsItem *item6=[CDConvenientToolsItem itemWithImageName:@"mine_account7" title:@"公益短信"];
    CDConvenientToolsItem *item7=[CDConvenientToolsItem itemWithImageName:@"mine_account8" title:@"冲还贷信息"];
    [self.arrData addObjectsFromArray:@[item0,item1,item2,item3,item4,item5,item6,item7]];
}

@end
