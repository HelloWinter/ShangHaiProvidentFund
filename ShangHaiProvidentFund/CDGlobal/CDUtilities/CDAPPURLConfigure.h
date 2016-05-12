//
//  CDAPPURLConfigure.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const CDBaseURLString;

/**
 *  返回完整的接口地址
 *
 *  @param api 接口路径
 *
 *  @return (NSString *)
 */
NSString* CDURLWithAPI(NSString* api);

NSString* CDWebURLWithAPI(NSString* api);

@interface CDAPPURLConfigure : NSObject

+ (NSString *)filePathforLoginInfo;

@end