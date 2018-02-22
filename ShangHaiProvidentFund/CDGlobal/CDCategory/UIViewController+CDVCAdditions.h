//
//  UIViewController+CDVCAdditions.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CDHideNavBar)

/**
 *  推入导航控制器栈时是否隐藏导航栏
 */
@property (nonatomic) BOOL hidesNavigationBarWhenPushed;

@property (nonatomic, strong) UIColor *navigationBarColor;

@end

/**
 *  不设基类对所有控制器添加统计代码
 */
@interface UIViewController (CDStatistics)

@end
