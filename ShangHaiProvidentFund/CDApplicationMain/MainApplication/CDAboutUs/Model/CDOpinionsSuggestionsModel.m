//
//  CDOpinionsSuggestionsModel.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDOpinionsSuggestionsModel.h"
#import "CDOpinionsSuggestionsItem.h"

@implementation CDOpinionsSuggestionsModel

- (instancetype)init{
    self = [super init];
    if (self) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"OpinionsSuggestionsConfigure" ofType:@"json"];
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
