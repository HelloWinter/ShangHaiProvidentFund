//
//  UIBarButtonItem+CDCategory.h
//  CDAppDemo
//
//  Created by cdd on 15/11/13.
//  Copyright © 2015年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CDCategory)

/**
 *  快速生成UIBarButtonItem
 *
 *  @param width     BarButton宽度
 *  @param title     标题
 *  @param imageName 图片名
 *  @param target
 *  @param action    
 *
 *  @return (UIBarButtonItem *)对象实例
 */
+ (UIBarButtonItem *)cd_barButtonWidth:(CGFloat)width title:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;

@end
