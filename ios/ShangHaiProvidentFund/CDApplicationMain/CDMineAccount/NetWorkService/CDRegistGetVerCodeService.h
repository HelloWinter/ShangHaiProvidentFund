//
//  CDRegistGetVerCodeService.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

//获取注册验证码

#import "CDJSONBaseNetworkService.h"

@interface CDRegistGetVerCodeService : CDJSONBaseNetworkService

@property (nonatomic, copy, readonly) NSString *code;
@property (nonatomic, copy, readonly) NSString *msg;

- (void)loadWithMobileNum:(NSString *)mobileNum showIndicator:(BOOL)show;

@end
