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

@implementation UIViewController (Statistics)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalDidAppearSelector = @selector(viewDidAppear:);
        SEL swizzledDidAppearSelector = @selector(cd_viewDidAppear:);
        Method originalDidAppearMethod = class_getInstanceMethod(self, originalDidAppearSelector);
        Method swizzledDidAppearMethod = class_getInstanceMethod(self, swizzledDidAppearSelector);
        
        BOOL didAddDidAppearMethod = class_addMethod(class,
                                                     originalDidAppearSelector,
                                                     method_getImplementation(swizzledDidAppearMethod),
                                                     method_getTypeEncoding(swizzledDidAppearMethod));
        if (!didAddDidAppearMethod) {
            method_exchangeImplementations(originalDidAppearMethod, swizzledDidAppearMethod);
        }
//        else {
//            class_replaceMethod(class,
//                                swizzledDidAppearSelector,
//                                method_getImplementation(originalDidAppearMethod),
//                                method_getTypeEncoding(originalDidAppearMethod));
//        }
        
        SEL originalDidDisappearSelector = @selector(viewDidDisappear:);
        SEL swizzledDidDisappearSelector = @selector(cd_viewDidDisappear:);
        Method originalDidDisappearMethod = class_getInstanceMethod(self, originalDidDisappearSelector);
        Method swizzledDidDisappearMethod = class_getInstanceMethod(self, swizzledDidDisappearSelector);
        
        BOOL didAddDidDisappearMethod = class_addMethod(class,
                                                     originalDidDisappearSelector,
                                                     method_getImplementation(swizzledDidDisappearMethod),
                                                     method_getTypeEncoding(swizzledDidDisappearMethod));
        if (!didAddDidDisappearMethod) {
            method_exchangeImplementations(originalDidDisappearMethod, swizzledDidDisappearMethod);
        }
//        else {
//            class_replaceMethod(class,
//                                swizzledDidDisappearSelector,
//                                method_getImplementation(originalDidDisappearMethod),
//                                method_getTypeEncoding(originalDidDisappearMethod));
//        }
    });
}

- (void)cd_viewDidAppear:(BOOL)animated{
    [self cd_viewDidAppear:animated];
//#warning TODO 可在此处加入页面统计
}

- (void)cd_viewDidDisappear:(BOOL)animated{
    [self cd_viewDidDisappear:animated];
//#warning TODO 可在此处加入页面统计
}

@end