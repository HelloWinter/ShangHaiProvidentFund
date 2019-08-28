//
//  CDUtilities.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>



/**
 *  校验身份证是否合法
 *
 *  @return (BOOL)
 */
BOOL verifyIDCard(NSString* idcard);

/**
 *  校验姓名是否合法
 *
 *  @return (BOOL)
 */
BOOL checkName(NSString *userName);

/**
 *  从keychain获取IDFV（没有就设置）
 *
 *  @return IDFV字符串
 */
NSString *CDKeyChainIDFV(void);

/**
 *  开始摇一摇监听
 *
 *  @param target
 *  @param action
 */
void startMotion(id target,SEL action);

/**
 *  停止摇一摇监听
 */
void stopMotion(void);

/**
 *  APP是否是第一次启动
 *
 *  @return BOOL
 */
BOOL isFirstLaunch(void);

/**
 *  启动次数增加
 */
void addLaunchTimes(void);

/**
 *  URLScheme
 *
 *  @return (NSString *)
 */
NSString *CDURLScheme(void);

@interface CDUtilities : NSObject

/**
 *  使用TouchID校验
 *
 *  @param completion 校验通过回调
 */
+ (void)authenticateUserTouchID:(void (^)(void)) completion;

@end
