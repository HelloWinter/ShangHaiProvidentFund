//
//  CDRegistConfigureModel.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/12.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDRegistConfigureModel.h"
#import "CDOpinionsSuggestionsItem.h"

@implementation CDRegistConfigureModel

- (instancetype)init{
    self =[super init];
    if (self) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"registConfigure" ofType:@"json"];
        NSData *data=[NSData dataWithContentsOfFile:path];
        NSError *error=nil;
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
        if (!error) {
            [self.arrData addObjectsFromArray:[CDOpinionsSuggestionsItem mj_objectArrayWithKeyValuesArray:arr]];
        }
    }
    return self;
}

@end
