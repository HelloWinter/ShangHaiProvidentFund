//
//  CDNetworkRequestManager.h
//  ProvidentFund
//
//  Created by cdd on 15/12/9.
//  Copyright © 2015年 9188. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class CDJSONBaseNetworkService;

@interface CDNetworkRequestManager : NSObject

/**
 *  返回单列对象
 */
+ (instancetype)sharedManager;

/**
 *  如果创建一个新的请求，需要调用此方法把service添加到数组中；
 *  此方法来实现控制是否需要显示加载框
 */
+ (void)addService:(CDJSONBaseNetworkService *)service;

/**
 *  如果请求结束，无论是成功还是失败，都需要调用此方法把service从数组中移除；
 *  此方法来实现控制是否需要隐藏加载框
 */
+ (void)removeService:(CDJSONBaseNetworkService *)service;

@end
