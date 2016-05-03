//
//  CDNetworkMonitor.h
//  ProvidentFund
//
//  Created by cdd on 15/12/10.
//  Copyright © 2015年 9188. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDNetworkMonitor : NSObject

/**
 *   监听网络状态的变化
 */
+ (void)startMonitoring;

/**
 *  停止监听
 */
+ (void)stopMonitoring;

@end
