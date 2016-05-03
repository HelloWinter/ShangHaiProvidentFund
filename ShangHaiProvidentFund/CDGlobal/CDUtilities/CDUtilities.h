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

extern NSString *const CDBaseURLString;

/* ---------------------------------------------------------------- */
/** 公共C方法 **/
/* ---------------------------------------------------------------- */

/**
 *  返回完整的接口地址
 *
 *  @param api 接口路径
 *
 *  @return (NSString *)
 */
NSString* CDURLWithAPI(NSString* api);

/**
 *  设备屏幕缩放比例
 *
 *  @return (CGFloat)
 */
CGFloat CDScale();

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
 *  设备屏幕类型
 */
typedef NS_ENUM(NSUInteger, CurrentDeviceScreenModel){
    /**
     *  320x480的设备(640*960)
     */
    CurrentDeviceScreenModel_3_5 = 0,
    /**
     *  320x568的设备
     */
    CurrentDeviceScreenModel_4_0 = 1,
    /**
     *  375x667
     */
    CurrentDeviceScreenModel_4_7 = 2,
    /**
     *  414x736
     */
    CurrentDeviceScreenModel_5_5 = 3,
};

/**
 *  获取当前设备屏幕类型
 *
 *  @return (CurrentDeviceScreenModel)
 */
CurrentDeviceScreenModel currentScreenModel();



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
 *  得到某文件的完整路径
 *
 *  @param filename 文件名
 *
 *  @return (NSString *) 文件的完整路径
 */
NSString *pathForFileInDocumentsDirectory(NSString *filename);

/**
 *  删除所有cookies
 */
void removeAllCookies();

/**
 *  将Token刷入Cookies
 */
void setTokenToCookies(NSURL* url);

/**
 *  创建一个Cookie
 */
NSHTTPCookie *createCookieWithDomain(NSString* Tdomain,NSString* cookieName,NSString* cookieValue,NSDate* expiresDate);

/**
 *  从[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies种读取出对应的cookie
 */
NSHTTPCookie *cookieForDomain(NSString* tDomain,NSString* cookieName);

/**
 *  域名下的session
 *
 *  @param domain 域名
 *
 *  @return NSDictionary*
 */
NSDictionary* sessionsForDomain(NSString* domain);

/**
 *  从钥匙串获取UUID,如果没有就设置
 */
NSString *CDKeyChainUUID();

/**
 *  显示简单的alertView
 */
void showAlertViewWithTitleAndMessage(NSString *title, NSString *message);

/**
 *  显示简单的alertView
 *
 *  @param message 信息
 */
void showAlertViewWithMessage(NSString *message);

/**
 *  开始摇一摇
 *
 *  @param target <#target description#>
 *  @param action <#action description#>
 */
void startMotion(id target,SEL action);

/**
 *  停止摇一摇
 */
void stopMotion();

/*!
 @brief 企业版APP直接通过URL更新
 */
void openURLToUpdateEnterpriseEditionAPP(NSString* url,UIView* parentView);

/**
 *  调用系统打电话功能
 *
 *  @param phoneNum 电话号
 */
void callPhoneNum(NSString* phoneNum);

/**
 *  跳转去评论
 */
void commentApp();

/**
 *  视图抖动效果
 *
 *  @param view 要抖动的视图
 */
void shakeView(UIView* view);

/**
 *  视图左右摇动
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

@interface CDUtilities : NSObject

/**
 *  将时间戳按照给定的格式转换成时间字符串
 *
 *  @param timestamp    时间戳
 *  @param dateFormat   转换的时间格式(默认为@"yyyy-MM-dd HH:mm:ss")
 *
 *  @return (NSString *)
 */
+ (NSString *)transformToStringDateFromTimestamp:(NSTimeInterval)timestamp WithDateFormat:(NSString *)dateFormat;

/**
 *  计算文本大小
 *
 *  @param text 文本
 *  @param font 字体大小
 *
 *  @return (CGSize)
 */
+ (CGSize) sizeWithText:(NSString *)text WithFont:(UIFont *)font;

/**
 *  使用TouchID校验
 *
 *  @param completion 校验通过回调
 */
+ (void)authenticateUserTouchID:(void (^)(void)) completion;

@end
