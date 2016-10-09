//
//  UIView+CDViewAdditions.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIView (CDCategory)

//  左边间距
@property (nonatomic) CGFloat left;

//  顶部间距
@property (nonatomic) CGFloat top;

//  右边间距
@property (nonatomic) CGFloat right;

//  底部间距
@property (nonatomic) CGFloat bottom;

//  左上角
@property (nonatomic) CGPoint leftTop;

//  左下角
@property (nonatomic) CGPoint leftBottom;

//  右上角
@property (nonatomic) CGPoint rightTop;

//  右下角
@property (nonatomic) CGPoint rightBottom;

//  宽度
@property (nonatomic) CGFloat width;

//  高度
@property (nonatomic) CGFloat height;

//  X轴中心点
@property (nonatomic) CGFloat centerX;

//  Y轴中心点
@property (nonatomic) CGFloat centerY;

//  起始点
@property (nonatomic) CGPoint origin;

//  尺寸大小
@property (nonatomic) CGSize size;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIView (CDBackView)

- (void)showView:(UIView *)view backViewAlpha:(CGFloat)a target:(id)target touchAction:(SEL)selector animation:(void(^)(void))animation timeInterval:(NSTimeInterval)interval finished:(void(^)(BOOL finished))fininshed;

- (void)showView:(UIView *)view backViewAlpha:(CGFloat)a target:(id)target touchAction:(SEL)selector;

- (void)hideView:(UIView *)view animation:(void(^)(void))animation timeInterval:(NSTimeInterval)interval fininshed:(void(^)(BOOL complation))fininshed;

- (void)hideView:(UIView *)view;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIView (CDWatermark)

- (void)showDefaultWatermarkTarget:(id)target action:(SEL)action;

- (void)showWatermark:(NSString *)imageName target:(id)target action:(SEL)action;

- (void)hideWatermark;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIView (CDBadge)

- (void)showBadge;

- (void)removeBadge;

@end
