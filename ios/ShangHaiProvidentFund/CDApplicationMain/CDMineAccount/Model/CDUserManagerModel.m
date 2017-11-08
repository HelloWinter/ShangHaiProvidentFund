//
//  CDUserManagerModel.m
//  ShangHaiProvidentFund
//
//  Created by cd on 2017/7/17.
//  Copyright © 2017年 cheng dong. All rights reserved.
//

#import "CDUserManagerModel.h"
#import "CDAboutUsItem.h"

@implementation CDUserManagerModel

- (instancetype)init{
    self =[super init];
    if (self) {
        [self setupArrData];
    }
    return self;
}

- (void)setupArrData{
    CDAboutUsItem *item3_0=[CDAboutUsItem itemWithImgName:@"ico_change" title:@"修改密码" detail:@""];
    CDAboutUsItem *item3_1=[CDAboutUsItem itemWithImgName:@"aboutus_forget" title:@"遗忘密码" detail:@""];
    CDAboutUsItem *item3_2=[CDAboutUsItem itemWithImgName:@"aboutus_phonefind" title:@"手机取回用户名和密码" detail:@""];
    CDAboutUsItem *item3_3=[CDAboutUsItem itemWithImgName:@"aboutus_collection" title:@"个人公积金账号查询" detail:@""];
    [self.arrData addObjectsFromArray:@[@[item3_0,item3_1,item3_2,item3_3]]];//,
}
@end
