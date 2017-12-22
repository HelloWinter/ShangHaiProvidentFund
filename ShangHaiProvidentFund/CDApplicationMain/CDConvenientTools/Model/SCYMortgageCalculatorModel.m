//
//  SCYMortgageCalculatorModel.m
//  ProvidentFund
//
//  Created by cdd on 16/3/18.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYMortgageCalculatorModel.h"
#import "SCYMortgageCalculatorCellItem.h"
#import "NSData+CommonCrypto.h"

@implementation SCYMortgageCalculatorModel

- (instancetype)init{
    self =[super init];
    if (self) {
        NSString *filepath=[[NSBundle mainBundle]pathForResource:@"mortgageCalculator.conf" ofType:nil];
        NSData *data=[NSData dataWithContentsOfFile:filepath];
        
        NSError *decryptedError=nil;
        NSData *decryptedData=[data decryptedAES256DataUsingKey:@"NSCachesDirectory" error:&decryptedError];
        
        if (!decryptedError) {
            NSError *error=nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:decryptedData options:(NSJSONReadingMutableContainers) error:&error];
            if (!error) {
                NSArray *arrprovidentfundloan=[dict objectForKey:@"providentfundloan"];
                _providentfundloan=[SCYMortgageCalculatorCellItem mj_objectArrayWithKeyValuesArray:arrprovidentfundloan];
                NSArray *arrbusinessloan=[dict objectForKey:@"businessloan"];
                _businessloan=[SCYMortgageCalculatorCellItem mj_objectArrayWithKeyValuesArray:arrbusinessloan];
                NSArray *arrcombinedloan=[dict objectForKey:@"combinedloan"];
                _combinedloan=[SCYMortgageCalculatorCellItem mj_objectArrayWithKeyValuesArray:arrcombinedloan];
            }
        }
    }
    return self;
}



@end
