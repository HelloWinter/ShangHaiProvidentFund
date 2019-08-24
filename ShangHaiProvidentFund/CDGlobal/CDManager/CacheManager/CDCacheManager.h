//
//  CDCacheManager.h
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/26.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache.h>

@interface CDCacheManager : NSObject
AS_SINGLETON(CDCacheManager)

@property (nonatomic, strong, readonly) YYCache *cache;
@property (nonatomic, strong, readonly) YYMemoryCache *memorycache;

+ (void)saveUserLogined:(BOOL)logined;

+ (BOOL)isUserLogined;

+ (void)saveUserLocation:(NSString *)location;

+ (NSString *)userLocation;

+ (void)removeUserLocation;

+ (void)saveUserNickName:(NSString *)nickname;

+ (NSString *)userNickName;

+ (void)removeUserNickName;

/**
 *  账户信息路径
 */
+ (NSString *)filePathforLoginInfo;

@end

