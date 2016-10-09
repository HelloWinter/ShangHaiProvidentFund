//
//  CDLoginConfigureModel.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDLoginConfigureModel.h"
#import "CDOpinionsSuggestionsItem.h"
#import "NSData+CommonCrypto.h"

@implementation CDLoginConfigureModel

- (instancetype)init{
    self =[super init];
    if (self) {
        NSString *filepath=[[NSBundle mainBundle]pathForResource:@"loginConfigure.conf" ofType:nil];
        NSData *data=[NSData dataWithContentsOfFile:filepath];
        NSError *decryptedError=nil;
        NSData *decryptedData=[data decryptedAES256DataUsingKey:@"NSCachesDirectory" error:&decryptedError];
        if (!decryptedError) {
            NSError *error=nil;
            NSArray *arr=[NSJSONSerialization JSONObjectWithData:decryptedData options:(NSJSONReadingMutableContainers) error:&error];
            if (!error) {
                [self.arrData addObjectsFromArray:[CDOpinionsSuggestionsItem mj_objectArrayWithKeyValuesArray:arr]];
            }
        }
    }
    return self;
}

@end
