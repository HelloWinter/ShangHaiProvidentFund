//
//  CDCacheManager.h
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/26.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache.h>

///////////////////////////////////////////////////
void CDSaveUserLogined(BOOL logined);

BOOL CDIsUserLogined();
///////////////////////////////////////////////////
void CDSaveUserLocation(NSString *location);

NSString *CDUserLocation();

void CDRemoveUserLocation();
///////////////////////////////////////////////////

void CDSaveUserNickName(NSString *nickname);

NSString *CDUserNickName();

void CDRemoveUserNickName();

///////////////////////////////////////////////////

@interface CDCacheManager : NSObject
AS_SINGLETON(CDCacheManager)

@property (nonatomic, strong, readonly) YYCache *cache;
@property (nonatomic, strong, readonly) YYMemoryCache *memorycache;
/**
 *  账户信息路径
 */
+ (NSString *)filePathforLoginInfo;

@end

