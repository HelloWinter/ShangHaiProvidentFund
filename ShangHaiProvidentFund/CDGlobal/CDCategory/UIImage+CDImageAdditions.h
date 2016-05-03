//
//  UIImage+CDImageAdditions.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CDImageAdditions)

/**
 *  使用颜色生成纯色图片(默认大小30*30，通常用于button控件)
 *
 *  @param red   红色色值
 *  @param green 绿色色值
 *  @param blue  蓝色色值
 *
 *  @return (UIImage *) 纯色图片
 */
+ (UIImage *)cd_imageWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue;

/**
 *  使用颜色生成纯色图片(默认大小30*30，通常用于button控件)
 *
 *  @param color 颜色
 *
 *  @return (UIImage *) 纯色图片
 */
+ (UIImage *)cd_imageWithColor:(UIColor *)color;

/**
 *  拉伸图片
 *
 *  @param imageName 图片名
 *  @param insets    UIEdgeInsets
 *
 *  @return (UIImage *)
 */
+ (UIImage *)cd_resizeImage:(NSString *)imageName CapInsets:(UIEdgeInsets)insets;

/**
 *  对图片做高斯模糊
 *
 *  @param radius 模糊半径，为0时不模糊,值越大越脱离原来外形(越看不出原来形状)
 *  @param iterations 模糊程度，为0时不模糊,值越大越模糊
 *  @param tintColor 模糊蒙版颜色,一般设为白色
 *
 *  @return (UIImage *) 高斯模糊后的图片
 */
- (UIImage *)cd_blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

@end
