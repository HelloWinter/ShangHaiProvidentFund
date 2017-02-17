//
//  CDNetworkRequestManager.m
//  ProvidentFund
//
//  Created by cdd on 15/12/9.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "CDNetworkRequestManager.h"
#import "CDPointActivityIndicator.h"
#import "CDJSONBaseNetworkService.h"

@interface CDNetworkRequestManager ()

@property (nonatomic, strong) NSMutableArray *services;

@end

@implementation CDNetworkRequestManager

+ (instancetype)sharedManager {
    static CDNetworkRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CDNetworkRequestManager alloc] init];
        manager.services=[[NSMutableArray alloc]init];
    });
    return manager;
}

+ (void)addService:(CDJSONBaseNetworkService *)service {
    CDNetworkRequestManager *manager = [CDNetworkRequestManager sharedManager];
    if (![manager.services containsObject:service]) {
        if (service.showLodingIndicator && ![manager p_hasLoadingIndicator]) {
            [CDPointActivityIndicator startAnimating];
        }
        [manager.services addObject:service];
        [manager p_showNetworkIndicatorIfNeeded];
    }
}

+ (void)removeService:(CDJSONBaseNetworkService *)service {
    CDNetworkRequestManager *manager = [CDNetworkRequestManager sharedManager];
    if ([manager.services containsObject:service]) {
        [manager.services removeObject:service];
        [manager p_showNetworkIndicatorIfNeeded];
        if (![manager p_hasLoadingIndicator]/* && service.showLodingIndicator*/) {
            [CDPointActivityIndicator stopAnimating];
        }
    }
}

#pragma mark - private
/**
 *  如果当前有请求，就显示状态栏上的加载图标；反之不显示
 */
- (void)p_showNetworkIndicatorIfNeeded {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = _services.count > 0;
}

/**
 *  遍历所有service，返回是否有service显示加载框
 */
- (BOOL)p_hasLoadingIndicator {
    __block BOOL shouldShowLoading = NO;
    [_services enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CDJSONBaseNetworkService *service = obj;
        if (service.showLodingIndicator) {
            shouldShowLoading = YES;
            *stop = YES;
        }
    }];
    return shouldShowLoading;
}

@end
