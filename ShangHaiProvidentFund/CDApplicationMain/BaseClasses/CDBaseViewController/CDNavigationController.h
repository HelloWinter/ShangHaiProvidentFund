//
//  CDNavigationController.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDNavigationController : UINavigationController

- (void)cd_setupNavBar;

- (void)cd_setupNavBarWithTintColor:(UIColor *)tintColor titleTextColor:(UIColor *)titleTextColor backgroundColor:(UIColor *)backgroundColor;

@end



