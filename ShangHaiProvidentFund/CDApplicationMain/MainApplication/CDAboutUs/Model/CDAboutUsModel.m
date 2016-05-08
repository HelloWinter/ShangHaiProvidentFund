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
    CDAboutUsItem *item0_0=[CDAboutUsItem itemWithImgName:@"aboutus_privacy" title:@"隐私声明" detail:@""];
    CDAboutUsItem *item0_1=[CDAboutUsItem itemWithImgName:@"aboutus_leavemessage" title:@"在线留言" detail:@""];
    
//    CDAboutUsItem *item1_0=[CDAboutUsItem itemWithImgName:@"aboutus_version" title:@"当前版本" detail:CDAppVersion];
    CDAboutUsItem *item1_1=[CDAboutUsItem itemWithImgName:@"aboutus_serviceTel" title:@"服务热线" detail:@"12329"];
    CDAboutUsItem *item1_2=[CDAboutUsItem itemWithImgName:@"aboutus_help" title:@"帮助信息" detail:@""];
    CDAboutUsItem *item1_3=[CDAboutUsItem itemWithImgName:@"aboutus_collection" title:@"新闻收藏" detail:@""];
    
    CDAboutUsItem *item2_0=[CDAboutUsItem itemWithImgName:@"aboutus_tweibo" title:@"上海公积金微博(新浪)" detail:@""];
    
//    CDAboutUsItem *item2_1=[CDAboutUsItem itemWithImgName:@"aboutus_tqq" title:@"上海公积金微博(腾讯)" detail:@""];
    
    [self.arrData addObjectsFromArray:@[@[item0_0,item0_1],@[item1_1,item1_2,item1_3],@[item2_0]]];
}

@end
