//
//  CDForgotPWDResetService.m
//  ShangHaiProvidentFund
//
//  Created by cd on 2017/9/11.
//  Copyright © 2017年 cheng dong. All rights reserved.
//

#import "CDForgotPWDResetService.h"
#import "NSDictionary+CDDictionaryAdditions.h"

@implementation CDForgotPWDResetService

- (void)loadResetServiceWithParams:(NSDictionary *)dict{
    self.autoJSONDataSerializer=NO;
    self.httpRequestMethod=kHttpRequestTypeGET;
    NSString *str=[dict cd_TransformToParamStringWithMethod:(kHttpRequestTypeGET)];
    //@"https://persons.shgjj.com/MainServlet?ID=21&id_card_num=411082199003055430&newpwd_md5=e10adc3949ba59abbe56e057f20f883e&pri_account=158489445205&userid=HelloWinter"
    NSString *strurl=[NSString stringWithFormat:@"https://persons.shgjj.com/MainServlet%@",str];
    [self request:strurl params:nil];
}

- (void)requestDidFinish:(id)rootData{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str=[[NSString alloc]initWithData:rootData encoding:(enc)];
    if ([str containsString:@"成功"]) {//@"用户密码恢复成功，请重新登录！"
        self.returnCode = 1;
        CDLog(@"成功");
    }else{
        self.returnCode = 0;
        CDLog(@"失败");
    }
}

@end
