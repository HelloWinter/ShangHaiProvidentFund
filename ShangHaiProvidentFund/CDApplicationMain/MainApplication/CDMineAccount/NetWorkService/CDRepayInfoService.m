//
//  CDRepayInfoService.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDRepayInfoService.h"
#import "CDRepayInfoBasicItem.h"
#import "CDRepayInfoChrItem.h"
#import "CDAboutUsItem.h"

@interface CDRepayInfoService ()

@property (nonatomic, copy) NSDictionary *dict;

@end

@implementation CDRepayInfoService

- (void)loadWithAccountNum:(NSString *)accountNum ignoreCache:(BOOL)ignore showIndicator:(BOOL)show{
    self.showLodingIndicator=show;
    self.isNeedCache=YES;
    self.isIgnoreCache=ignore;
    self.httpRequestMethod=kHttpRequestTypeGET;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict cd_safeSetObject:accountNum forKey:@"pri_account"];
    [self request:CDURLWithAPI(@"/gjjManager/CHDSearchServlet") params:dict];
}

- (NSDictionary *)dict{
    if (_dict==nil) {
        _dict=@{
            @"bank_code" : @"受理银行",
            @"c_debt_account" : @"贷款账号(商业)",
            @"chd_type" : @"冲还贷方式",
            @"debt_account" : @"贷款账号(公积金)",
            @"debt_type" : @"贷款类型",
            @"sign_date" : @"签约日期",
            @"wts_code" : @"委托书编号",
            @"begin_date" : @"签约日期",
            @"hk_order" : @"还贷顺序",
            @"name" : @"姓名",
            @"relation_code" : @"与申请人关系"
            };
    }
    return _dict;
}

- (void)requestDidFinish:(id)rootData{
    [super requestDidFinish:rootData];
    _returnCode=[rootData objectForKey:@"CHD"];
    if ([_returnCode isEqualToString:@"0"]) {
        NSArray *arrbasic=[rootData objectForKey:@"basic"];
        
//        _basic = [CDRepayInfoBasicItem mj_objectArrayWithKeyValuesArray:arrbasic];
        
        NSArray *arrchr=[rootData objectForKey:@"chr"];
        
//        _chr = [CDRepayInfoChrItem mj_objectArrayWithKeyValuesArray:arrchr];
        
        NSMutableArray *arr1=[[NSMutableArray alloc]init];
        NSDictionary *dictbasic=[arrbasic firstObject];
        for (NSString *key in dictbasic.allKeys) {
            NSString *str=[NSString stringWithFormat:@"%@",[dictbasic objectForKey:key]];
            CDAboutUsItem *item=[CDAboutUsItem itemWithImgName:nil title:[self.dict objectForKey:key] detail:str];
            [arr1 addObject:item];
        }
        
        NSMutableArray *arr2=[[NSMutableArray alloc]init];
        NSDictionary *dicchr=[arrchr firstObject];
        for (NSString *key in dicchr.allKeys) {
            NSString *str=[NSString stringWithFormat:@"%@",[dicchr objectForKey:key]];
            CDAboutUsItem *item=[CDAboutUsItem itemWithImgName:nil title:[self.dict objectForKey:key] detail:str];
            [arr2 addObject:item];
        }
        _arrData=@[arr1,arr2];
    }
}

@end
