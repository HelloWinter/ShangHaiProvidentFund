//
//  UITextView+CDCategory.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "UITextView+CDCategory.h"
#import <objc/runtime.h>

@implementation UITextView (CDCategory)
static char textViewIndexPathKey;

- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, &textViewIndexPathKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, &textViewIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
