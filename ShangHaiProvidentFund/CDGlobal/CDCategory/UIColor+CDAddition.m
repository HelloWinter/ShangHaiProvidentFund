//
//  UIColor+CDAddition.m
//  CDAppDemo
//
//  Created by Cheng on 15/9/4.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "UIColor+CDAddition.h"

@implementation UIColor (CDAddition)

- (UIImage *)cd_createImage{
    CGRect rect = CGRectMake(0, 0, 30, 30);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
