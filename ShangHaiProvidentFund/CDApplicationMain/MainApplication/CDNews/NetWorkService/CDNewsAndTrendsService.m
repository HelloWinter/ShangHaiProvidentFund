//
//  CDNewsAndTrendsService.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDNewsAndTrendsService.h"
#import "CDNewsAndTrendsItem.h"
#import "CDNewsItem.h"

@implementation CDNewsAndTrendsService

- (void)loadNewsAndTrendsShowIndicator:(BOOL)show{
    self.showLodingIndicator=show;
    self.httpRequestMethod=kHttpRequestTypeGET;
    [self request:CDURLWithAPI(@"/gjjManager/mobileNews?") params:nil];
}

- (void)requestDidFinish:(id)rootData{
    NSArray *arr=(NSArray *)rootData;
    _arrData=[CDNewsAndTrendsItem mj_objectArrayWithKeyValuesArray:arr];
}

@end
