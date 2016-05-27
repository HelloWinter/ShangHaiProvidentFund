//
//  SCYLoanConfigureItem.m
//  ProvidentFund
//
//  Created by cdd on 16/3/2.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYLoanConfigureItem.h"

@implementation SCYLoanConfigureItem

- (instancetype)init{
    self =[super init];
    if (self) {
        NSString *filepath=[[NSBundle mainBundle]pathForResource:@"loanmeasurement.json" ofType:nil];
        NSData *data=[NSData dataWithContentsOfFile:filepath];
        
        NSError *error=nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
        if (!error) {
            _pageKey1=[SCYPageItem mj_objectWithKeyValues:[dict objectForKey:@"pageKey1"]];
            _pageKey2=[SCYPageItem mj_objectWithKeyValues:[dict objectForKey:@"pageKey2"]];
            _pageKey3=[SCYPageItem mj_objectWithKeyValues:[dict objectForKey:@"pageKey3"]];
        }
    }
    return self;
}

@end
