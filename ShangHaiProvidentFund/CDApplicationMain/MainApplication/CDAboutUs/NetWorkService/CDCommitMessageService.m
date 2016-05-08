//
//  CDOpinionsSuggestionsService.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDCommitMessageService.h"

@implementation CDCommitMessageService

- (void)loadWithParams:(NSDictionary *)params showIndicator:(BOOL)show{
    self.showLodingIndicator=show;
    NSMutableDictionary *dict=[params mutableCopy];
    [dict cd_safeSetObject:@"I" forKey:@"userlevel"];
    [self request:CDURLWithAPI(@"/gjjManager/feedBackServlet") params:dict];
}

- (void)requestDidFinish:(NSDictionary *)rootData{
    
}

@end
