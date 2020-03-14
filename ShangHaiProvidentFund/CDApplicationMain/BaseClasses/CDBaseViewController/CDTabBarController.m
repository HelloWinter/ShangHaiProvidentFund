//
//  CDTabBarController.m
//  CDAppDemo
//
//  Created by cdd on 15/10/22.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "CDTabBarController.h"
#import "CDNavigationController.h"
#import "UIImage+CDImageAdditions.h"
#import "CDNewsAndTrendsController.h"
#import "CDConvenientToolsController.h"
#import "CDQueryAccountInfoController.h"

@interface CDTabBarController ()

@end

@implementation CDTabBarController

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBar.barTintColor=colorForHex(@"#01b2d3");
    [self.tabBar setTintColor:ColorFromHexRGB(0x2d8eff)];
    [self.tabBar setShadowImage:[UIImage new]];
    UIColor *bgColor = [UIColor whiteColor];
//    if (@available(iOS 13.0, *)) {
//        bgColor = [UIColor systemBackgroundColor];
//    }
    [self.tabBar setBackgroundImage:[UIImage cd_imageWithColor:bgColor]];
    [self p_setupAllChildViewController];
}

#pragma mark - private
- (void)p_setupAllChildViewController{
    CDNewsAndTrendsController *newsAndTrendsController = [[CDNewsAndTrendsController alloc]init];
    [self p_createAndAddChildViewController:newsAndTrendsController image:[UIImage imageNamed:@"tab_home_normal"] title:@"新闻动态"];
    
    CDConvenientToolsController *convenientToolsController = [[CDConvenientToolsController alloc]init];
    [self p_createAndAddChildViewController:convenientToolsController image:[UIImage imageNamed:@"tab_product_normal"] title:@"便民工具"];
    
    CDQueryAccountInfoController *queryAccountInfoController = [[CDQueryAccountInfoController alloc]init];
    [self p_createAndAddChildViewController:queryAccountInfoController image:[UIImage imageNamed:@"tab_mine_normal"] title:@"账户查询"];
}

- (void)p_createAndAddChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title{
    CDNavigationController *navC = [[CDNavigationController alloc]initWithRootViewController:viewController];
    navC.tabBarItem.title = title;
    navC.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC.tabBarItem.selectedImage=image;
    viewController.navigationItem.title = title;
    [self addChildViewController:navC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
