//
//  CDConvenientModel.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDConvenientModel.h"
#import "CDMineAccountItem.h"

@implementation CDConvenientModel

- (instancetype)init{
    self=[super init];
    if (self) {
        [self setupArrdata];
    }
    return self;
}

- (void)setupArrdata{
    CDMineAccountItem *item0=[CDMineAccountItem itemWithImageName:@"" title:@"业务网点"];
    CDMineAccountItem *item1=[CDMineAccountItem itemWithImageName:@"" title:@"业务办理"];
    CDMineAccountItem *item2=[CDMineAccountItem itemWithImageName:@"" title:@"历年缴存表"];
    CDMineAccountItem *item3=[CDMineAccountItem itemWithImageName:@"" title:@"缴存计算"];
    CDMineAccountItem *item4=[CDMineAccountItem itemWithImageName:@"" title:@"额度试算"];
    CDMineAccountItem *item5=[CDMineAccountItem itemWithImageName:@"" title:@"还款计算"];
    CDMineAccountItem *item6=[CDMineAccountItem itemWithImageName:@"" title:@"更多计算"];
    CDMineAccountItem *item7=[CDMineAccountItem itemWithImageName:@"" title:@"叫号信息"];
    [self.arrData addObjectsFromArray:@[item0,item1,item2,item3,item4,item5,item6,item7]];
}

@end
