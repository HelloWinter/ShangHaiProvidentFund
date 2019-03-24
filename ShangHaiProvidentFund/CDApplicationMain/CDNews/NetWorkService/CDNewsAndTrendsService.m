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

- (void)loadNewsAndTrendsIgnoreCache:(BOOL)ignore showIndicator:(BOOL)show{
    self.toCacheData=YES;
    self.ignoreCache=ignore;
    self.showLodingIndicator=show;
    self.httpRequestMethod=kHttpRequestTypeGET;
    self.printLog=NO;
    CDLog(@"%@",KMobileNews);
    [self request:KMobileNews params:nil];//CDURLWithAPI(@"/gjjManager/mobileNews?")
}

- (void)requestDidFinish:(id)rootData{
    [super requestDidFinish:rootData];
    NSArray *arr=(NSArray *)rootData;
    _arrData=[CDNewsAndTrendsItem mj_objectArrayWithKeyValuesArray:arr];
}

@end
