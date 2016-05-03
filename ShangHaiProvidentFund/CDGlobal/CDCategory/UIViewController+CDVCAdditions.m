//
//  UIViewController+CDVCAdditions.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "UIViewController+CDVCAdditions.h"
#import <objc/runtime.h>

static char kHideNavBarKey;
@implementation UIViewController (HideNavBar)

- (void)setHidesNavigationBarWhenPushed:(BOOL)hidesNavigationBarWhenPushed {
    objc_setAssociatedObject(self, &kHideNavBarKey, @(hidesNavigationBarWhenPushed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hidesNavigationBarWhenPushed {
    return [objc_getAssociatedObject(self, &kHideNavBarKey) boolValue];
}

@end

static char kStatisticsPageTitleIndentifier;
@implementation UIViewController (Statistics)

- (NSString *)statisticsPageTitle{
    return objc_getAssociatedObject(self, &kStatisticsPageTitleIndentifier);
}

- (void)setStatisticsPageTitle:(NSString*)title {
    if (title.length) {
        objc_setAssociatedObject(self, &kStatisticsPageTitleIndentifier, title, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }else {
        objc_setAssociatedObject(self, &kStatisticsPageTitleIndentifier, NSStringFromClass([self class]), OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

@end