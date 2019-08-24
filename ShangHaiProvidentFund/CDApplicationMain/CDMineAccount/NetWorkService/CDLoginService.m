//
//  CDLoginService.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDLoginService.h"
#import "CDLoginModel.h"

@implementation CDLoginService

- (void)loadWithParams:(NSDictionary *)params showIndicator:(BOOL)show{
    self.showLodingIndicator=show;
//    self.httpRequestMethod=kHttpRequestTypeGET;
    [self request:KPrivateBasic params:params];//CDURLWithAPI(@"/gjjManager/privateBasic")
}

- (void)requestDidFinish:(id)rootData{
    [super requestDidFinish:rootData];
    _loginModel=[CDLoginModel mj_objectWithKeyValues:rootData];
    if ([_loginModel.type isEqualToString:@"S"]) {
        [CDCacheManager saveUserLogined:YES];
        NSString *file = [CDCacheManager filePathforLoginInfo];
        [NSKeyedArchiver archiveRootObject:_loginModel toFile:file];
    }
}

@end
