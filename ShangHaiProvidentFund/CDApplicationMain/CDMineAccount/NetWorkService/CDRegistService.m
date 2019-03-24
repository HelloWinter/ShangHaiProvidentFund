//
//  CDRegistService.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDRegistService.h"

@implementation CDRegistService

- (void)loadWithParams:(NSDictionary *)params showIndicator:(BOOL)show{
    self.showLodingIndicator=show;
    NSMutableDictionary *dict=[params mutableCopy];
    [dict cd_safeSetObject:@"I" forKey:@"userlevel"];
    [dict cd_safeSetObject:@"5" forKey:@"sourcetype"];
    [self request:KRegister params:dict];//CDURLWithAPI(@"/gjjManager/register1")
}

- (void)requestDidFinish:(id)rootData{
    [super requestDidFinish:rootData];
    
}

@end
