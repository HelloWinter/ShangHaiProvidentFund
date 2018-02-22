//
//  CALayer+CDCategory.m
//  ShangHaiProvidentFund
//
//  Created by cd on 2018/2/22.
//  Copyright © 2018年 cheng dong. All rights reserved.
//

#import "CALayer+CDCategory.h"

@implementation CALayer (CDCategory)

- (UIImage *)cd_capture {
    return [self cd_captureWithSize:self.bounds.size opaque:YES];
}

- (UIImage *)cd_captureWithSize:(CGSize)size opaque:(BOOL)opaque {
    UIGraphicsBeginImageContextWithOptions(size, opaque, [UIScreen mainScreen].scale);
    [self renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *capture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capture;
}

@end
