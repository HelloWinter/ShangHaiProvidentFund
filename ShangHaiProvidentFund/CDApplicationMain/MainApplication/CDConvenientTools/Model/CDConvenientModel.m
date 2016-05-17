//
//  CDConvenientModel.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDConvenientModel.h"
#import "CDConvenientToolsItem.h"

@implementation CDConvenientModel

- (instancetype)init{
    self=[super init];
    if (self) {
        [self setupArrdata];
    }
    return self;
}

- (void)setupArrdata{
    CDConvenientToolsItem *item0=[CDConvenientToolsItem itemWithImageName:@"convenient_tool1" title:@"业务网点"];
    CDConvenientToolsItem *item1=[CDConvenientToolsItem itemWithImageName:@"convenient_tool2" title:@"业务办理"];
    CDConvenientToolsItem *item2=[CDConvenientToolsItem itemWithImageName:@"convenient_tool3" title:@"历年缴存表"];
    CDConvenientToolsItem *item3=[CDConvenientToolsItem itemWithImageName:@"convenient_tool4" title:@"缴存计算"];
    CDConvenientToolsItem *item4=[CDConvenientToolsItem itemWithImageName:@"convenient_tool5" title:@"额度试算"];
    CDConvenientToolsItem *item5=[CDConvenientToolsItem itemWithImageName:@"convenient_tool6" title:@"房贷计算"];
    CDConvenientToolsItem *item6=[CDConvenientToolsItem itemWithImageName:@"convenient_tool7" title:@"更多计算"];
    CDConvenientToolsItem *item7=[CDConvenientToolsItem itemWithImageName:@"convenient_tool8" title:@"叫号信息"];
    CDConvenientToolsItem *item8=[CDConvenientToolsItem itemWithImageName:@"mine_account7" title:@"公益短信"];
    [self.arrData addObjectsFromArray:@[item0,item1,item2,item3,item4,item5,item6,item7,item8]];
}

@end
