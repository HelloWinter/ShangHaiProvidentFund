//
//  UIBarButtonItem+CDCategory.m
//  CDAppDemo
//
//  Created by cdd on 15/11/13.
//  Copyright © 2015年 Cheng. All rights reserved.
//

#import "UIBarButtonItem+CDCategory.h"

@implementation UIBarButtonItem (CDCategory)

+ (UIBarButtonItem *)cd_barButtonWidth:(CGFloat)width Title:(NSString *)title ImageName:(NSString *)imageName Target:(id)target Action:(SEL)action{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, width, 44);
    if (title) {
        barButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [barButton setTitle:title forState:(UIControlStateNormal)];
        [barButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
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
