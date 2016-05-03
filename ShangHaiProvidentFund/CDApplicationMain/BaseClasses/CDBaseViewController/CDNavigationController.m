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
        [self setupNavBar];
    }
    return self;
}

- (void)setupNavBar{
//    for (UIView *view in self.navigationBar.subviews) {
//        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
//            [view removeFromSuperview];
//        }
//    }
    
    //去除返回按钮的titile
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    //修改返回按钮箭头颜色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f]}];
    //带有分割线
    [self.navigationBar setBarTintColor:ColorFromHexRGB(0x01b2d3)];//
    
//    {
//        self.navigationBar.translucent=YES;
//        self.navigationBar.shadowImage = [UIImage new];
//        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];//colorForHex(@"#01b2d3")[UIImage cd_imageWithColor:[UIColor clearColor]]
////    self.navigationBar.backgroundColor=[UIColor clearColor];
//    self.view.backgroundColor=[UIColor clearColor];
//    }
}

@end