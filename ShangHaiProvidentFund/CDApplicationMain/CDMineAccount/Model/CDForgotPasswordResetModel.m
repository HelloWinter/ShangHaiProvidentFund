//
//  CDForgotPasswordResetModel.m
//  ShangHaiProvidentFund
//
//  Created by cd on 2017/9/12.
//  Copyright © 2017年 cheng dong. All rights reserved.
//

#import "CDForgotPasswordResetModel.h"
#import "CDNormalTextFieldConfigureItem.h"
#import "NSData+CommonCrypto.h"

@implementation CDForgotPasswordResetModel

- (instancetype)init{
    self =[super init];
    if (self) {
        /*
         NSString *filepath=[[NSBundle mainBundle]pathForResource:@"" ofType:nil];
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
         */
        
        NSString *filepath=[[NSBundle mainBundle]pathForResource:@"ForgotPwdResetConfigure.json" ofType:nil];
        NSData *data=[NSData dataWithContentsOfFile:filepath];
        NSError *error=nil;
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
        if (!error) {
            [self.arrData addObjectsFromArray:[CDNormalTextFieldConfigureItem mj_objectArrayWithKeyValuesArray:arr]];
        }
    }
    return self;
}

@end
