//
//  CDNetworkMessageHUD.h
//  ShangHaiProvidentFund
//
//  Created by Tung on 2019/9/8.
//  Copyright © 2019年 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CDNetworkMessageHUD : NSObject

+ (void)showActivityToastWith:(NSString *)hudTitle;

+ (void)hideActivityToastWith:(NSString *)hudTitle;

+ (void)showErrorMessage:(NSString *)errorMsg;

+ (NSString *)messageFromError:(NSError *)error;

+ (void)showServerErrorToast:(NSError *)error;

@end
