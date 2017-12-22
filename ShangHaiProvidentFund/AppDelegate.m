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
#import "GDTTrack.h"
#import "GDTSplashAd.h"

@interface AppDelegate ()<BMKGeneralDelegate,BMKLocationServiceDelegate,GDTSplashAdDelegate>{
    BMKMapManager* _mapManager;
    BMKLocationService *_locService;
}

@property (strong, nonatomic) GDTSplashAd *splash;
@property (strong, nonatomic) UIView *bottomView;

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
    /*
    //开屏广告初始化并展示代码
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        GDTSplashAd *splashAd = [[GDTSplashAd alloc] initWithAppkey:GDTAdAppKey placementId:@"9040714184494018"];
        splashAd.delegate = self;//设置代理1ez        //针对不同设备尺寸设置不同的默认图片，拉取广告等待时间会展示该默认图片。
        if ([[UIScreen mainScreen] bounds].size.height >= 568.0f) {
            splashAd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage-568h"]];
        } else {
            splashAd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage"]];
        }
        //设置开屏拉取时长限制，若超时则不再展示广告
        splashAd.fetchDelay = 3;
        //［可选］拉取并展示全屏开屏广告
        //[splashAd loadAdAndShowInWindow:self.window];
        //设置开屏底部自定义LogoView，展示半屏开屏广告
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100)];
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashBottomLogo"]];
        [_bottomView addSubview:logo];
        logo.center = _bottomView.center;
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        [splashAd loadAdAndShowInWindow:self.window withBottomView:_bottomView];
        self.splash = splashAd;
    }
    */
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
    [GDTTrack activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - GDTSplashAdDelegate
-(void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

-(void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
{
    NSLog(@"%s%@",__FUNCTION__,error);
}
-(void)splashAdApplicationWillEnterBackground:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)splashAdClicked:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdWillClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)splashAdClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    _splash = nil;
}
-(void)splashAdWillPresentFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)splashAdDidDismissFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
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
    BOOL ret = [_mapManager start:AMapKey  generalDelegate:self];
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
