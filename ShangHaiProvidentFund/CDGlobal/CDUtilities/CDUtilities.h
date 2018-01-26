//
//  CDUtilities.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

/**
 *  设备屏幕类型
 */
typedef NS_ENUM(NSInteger, CurrentDeviceScreenModel){
    /**
     *  iPhone，iPod，iPad以外的设备
     */
    CurrentDeviceScreenModel_Unspecified=-1,
    /**
     *  320x480的设备(640*960)
     */
    CurrentDeviceScreenModel_3_5 = 0,
    /**
     *  320x568的设备(640*1136)
     */
    CurrentDeviceScreenModel_4_0 = 1,
    /**
     *  375x667(750*1134)
     */
    CurrentDeviceScreenModel_4_7 = 2,
    /**
     *  414x736(1242*2208)
     */
    CurrentDeviceScreenModel_5_5 = 3,
    /**
     *  iPad
     */
    CurrentDeviceScreenModel_iPad = 4,
    /**
     *  iPhone X 375*821(1125*2436)5.88寸
     */
    CurrentDeviceScreenModel_X = 5
};

/* ---------------------------------------------------------------- */
/** 公共C方法 **/
/* ---------------------------------------------------------------- */

/**
 *  获取当前设备屏幕类型
 *
 *  @return (CurrentDeviceScreenModel)
 */
CurrentDeviceScreenModel currentScreenModel();

/**
 *  旋转视图
 *
 *  @param view     要旋转的视图
 *  @param degrees  旋转的角度
 *  @param duration 持续时间
 */
void rotateView(UIView* view,int degrees,float duration);

/**
 *  返回当前控制器
 *
 *  @return (UIViewController *)
 */
UIViewController* CDVisibalController();

/**
 *  十六进制颜色转换
 *
 *  @param hexColor 十六进制颜色字符串eg：@"#ffffff"
 *  @return (UIColor*)
 */
UIColor* colorForHex(NSString* hexColor);

/**
 *  校验身份证是否合法
 *
 *  @return (BOOL)
 */
BOOL verifyIDCard(NSString* idcard);

/**
 *  校验姓名是否合法
 *
 *  @return (BOOL)
 */
BOOL checkName(NSString *userName);

/**
 *  从keychain获取IDFV（没有就设置）
 *
 *  @return IDFV字符串
 */
NSString *CDKeyChainIDFV();

/**
 *  调用系统打电话功能
 *
 *  @param phoneNum 电话号
 */
void callPhoneNum(NSString* phoneNum);

/**
 *  开始摇一摇监听
 *
 *  @param target
 *  @param action
 */
void startMotion(id target,SEL action);

/**
 *  停止摇一摇监听
 */
void stopMotion();

/**
 *  视图抖动效果
 *
 *  @param view 要抖动的视图
 */
void shakeView(UIView* view);

/**
 *  视图左右抖动效果
 *
 *  @param view 要左右摇动的视图
 */
void shakeLeftAndRightWithView(UIView *view);

/**
 *  APP是否是第一次启动
 *
 *  @return BOOL
 */
BOOL isFirstLaunch();

/**
 *  启动次数增加
 */
void addLaunchTimes();

/**
 *  URLScheme
 *
 *  @return (NSString *)
 */
NSString *CDURLScheme();

/**
 *  去应用(系统)设置界面
 */
void goToSettings();

@interface CDUtilities : NSObject

/**
 *  使用TouchID校验
 *
 *  @param completion 校验通过回调
 */
+ (void)authenticateUserTouchID:(void (^)(void)) completion;

@end
