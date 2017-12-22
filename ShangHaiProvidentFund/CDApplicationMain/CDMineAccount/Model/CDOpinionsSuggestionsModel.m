//
//  CDOpinionsSuggestionsModel.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDOpinionsSuggestionsModel.h"
#import "CDNormalTextFieldConfigureItem.h"
#import "NSData+CommonCrypto.h"

@implementation CDOpinionsSuggestionsModel

- (instancetype)init{
    self = [super init];
    if (self) {
        NSString *filepath=[[NSBundle mainBundle]pathForResource:@"OpinionsSuggestionsConfigure.conf" ofType:nil];
        NSData *data=[NSData dataWithContentsOfFile:filepath];
        NSError *decryptedError=nil;
        NSData *decryptedData=[data decryptedAES256DataUsingKey:@"NSCachesDirectory" error:&decryptedError];
        if (!decryptedError) {
            NSError *error=nil;
            NSArray *arr=[NSJSONSerialization JSONObjectWithData:decryptedData options:(NSJSONReadingMutableContainers) error:&error];
            if (!error) {
                [self.arrData addObjectsFromArray:[CDNormalTextFieldConfigureItem mj_objectArrayWithKeyValuesArray:arr]];
            }
        }
    }
    return self;
}

@end
