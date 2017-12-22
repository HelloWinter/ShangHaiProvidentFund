//
//  CDAboutUsModel.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/4.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDAboutUsModel.h"
#import "CDAboutUsItem.h"

@interface CDAboutUsModel ()

@end

@implementation CDAboutUsModel
- (instancetype)init{
    self =[super init];
    if (self) {
        [self setupArrData];
    }
    return self;
}

- (void)setupArrData{
//    CDAboutUsItem *item0_0=[CDAboutUsItem itemWithImgName:@"" title:@"隐私声明" detail:@""];//aboutus_privacy
    CDAboutUsItem *item0_1=[CDAboutUsItem itemWithImgName:@"" title:@"在线留言" detail:@""];//aboutus_leavemessage
    
    CDAboutUsItem *item1_1=[CDAboutUsItem itemWithImgName:@"" title:@"服务热线" detail:@"12329"];//aboutus_serviceTel
    CDAboutUsItem *item1_2=[CDAboutUsItem itemWithImgName:@"" title:@"帮助信息" detail:@""];//aboutus_help
    
//    CDAboutUsItem *item2_0=[CDAboutUsItem itemWithImgName:@"" title:@"上海公积金微博(新浪)" detail:@""];//aboutus_tweibo
    
//    CDAboutUsItem *item2_1=[CDAboutUsItem itemWithImgName:@"aboutus_tqq" title:@"上海公积金微博(腾讯)" detail:@""];
    
    [self.arrData addObjectsFromArray:@[@[item0_1],@[item1_1,item1_2]]];//item0_0,@[item3_1,item3_2,item3_3],,@[item2_0]
}

@end
