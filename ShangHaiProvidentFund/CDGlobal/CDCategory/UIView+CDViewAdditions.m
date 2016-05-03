//
//  UIView+CDViewAdditions.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "UIView+CDViewAdditions.h"
#import <objc/runtime.h>

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIView (CDGeometry)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

static const void *kBackViewIdentifier = &kBackViewIdentifier;

@implementation UIView (CDBackView)

- (void)cd_showView:(UIView *)view WithBackViewAlpha:(CGFloat)a Target:(id)target TouchAction:(SEL)selector{
    UIView* backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = a;
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [backView addGestureRecognizer:gesture];
    
    objc_setAssociatedObject(self, kBackViewIdentifier, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addSubview:backView];
    [self addSubview:view];
}

- (void)cd_showView:(UIView *)view WithBackViewAlpha:(CGFloat)a Target:(id)target TouchAction:(SEL)selector Animation:(void(^)(void))animation TimeInterval:(NSTimeInterval)interval Fininshed:(void(^)(BOOL finished))fininshed{
    [self cd_showView:view WithBackViewAlpha:a Target:target TouchAction:selector];
    [UIView animateWithDuration:interval
                     animations:animation
                     completion:fininshed];
}

- (void)cd_hideBackViewForView:(UIView *)view
                  animation:(void(^)(void))animation
               timeInterval:(NSTimeInterval)interval
                  fininshed:(void(^)(BOOL complation))fininshed{
    __block typeof(self) block_self = self;
    [UIView animateWithDuration:interval
                     animations:animation
                     completion:^(BOOL finish){
                         [block_self cd_hideBackViewForView:view];
                         if (fininshed) {
                             fininshed(finish);
                         }
                     }];
}

- (void)cd_hideBackViewForView:(UIView *)view{
    UIView* backView = objc_getAssociatedObject(self, kBackViewIdentifier);
    [view removeFromSuperview];
    [backView removeFromSuperview];
}

- (UIView*)backView{
    UIView* backView = objc_getAssociatedObject(self, kBackViewIdentifier);
    return backView;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

static const void *kDefaultWatermarkKey = &kDefaultWatermarkKey;
static const NSTimeInterval kAnimationDuration = 0.2;

@implementation UIView (CDWatermark)

- (void)cd_showWatermark:(NSString *)imageName animated:(BOOL)animated Target:(id)target Action:(SEL)action{
    UIImageView *watermark = [self watermark:imageName];
    if (!watermark.superview) {
        if (action) {
            watermark.userInteractionEnabled=YES;
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:target action:action];
            [watermark addGestureRecognizer:tapGesture];
        }
        [self addSubview:watermark];
        watermark.alpha = 0;
        [UIView animateWithDuration:(animated ? kAnimationDuration : 0) animations:^{
            watermark.alpha = 1;
        } completion:nil];
    }
}

- (void)cd_hideWatermark:(BOOL)animated {
    UIImageView *watermark = [self watermark:nil];
    if (watermark && watermark.superview) {
        [UIView animateWithDuration:(animated ? kAnimationDuration : 0) animations:^{
            watermark.alpha = 0;
        } completion:^(BOOL finished) {
            [watermark removeFromSuperview];
            if (watermark.gestureRecognizers.count!=0) {
                UIGestureRecognizer *gesrure = [watermark.gestureRecognizers objectAtIndex:0];
                if (gesrure) {
                    [watermark removeGestureRecognizer:gesrure];
                }
            }
        }];
    }
}

- (UIImageView *)watermark:(NSString *)name {
    UIImageView *watermark = objc_getAssociatedObject(self, kDefaultWatermarkKey);
    if (watermark) {
        return watermark;
    }
    
    if (!watermark && name.length) {
        UIImage *image = [UIImage imageNamed:name];
        watermark = [[UIImageView alloc] initWithImage:image];
        watermark.size = image.size;
        watermark.center = CGPointMake(self.width * 0.5, self.height * 0.5);
        objc_setAssociatedObject(self, kDefaultWatermarkKey, watermark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return watermark;
    }
    return nil;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIView (CDHierarchy)

- (BOOL)cd_includeSubviewInHierarchy:(UIView *)view {
    for (UIView *subview in self.subviews) {
        if (subview == view) {
            return YES;
        }
        if ([subview cd_includeSubviewInHierarchy:view]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)cd_isIncludedInSuperviewHierarchy:(UIView *)view {
    return [view cd_includeSubviewInHierarchy:self];
}

- (UIResponder *)cd_getFirstResponder {
    for (UIView *subview in self.subviews) {
        if (subview.isFirstResponder) {
            return subview;
        }
        UIResponder *responder = [subview cd_getFirstResponder];
        if (responder) {
            return responder;
        }
    }
    return nil;
}

- (UITextField *)cd_getFirstResponderTextField {
    UIResponder *textField = [self cd_getFirstResponder];
    if ([textField isKindOfClass:[UITextField class]]) {
        return (UITextField *)textField;
    }
    return nil;
}

@end
