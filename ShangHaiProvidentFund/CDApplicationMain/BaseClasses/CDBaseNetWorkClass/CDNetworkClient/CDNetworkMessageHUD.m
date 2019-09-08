//
//  CDNetworkMessageHUD.m
//  ShangHaiProvidentFund
//
//  Created by Tung on 2019/9/8.
//  Copyright © 2019年 cheng dong. All rights reserved.
//

#import "CDNetworkMessageHUD.h"
#import "CDHud.h"

@implementation CDNetworkMessageHUD

/**
 显示ActivityToast指示器
 */
+ (void)showActivityToastWith:(NSString *)hudTitle{
    if (hudTitle && hudTitle.length!=0) {
        [CDHud showIndicatorWithTitle:hudTitle];
    }
}

/**
 隐藏ActivityToast指示器
 */
+ (void)hideActivityToastWith:(NSString *)hudTitle{
    if (hudTitle && hudTitle.length!=0) {
        [CDHud hideIndicatorForTitle:hudTitle];
    }
}

/**
 请求成功，但数据不正常提示
 */
+ (void)showErrorMessage:(NSString *)errorMsg{
    NSString *message = (errorMsg && errorMsg.length > 0) ? errorMsg : @"请求失败";
    [CDHud showToast:message];
}

/**
 常见错误个性化描述
 */
+ (NSString *)messageFromError:(NSError *)error {
    if (error.code == NSURLErrorNotConnectedToInternet) {
        return @"当前网络不可用";//您的网络未连接，请连接后再试
    } else  {
        return @"请求失败";
    }
}

+ (void)showServerErrorToast:(NSError *)error{
    [CDHud showToast:[self messageFromError:error]];
}

@end
