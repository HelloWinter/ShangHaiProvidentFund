//
//  CDUIUtil.h
//  ShangHaiProvidentFund
//
//  Created by Tung on 2019/8/23.
//  Copyright © 2019年 cheng dong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设备屏幕类型
 */
typedef NS_ENUM(NSInteger, CurrentDeviceScreenType){
    /**
     *  iPhone，iPod，iPad以外的设备
     */
    CurrentDeviceScreenType_Unspecified=-1,
    /**
     *  320x480的设备(640*960)
     */
    CurrentDeviceScreenType_3_5 = 0,
    /**
     *  320x568的设备(640*1136)
     */
    CurrentDeviceScreenType_4_0 = 1,
    /**
     *  375x667(750*1134)
     */
    CurrentDeviceScreenType_4_7 = 2,
    /**
     *  414x736(1242*2208)
     */
    CurrentDeviceScreenType_5_5 = 3,
    /**
     *  iPhone X/Xs 375*821(1125*2436)5.88寸
     */
    CurrentDeviceScreenType_X = 4,
    /**
     *  iPhone Xr 414*896(1792*828)6.1寸
     */
    CurrentDeviceScreenType_6_1 = 5,
    /**
     *  iPhone Xs Max 414*896(2688×1242)6.5寸
     */
    CurrentDeviceScreenType_6_5 = 6,
    /**
     *  iPad
     */
    CurrentDeviceScreenType_iPad = 10
};

/**
 *  调用系统打电话功能
 *
 *  @param phoneNum 电话号
 */
void callPhoneNum(NSString* phoneNum);

@interface CDUIUtil : NSObject

/**
 当前屏幕类型
 */
+ (CurrentDeviceScreenType)currentScreenType;
/**
 是否是刘海屏
 */
+ (BOOL)hasFringe;
/**
 当前可见的视图控制器
 */
+ (UIViewController *)visibleController;

/**
 最简单的AlertView
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg cancelButton:(NSString *)cancel action:(void(^)(UIAlertAction *))action;

@end
