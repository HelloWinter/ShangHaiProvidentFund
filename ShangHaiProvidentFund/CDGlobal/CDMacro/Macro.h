//
//  Macro.h
//  CDAppDemo
//
//  Created by cdd on 15/9/23.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#ifndef CDAppDemo_Macro_h
#define CDAppDemo_Macro_h


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
 *   设备类型(iPhone,iPod touch...)
 *
 *   @return (NSString*)
 */
#define CDDeviceModel [UIDevice currentDevice].model

/**
 *  返回本地APP名字
 *
 *  @return (NSString*)本地APP名字
 */
#define CDAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/**
 返回Bundle ID

 @return Bundle ID
 */
#define CDAppBundleID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

/**
 *  返回本地APP版本
 *
 *  @return (NSString*)本地APP版本
 */
#define CDAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]



/**
 *  返回keyWindow属性
 */
#define CDKeyWindow [UIApplication sharedApplication].keyWindow

/**
 定义弱引用宏
 */
#ifndef WS
#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;
#endif

#define IS_RETINA  ([UIScreen mainScreen].scale >= 2.0f)

/**
 声明单例宏
 */
#undef AS_SINGLETON
#define AS_SINGLETON(__class)    \
-(__class *) sharedInstance; \
+(__class *) sharedInstance;
/**
 定义单例宏
 */
#undef DEF_SINGLETON
#define DEF_SINGLETON(__class)                                                   \
-(__class *) sharedInstance                                                  \
{                                                                            \
return [__class sharedInstance];                                         \
}                                                                            \
+(__class *) sharedInstance                                                  \
{                                                                            \
static dispatch_once_t once;                                             \
static __class *__singleton__;                                           \
dispatch_once(&once, ^{ __singleton__ = [[[self class] alloc] init]; }); \
return __singleton__;                                                    \
}



#endif
