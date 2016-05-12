//
//  CDRegistGetVerCodeService.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDRegistGetVerCodeService.h"

@implementation CDRegistGetVerCodeService

- (void)loadWithMobileNum:(NSString *)mobileNum showIndicator:(BOOL)show{
    self.showLodingIndicator=show;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict cd_safeSetObject:mobileNum forKey:@"mobile"];
    [dict cd_safeSetObject:@"7" forKey:@"sourcetype"];
    [self request:CDURLWithAPI(@"/SendSmsServlet") params:dict];
}

- (void)requestDidFinish:(id)rootData{
    [super requestDidFinish:rootData];
    
}

@end
