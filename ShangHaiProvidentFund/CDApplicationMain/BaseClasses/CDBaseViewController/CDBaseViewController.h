//
//  CDBaseViewController.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDJSONBaseNetworkService.h"


@interface CDBaseViewController : UIViewController<CDJSONBaseNetworkServiceDelegate>

/**
 *  状态栏是否隐藏,默认为NO
 */
@property (nonatomic, assign) BOOL statusBarHidden;

/**
 *  点击是否隐藏键盘，默认为NO
 */
@property (nonatomic, assign) BOOL hideKeyboradWhenTouch;

/**
 *  自定义返回按钮的图片名,默认navigation_backOff
 */
@property (nonatomic, copy) NSString *backImageName;

/**
 *  显示返回按钮
 */
- (void)cd_showBackButton;

/**
 *  返回动作，子类可重写此方法拦截返回事件
 */
- (void)cd_backOffAction;

@end
