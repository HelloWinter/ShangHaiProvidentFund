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
    
    CDAboutUsItem *item3_1=[CDAboutUsItem itemWithImgName:@"aboutus_forget" title:@"遗忘密码" detail:@""];
    CDAboutUsItem *item3_2=[CDAboutUsItem itemWithImgName:@"aboutus_phonefind" title:@"手机取回用户名和密码" detail:@""];
    CDAboutUsItem *item3_3=[CDAboutUsItem itemWithImgName:@"aboutus_collection" title:@"个人公积金账号查询" detail:@""];
    
    CDAboutUsItem *item0_0=[CDAboutUsItem itemWithImgName:@"aboutus_privacy" title:@"隐私声明" detail:@""];
    CDAboutUsItem *item0_1=[CDAboutUsItem itemWithImgName:@"aboutus_leavemessage" title:@"在线留言" detail:@""];
    
    CDAboutUsItem *item1_1=[CDAboutUsItem itemWithImgName:@"aboutus_serviceTel" title:@"服务热线" detail:@"12329"];
    CDAboutUsItem *item1_2=[CDAboutUsItem itemWithImgName:@"aboutus_help" title:@"帮助信息" detail:@""];
    
    CDAboutUsItem *item2_0=[CDAboutUsItem itemWithImgName:@"aboutus_tweibo" title:@"上海公积金微博(新浪)" detail:@""];
    
//    CDAboutUsItem *item2_1=[CDAboutUsItem itemWithImgName:@"aboutus_tqq" title:@"上海公积金微博(腾讯)" detail:@""];
    
    [self.arrData addObjectsFromArray:@[@[item3_1,item3_2,item3_3],@[item0_0,item0_1],@[item1_1,item1_2],@[item2_0]]];
}

@end
