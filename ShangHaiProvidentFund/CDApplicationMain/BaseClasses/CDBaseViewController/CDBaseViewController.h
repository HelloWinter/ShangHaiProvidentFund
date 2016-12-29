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
 *  状态栏是否隐藏
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

- (void)cd_showBackButton;

- (void)cd_backOffAction;

@end
