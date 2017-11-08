//
//  UITextField+cellIndexPath.m
//  ProvidentFund
//
//  Created by cdd on 16/4/22.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "UITextField+cellIndexPath.h"
#import <objc/runtime.h>

@implementation UITextField (cellIndexPath)
static char indexPathKey;

- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, &indexPathKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
