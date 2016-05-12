//
//  CDAPPURLConfigure.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDAPPURLConfigure.h"

#ifdef DEBUG

NSString *const CDBaseURLString = @"http://person.shgjj.com";

NSString *const CDBaseWebURLString = @"http://www.shgjj.com";

#else

NSString *const CDBaseURLString = @"http://person.shgjj.com";

NSString *const CDBaseWebURLString = @"http://www.shgjj.com";

#endif

NSString* CDURLWithAPI(NSString* api) {
    return [NSString stringWithFormat:@"%@%@",CDBaseURLString,api];
}

NSString* CDWebURLWithAPI(NSString* api) {
    return [NSString stringWithFormat:@"%@%@",CDBaseWebURLString,api];
}

@implementation CDAPPURLConfigure

+ (NSString *)filePathforLoginInfo{
    return [CDCachesPath stringByAppendingPathComponent:@"info.data"];
}

@end
