//
//  CDGlobalHTTPSessionManager.h
//  ProvidentFund
//
//  Created by cdd on 16/4/29.
//  Copyright © 2016年 9188. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CDGlobalHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
