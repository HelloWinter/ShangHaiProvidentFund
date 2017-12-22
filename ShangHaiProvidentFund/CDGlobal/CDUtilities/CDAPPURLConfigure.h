//
//  CDAPPURLConfigure.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  返回完整的接口地址
 *
 *  @param api 接口路径
 *
 *  @return (NSString *)
 */
NSString* CDURLWithAPI(NSString* api);

NSString* CDWebURLWithAPI(NSString* api);

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

@interface CDAPPURLConfigure : NSObject

/**
 *  账户信息路径
 */
+ (NSString *)filePathforLoginInfo;

@end
