//
//  CDChangePSWService.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDChangePSWService.h"
#import "NSDictionary+CDDictionaryAdditions.h"

@implementation CDChangePSWService

- (void)loadChangePWDWith:(NSDictionary *)params{
    self.httpRequestMethod=kHttpRequestTypeGET;
    NSString *strParam=[params cd_transformToParamStringWithMethod:(kHttpRequestTypeGET)];
    NSString *strURL=[NSString stringWithFormat:@"%@%@",KChangePwdServlet,strParam];//CDURLWithAPI(@"/gjjManager/ChangePwdServlet")
    self.showLodingIndicator=YES;
    [self request:strURL params:nil];
}

- (void)requestDidFinish:(id)rootData{
    NSDictionary *dict=(NSDictionary *)rootData;
    NSString *str=[dict objectForKey:@"result"];
    if ([str isEqualToString:@"0"]) {
        CDLog(@"修改成功");
    }else{
        CDLog(@"修改失败");
    }
}

@end
