//
//  SCYMortgageCalculatorService.m
//  ProvidentFund
//
//  Created by cdd on 16/3/18.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYMortgageCalculatorService.h"
#import "SCYLoanRateItem.h"

@implementation SCYMortgageCalculatorService

- (void)loadWithIgnoreCache:(BOOL)ignore showIndicator:(BOOL) show{
    self.isNeedCache=YES;
    self.isIgnoreCache=ignore;
    self.showLodingIndicator=show;
    [self request:@"http://gjj.9188.com/gjj/gjjRate.go" params:nil];
}

- (void)requestDidFinish:(NSDictionary *)rootData{
    [super requestDidFinish:rootData];
    _returnCode =[NSString stringWithFormat:@"%@",[rootData objectForKey:@"code"]];
    _desc=[rootData objectForKey:@"desc"];
    if ([self.returnCode isEqualToString:@"1"]) {
        NSDictionary *dict=[rootData objectForKey:@"results"];
        _lessfive=[dict objectForKey:@"lessfive"];
        _morefive=[dict objectForKey:@"morefive"];
        NSArray *arr=[dict objectForKey:@"businessloan"];
        _businessloan=[SCYLoanRateItem mj_objectArrayWithKeyValuesArray:arr];
    }
}

@end
