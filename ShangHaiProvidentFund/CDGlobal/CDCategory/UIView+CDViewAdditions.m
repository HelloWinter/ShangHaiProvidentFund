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

@implementation UIView (CDCategory)

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

- (CGPoint)leftTop {
    return CGPointMake(self.left, self.top);
}

- (void)setLeftTop:(CGPoint)leftTop {
    self.left = leftTop.x;
    self.top = leftTop.y;
}

- (CGPoint)leftBottom {
    return CGPointMake(self.left, self.bottom);
}

- (void)setLeftBottom:(CGPoint)leftBottom {
    self.left = leftBottom.x;
    self.bottom = leftBottom.y;
}

- (CGPoint)rightTop {
    return CGPointMake(self.right, self.top);
}

- (void)setRightTop:(CGPoint)rightTop {
    self.right = rightTop.x;
    self.top = rightTop.y;
}

- (CGPoint)rightBottom {
    return CGPointMake(self.right, self.bottom);
}

- (void)setRightBottom:(CGPoint)rightBottom {
    self.right = rightBottom.x;
    self.bottom = rightBottom.y;
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

- (void)cd_showView:(UIView *)view backViewAlpha:(CGFloat)a target:(id)target touchAction:(SEL)selector animation:(void(^)(void))animation timeInterval:(NSTimeInterval)interval finished:(void(^)(BOOL finished))fininshed{
    [self cd_showView:view
     backViewAlpha:a
            target:target
       touchAction:selector];
    [UIView animateWithDuration:interval
                     animations:animation
                     completion:fininshed];
}

- (void)cd_showView:(UIView *)view backViewAlpha:(CGFloat)a target:(id)target touchAction:(SEL)selector{
    UIView* backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor=[UIColor colorWithWhite:0 alpha:a];
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [backView addGestureRecognizer:gesture];
    
    [self addSubview:backView];
    [self addSubview:view];
    objc_setAssociatedObject(self, kBackViewIdentifier, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cd_hideView:(UIView *)view animation:(void(^)(void))animation timeInterval:(NSTimeInterval)interval fininshed:(void(^)(BOOL complation))fininshed{
    [UIView animateWithDuration:interval
                     animations:animation
                     completion:^(BOOL finish){
                         [self cd_hideView:view];
                         if (fininshed) {
                             fininshed(finish);
                         }
                     }];
}

- (void)cd_hideView:(UIView *)view{
    UIView* backView = objc_getAssociatedObject(self, kBackViewIdentifier);
    [view removeFromSuperview];
    [backView removeFromSuperview];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

static const void *kDefaultWatermarkKey = &kDefaultWatermarkKey;

@implementation UIView (CDWatermark)

- (void)cd_showDefaultWatermarkTarget:(id)target action:(SEL)action {
    [self cd_showWatermark:@"nonedata" target:(id)target action:(SEL)action];
}

- (void)cd_showWatermark:(NSString *)imageName target:(id)target action:(SEL)action {
    UIImageView *watermark = [self watermark];
    if (!watermark.superview) {
        if (target && action) {
            watermark.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
            [watermark addGestureRecognizer:tapGesture];
        }
        [self addSubview:watermark];
    }
    UIImage *image = [UIImage imageNamed:imageName];
    watermark.size = image.size;
    watermark.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    watermark.image=image;
}

- (void)cd_hideWatermark {
    UIImageView *watermark = [self watermark];
    if (watermark && watermark.superview) {
        if (watermark.gestureRecognizers.count!=0) {
            UIGestureRecognizer *gesrure = [watermark.gestureRecognizers objectAtIndex:0];
            if (gesrure) {
                [watermark removeGestureRecognizer:gesrure];
            }
        }
        [watermark removeFromSuperview];
        objc_setAssociatedObject(self, kDefaultWatermarkKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIImageView *)watermark{
    UIImageView *watermark = objc_getAssociatedObject(self, kDefaultWatermarkKey);
    if (!watermark) {
        watermark = [[UIImageView alloc] init];
        objc_setAssociatedObject(self, kDefaultWatermarkKey, watermark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return watermark;
    }else{
        return watermark;
    }
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

static const void *kBadgeViewIdentifier = &kBadgeViewIdentifier;
static const void *kBadgeStringViewIdentifier = &kBadgeStringViewIdentifier;

@implementation UIView (CDBadge)

- (void)cd_showBadge{
    UIView *badgeView=objc_getAssociatedObject(self, kBadgeViewIdentifier);
    if (badgeView==nil) {
        CGFloat badgeWidth=8;
        badgeView = [[UIView alloc]init];
        badgeView.backgroundColor = [UIColor redColor];
        badgeView.size = CGSizeMake(badgeWidth, badgeWidth);
        badgeView.center=CGPointMake(self.width-badgeWidth*0.5, badgeWidth*0.5);
        badgeView.layer.cornerRadius = badgeView.frame.size.width*0.5;
        objc_setAssociatedObject(self, kBadgeViewIdentifier, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (!badgeView.superview) {
        [self addSubview:badgeView];
        [self bringSubviewToFront:badgeView];
    }
}

- (void)cd_removeBadge{
    UIView *badgeView=objc_getAssociatedObject(self, kBadgeViewIdentifier);
    if (badgeView) {
        if (badgeView.superview) {
            [badgeView removeFromSuperview];
        }
        objc_setAssociatedObject(self, kBadgeViewIdentifier, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
///////////////////////////////////////////////////////////////////////////////////////////
- (void)cd_showBadgeString:(NSString *)str{
    UILabel *label=objc_getAssociatedObject(self, kBadgeStringViewIdentifier);
    if (label==nil) {
        label=[[UILabel alloc]init];
        label.textColor=[UIColor whiteColor];
        label.backgroundColor=[UIColor redColor];
        label.font=[UIFont systemFontOfSize:10];
        label.textAlignment=NSTextAlignmentCenter;
        objc_setAssociatedObject(self, kBadgeStringViewIdentifier, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:8]}];
    CGFloat labelWidth=size.width+size.height;
    CGFloat labelHeight=size.height+2;
    label.size = CGSizeMake(labelWidth, labelHeight);
    label.center=CGPointMake(self.width-labelWidth*0.5, labelHeight*0.5);
    label.layer.cornerRadius = labelHeight*0.5;
    label.layer.masksToBounds=YES;
    label.text=str;
    if (!label.superview) {
        [self addSubview:label];
        [self bringSubviewToFront:label];
    }
}

- (void)cd_removeBadgeString{
    UILabel *label=objc_getAssociatedObject(self, kBadgeStringViewIdentifier);
    if (label) {
        if (label.superview) {
            [label removeFromSuperview];
        }
        objc_setAssociatedObject(self, kBadgeStringViewIdentifier, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
