//
//  CDNetworkMonitor.m
//  ProvidentFund
//
//  Created by cdd on 15/12/10.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "CDNetworkMonitor.h"
#import "AFNetworking.h"
#import "CDAutoHideMessageHUD.h"

@implementation CDNetworkMonitor

+ (void)startMonitoring{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status){
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                CDLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [CDAutoHideMessageHUD showMessage:@"无网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                CDLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                CDLog(@"WIFI");
                break;
        }
    }];
    [mgr startMonitoring];
}

+ (void)stopMonitoring{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr stopMonitoring];
}

@end
