//
//  UIColor+CDAddition.h
//  CDAppDemo
//
//  Created by Cheng on 15/9/4.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CDAddition)

/**
 *  使用颜色生成纯色图片(默认大小30*30，通常用于button控件)
 *
 *  @return (UIImage *) 纯色图片
 */
- (UIImage *)cd_createImage;

@end
