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

//  左边（X坐标）
@property (nonatomic) CGFloat left;

//  顶部（Y坐标）
@property (nonatomic) CGFloat top;

//  右边
@property (nonatomic) CGFloat right;

//  底部
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

- (void)cd_showView:(UIView *)view backViewAlpha:(CGFloat)a target:(id)target touchAction:(SEL)selector animation:(void(^)(void))animation timeInterval:(NSTimeInterval)interval finished:(void(^)(BOOL finished))fininshed;

- (void)cd_showView:(UIView *)view backViewAlpha:(CGFloat)a target:(id)target touchAction:(SEL)selector;

- (void)cd_hideView:(UIView *)view animation:(void(^)(void))animation timeInterval:(NSTimeInterval)interval fininshed:(void(^)(BOOL complation))fininshed;

- (void)cd_hideView:(UIView *)view;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIView (CDWatermark)

- (void)cd_showDefaultWatermarkTarget:(id)target action:(SEL)action;

- (void)cd_showWatermark:(NSString *)imageName target:(id)target action:(SEL)action;

- (void)cd_hideWatermark;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIView (CDBadge)

/**
 在右上角显示小红点
 */
- (void)cd_showBadge;

/**
 移除右上角小红点
 */
- (void)cd_removeBadge;

/**
 右上角显示文字
 */
- (void)cd_showBadgeString:(NSString *)str;

/**
 移除右上角文字
 */
- (void)cd_removeBadgeString;

@end
