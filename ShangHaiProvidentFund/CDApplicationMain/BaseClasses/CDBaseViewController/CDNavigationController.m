//
//  CDNavigationController.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "CDNavigationController.h"
#import "UIImage+CDImageAdditions.h"

@interface CDNavigationController ()

@end

@implementation CDNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self cd_setupNavBar];
}

- (void)cd_setupNavBar{
    [self cd_setupNavBarWithTintColor:[UIColor whiteColor] titleTextColor:[UIColor whiteColor] backgroundColor:NAVIGATION_COLOR];
}

- (void)cd_setupNavBarWithTintColor:(UIColor *)tintColor titleTextColor:(UIColor *)titleTextColor backgroundColor:(UIColor *)backgroundColor{
    [self.navigationBar setTintColor:tintColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleTextColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f]}];
    self.navigationBar.shadowImage = [[UIImage alloc]init];
    [self.navigationBar setBackgroundImage:[UIImage cd_imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
}

@end
