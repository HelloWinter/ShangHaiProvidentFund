//
//  CDBaseViewController.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDJSONBaseNetworkService.h"


@interface CDBaseViewController : UIViewController<CDJSONBaseNetworkServiceDelegate>{
@protected
    CGRect _keyboardBounds;
    NSTimeInterval _keybardAnmiatedTimeinterval;
}

/**
 *  状态栏是否隐藏
 */
@property (nonatomic, assign) BOOL statusBarHidden;

/**
 *  点击是否隐藏键盘，默认为NO
 */
@property (nonatomic, assign) BOOL hideKeyboradWhenTouch;

- (void)cd_showBackButton;

- (void)cd_backOffAction;

- (void)keyboardWillShow:(NSNotification*)notification;

- (void)keyboardDidShow:(NSNotification*)notification;

- (void)keyboardWillHide:(NSNotification*)notification;

- (void)keyboardDidHide:(NSNotification*)notification;


@end
