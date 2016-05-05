//
//  Macro.h
//  CDAppDemo
//
//  Created by cdd on 15/9/23.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#ifndef CDAppDemo_Macro_h
#define CDAppDemo_Macro_h


#ifdef DEBUG //调试状态下打开LOG
#define CDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else
#define CDPRINT(xx, ...)  ((void)0)

#endif

#if __has_feature(objc_ARC)
/**
 *  ARC
 */
#define CD_RELEASE_SAFELY(__POINTER) ((void)0)
#else
/**
 *  MRC释放
 */
#define CD_RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
#endif

/**
 @brief 断言
 */
#define CDAssert(condition, ...)                                             \
if (!(condition)) {                                                          \
[[NSAssertionHandler currentHandler]                                         \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__]  \
file:[NSString stringWithUTF8String:__FILE__]                                \
lineNumber:__LINE__                                                          \
description:__VA_ARGS__];                                                    \
}

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

/**
 *  获取屏幕 宽度、高度
 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/**
 @brief rgb颜色转换（）
 */
/**
 *  16进制格式颜色表示方式e.g.0xFF00FF
 *
 *  @param rgbValue 16进制颜色值
 *
 *  @return UIColor对象
 */
#define ColorFromHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  RGB颜色
 *
 *  @param r 红色色值（0-255）
 *  @param g 绿色色值（0-255）
 *  @param b 蓝色色值（0-255）
 *
 *  @return UIColor对象
 */
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(r)/255.0f blue:(b)/255.0f alpha:1]

/**
 *  RGBA颜色
 *
 *  @param r 红色色值（0-255）
 *  @param g 绿色色值（0-255）
 *  @param b 蓝色色值（0-255）
 *  @param a alpha通道值(透明度)（0-1）
 *
 *  @return UIColor对象
 */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/**
 *  HSB颜色
 *
 *  @param h 色调（0-1）
 *  @param s 饱和度（0-1）
 *  @param b 亮度（0-1）
 *
 *  @return UIColor对象
 */
#define HSBCOLOR(h,s,b) [UIColor colorWithHue:(h) saturation:(s) brightness:(b) alpha:1]

/**
 *  HSBA颜色
 *
 *  @param h 色调（0-1）
 *  @param s 饱和度（0-1）
 *  @param b 亮度（0-1）
 *  @param a alpha通道值(透明度)（0-1）
 *
 *  @return UIColor对象
 */
#define HSBACOLOR(h,s,b,a) [UIColor colorWithHue:(h) saturation:(s) brightness:(b) alpha:(a)]

/**
 *  度数转换为弧度
 *
 *  @param d 角度数
 *
 *  @return 弧度
 */
#define Degrees_To_Radians(d)  (M_PI*(d)/180.0)

/**
 *  弧度转化为度数
 *
 *  @param r 弧度
 *
 *  @return 角度数
 */
#define Radians_To_Degrees(r)  ((r)*180/M_PI)

/**
 *  读取本地图片
 *
 *  @param imagename (NSString*)图片名
 *  @param ext       图片扩展名(区分大小写)
 *
 *  @return UIImage图片对象
 */
#define IMAGE_WITH_EXTENSION(imagename,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imagename ofType:ext]]

/**
 *  定义UIImage对象(png格式)
 *
 *  @param imgname (NSString*)图片名
 *
 *  @return UIImage图片对象
 */
#define IMAGE_PNG(imgname) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imgname ofType:@"png"]]

/**
 *  定义UIImage对象
 *
 *  @param _imgname (NSString*)图片名
 *
 *  @return UIImage图片对象
 */
#define IMAGE_NAMED(_imgname) [UIImage imageNamed:_imgname]

/**
 *   系统版本(float类型)
 *
 *   @return (float)
 */
#define CDSystemVersionFloatValue [[UIDevice currentDevice].systemVersion floatValue]

/**
 *   系统版本(NSString类型)
 *
 *   @return (NSString*)
 */
#define CDSystemVersion [UIDevice currentDevice].systemVersion

/**
 *  返回本地APP名字
 *
 *  @return (NSString*)本地APP名字
 */
#define CDAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/**
 *  返回本地APP版本
 *
 *  @return (NSString*)本地APP版本
 */
#define CDAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 *   设备类型(iPhone,iPod touch...)
 *
 *   @return (NSString*)
 */
#define CDDeviceModel [UIDevice currentDevice].model

/**
 *  沙盒Document路径
 *
 *  @return (NSString *)
 */
#define CDDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

/**
 *  沙盒Caches路径
 *
 *  @return (NSString *)
 */
#define CDCachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

/**
 *  返回keyWindow属性
 */
#define CDKeyWindow [UIApplication sharedApplication].keyWindow

/**
 *  当前屏幕bounds
 */
#define CDScreenBounds [[UIScreen mainScreen] bounds]

/**
 *  当前屏幕scale
 *
 *  @return (CGFloat)
 */
#define CDScreenScale ([UIScreen mainScreen].scale)

#define LEFT_RIGHT_MARGIN 15

#endif
