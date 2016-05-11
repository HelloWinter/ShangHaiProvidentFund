//
//  CDLoginConfigureModel.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDLoginConfigureModel.h"
#import "CDOpinionsSuggestionsItem.h"

@implementation CDLoginConfigureModel

- (instancetype)init{
    self =[super init];
    if (self) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"loginConfigure" ofType:@"json"];
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
