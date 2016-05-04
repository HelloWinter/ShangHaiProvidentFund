//
//  CDMineAccountModel.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/4.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDMineAccountModel.h"
#import "CDMineAccountItem.h"

@implementation CDMineAccountModel

- (instancetype)init{
    self=[super init];
    if (self) {
        [self setupArrdata];
    }
    return self;
}

- (void)setupArrdata{
    CDMineAccountItem *item0=[CDMineAccountItem itemWithImageName:@"" title:@"个人账户"];
    CDMineAccountItem *item1=[CDMineAccountItem itemWithImageName:@"" title:@"账户明细"];
    CDMineAccountItem *item2=[CDMineAccountItem itemWithImageName:@"" title:@"贷款信息"];
    CDMineAccountItem *item3=[CDMineAccountItem itemWithImageName:@"" title:@"模拟查询"];
    CDMineAccountItem *item4=[CDMineAccountItem itemWithImageName:@"" title:@"贷款进度"];
    CDMineAccountItem *item5=[CDMineAccountItem itemWithImageName:@"" title:@"用户管理"];
    CDMineAccountItem *item6=[CDMineAccountItem itemWithImageName:@"" title:@"公益短信"];
    CDMineAccountItem *item7=[CDMineAccountItem itemWithImageName:@"" title:@"冲还贷信息"];
    [self.arrData addObjectsFromArray:@[item0,item1,item2,item3,item4,item5,item6,item7]];
}

@end
