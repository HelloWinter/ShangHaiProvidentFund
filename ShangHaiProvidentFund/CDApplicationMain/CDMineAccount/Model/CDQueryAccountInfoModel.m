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
    
    CDConvenientToolsItem *item1=[CDConvenientToolsItem itemWithImageName:@"" title:@"账户明细"];//mine_account2
    
    CDConvenientToolsItem *item2=[CDConvenientToolsItem itemWithImageName:@"" title:@"贷款信息"];//mine_account3
    CDConvenientToolsItem *item7=[CDConvenientToolsItem itemWithImageName:@"" title:@"冲还贷信息"];//mine_account8
    
//    CDConvenientToolsItem *item4=[CDConvenientToolsItem itemWithImageName:@"" title:@"贷款进度"];//mine_account5
    
//    CDConvenientToolsItem *item3=[CDConvenientToolsItem itemWithImageName:@"mine_account4" title:@"模拟查询"];
//    CDConvenientToolsItem *item5=[CDConvenientToolsItem itemWithImageName:@"" title:@"关于我们"];//mine_account6
    
    CDConvenientToolsItem *item6=[CDConvenientToolsItem itemWithImageName:@"" title:@"修改密码"];
    CDConvenientToolsItem *item8=[CDConvenientToolsItem itemWithImageName:@"" title:@"遗忘密码"];
    CDConvenientToolsItem *item9=[CDConvenientToolsItem itemWithImageName:@"" title:@"手机取回用户名和密码"];
    CDConvenientToolsItem *item10=[CDConvenientToolsItem itemWithImageName:@"" title:@"个人公积金账号查询"];
    
    [self.arrData addObjectsFromArray:@[@[item1],@[item2,item7],@[item6,item8,item9,item10]]];//@[item0],@[item4],
}

@end
