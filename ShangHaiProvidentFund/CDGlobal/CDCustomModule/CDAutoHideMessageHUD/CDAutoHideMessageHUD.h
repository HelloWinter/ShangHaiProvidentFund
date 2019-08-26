//
//  CDAutoHideMessageHUD.h
//  CDAppDemo
//
//  Created by Cheng on 15/9/5.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDAutoHideMessageHUD : NSObject

+ (void)showMessage:(NSString *)msg;
+ (void)showMessage:(NSString *)msg inView:(UIView *)view;
+ (void)showMessage:(NSString *)msg inView:(UIView *)view duration:(NSTimeInterval)duration;

@end


