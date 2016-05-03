//
//  UIViewController+CDVCAdditions.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HideNavBar)

/**
 *  推入导航控制器栈时是否隐藏导航栏
 */
@property (nonatomic) BOOL hidesNavigationBarWhenPushed;


@end

@interface UIViewController (Statistics)

/*!
 第三方统计时获取页面的title(通常放在VC基类里)
 */
@property (nonatomic, copy) NSString *statisticsPageTitle;

@end