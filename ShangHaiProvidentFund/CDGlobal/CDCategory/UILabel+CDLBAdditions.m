//
//  UILabel+CDLBAdditions.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "UILabel+CDLBAdditions.h"

@implementation UILabel (CDTextSize)

- (CGSize)cd_textSize {
    if ([NSString instanceMethodForSelector:@selector(sizeWithAttributes:)]) {
        return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    }
    return CGSizeZero;
}

@end
