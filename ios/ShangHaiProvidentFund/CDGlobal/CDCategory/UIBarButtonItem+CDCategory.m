//
//  UIBarButtonItem+CDCategory.m
//  CDAppDemo
//
//  Created by cdd on 15/11/13.
//  Copyright © 2015年 Cheng. All rights reserved.
//

#import "UIBarButtonItem+CDCategory.h"

@implementation UIBarButtonItem (CDCategory)

+ (UIBarButtonItem *)cd_ItemWidth:(CGFloat)width title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action{
    return [UIBarButtonItem cd_ItemWidth:width title:title titleColor:titleColor imageName:nil target:target action:action];
}

+ (UIBarButtonItem *)cd_ItemWidth:(CGFloat)width imageName:(NSString *)imageName target:(id)target action:(SEL)action{
    return [UIBarButtonItem cd_ItemWidth:width title:nil titleColor:nil imageName:imageName target:target action:action];
}

+ (UIBarButtonItem *)cd_ItemWidth:(CGFloat)width title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName target:(id)target action:(SEL)action{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, width, 30);
    if (title) {
        barButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [barButton setTitle:title forState:(UIControlStateNormal)];
        [barButton setTitleColor:titleColor forState:(UIControlStateNormal)];
    }
    if (imageName) {
        [barButton setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    }
    if (target && action) {
        if ([target respondsToSelector:action]) {
            [barButton addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
    UIBarButtonItem *item =[[UIBarButtonItem alloc]initWithCustomView:barButton];
    return item;
}

@end
