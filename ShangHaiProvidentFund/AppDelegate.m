//
//  AppDelegate.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "AppDelegate.h"
#import "CDTabBarController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface AppDelegate ()<BMKGeneralDelegate,BMKLocationServiceDelegate>{
    BMKMapManager* _mapManager;
    BMKLocationService *_locService;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupMapManager];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    CDTabBarController *tabBarController=[[CDTabBarController alloc]init];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    [self startLocation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError{
    NSString *errorMsg=(0 == iError) ? @"联网成功" : [NSString stringWithFormat:@"onGetNetworkState %d",iError];
    CDLog(@"%@",errorMsg);
}

- (void)onGetPermissionState:(int)iError{
    NSString *errorMsg=(0 == iError) ? @"授权成功" : [NSString stringWithFormat:@"onGetPermissionState %d",iError];
    CDLog(@"%@",errorMsg);
}

#pragma mark - BMKLocationServiceDelegate
//实现相关delegate 处理位置信息更新
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSString *strCoordinate=[NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
    CDSaveUserLocation(strCoordinate);
}

- (void)didFailToLocateUserWithError:(NSError *)error{
    CDRemoveUserLocation();
}

#pragma mark - Events
- (void)setupMapManager{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [_mapManager start:[CDAPPURLConfigure AMapKey]  generalDelegate:self];
    if (!ret) {
        CDLog(@"manager start failed!");
    }
}

- (void)startLocation{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

@end
