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
    [self setupNavBar];
}

//- (void)setupNavBar{
//    //去除返回按钮的titile
////    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
//    //修改返回按钮箭头颜色
//    [self.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f]}];
//    //带有分割线
////    [self.navigationBar setBarTintColor:NAVIGATION_COLOR];//
//    //不带有分割线
//    self.navigationBar.shadowImage = [[UIImage alloc]init];
//    [self.navigationBar setBackgroundImage:[UIImage cd_imageWithColor:NAVIGATION_COLOR] forBarMetrics:UIBarMetricsDefault];
//}

- (void)setupNavBar{
    [self setupNavBarWithTintColor:[UIColor whiteColor] titleTextColor:[UIColor whiteColor] backgroundColor:NAVIGATION_COLOR];
}

- (void)setupNavBarWithTintColor:(UIColor *)tintColor titleTextColor:(UIColor *)titleTextColor backgroundColor:(UIColor *)backgroundColor{
    [self.navigationBar setTintColor:tintColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleTextColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f]}];
    self.navigationBar.shadowImage = [[UIImage alloc]init];
    [self.navigationBar setBackgroundImage:[UIImage cd_imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
}

@end
