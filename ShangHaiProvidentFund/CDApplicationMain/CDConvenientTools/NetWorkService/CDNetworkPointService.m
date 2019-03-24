//
//  CDNetworkPointService.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDNetworkPointService.h"
#import "CDNetworkPointItem.h"

@implementation CDNetworkPointService

- (void)loadNetworkPointIgnoreCache:(BOOL)ignore ShowIndicator:(BOOL)show{
    self.showLodingIndicator=show;
    self.toCacheData=YES;
    self.ignoreCache=ignore;
    self.httpRequestMethod=kHttpRequestTypeGET;
    [self request:KGjjManagerPoint params:nil];//CDURLWithAPI(@"/gjjManager/point")
}

- (void)requestDidFinish:(id)rootData{
    [super requestDidFinish:rootData];
    NSDictionary *dict=(NSDictionary *)rootData;
    NSArray *arr=[dict objectForKey:@"pointinfo"];
    _arrData = [CDNetworkPointItem mj_objectArrayWithKeyValuesArray:arr];
}

@end
