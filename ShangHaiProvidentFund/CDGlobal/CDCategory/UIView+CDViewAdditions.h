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

@interface UIView (CDGeometry)

/**
 视图左边界值
 */
@property (nonatomic) CGFloat left;
/**
 视图顶部边界值
 */
@property (nonatomic) CGFloat top;
/**
 视图右边界值
 */
@property (nonatomic) CGFloat right;
/**
 视图底部边界值
 */
@property (nonatomic) CGFloat bottom;
/**
 视图宽度
 */
@property (nonatomic) CGFloat width;
/**
 视图高度
 */
@property (nonatomic) CGFloat height;
/**
 视图中心点X坐标
 */
@property (nonatomic) CGFloat centerX;
/**
 视图中心点Y坐标
 */
@property (nonatomic) CGFloat centerY;
/**
 视图起始坐标
 */
@property (nonatomic) CGPoint origin;
/**
 视图size(宽,高)
 */
@property (nonatomic) CGSize size;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIView (CDBackView)

@property (nonatomic,readonly)UIView* backView;

/**
 *  显示一个带黑色半透明背景的视图
 *  @param view 要显示的视图
 *  @param a 黑色半透明背景的透明度
 *  @param target
 *  @param selector
 */
- (void)cd_showView:(UIView *)view WithBackViewAlpha:(CGFloat)a Target:(id)target TouchAction:(SEL)selector;

/**
 *  显示一个带黑色半透明背景的视图
 */
- (void)cd_showView:(UIView *)view WithBackViewAlpha:(CGFloat)a Target:(id)target TouchAction:(SEL)selector Animation:(void(^)(void))animation TimeInterval:(NSTimeInterval)interval Fininshed:(void(^)(BOOL finished))fininshed;

/**
 *  隐藏带黑色半透明背景的视图
 */
- (void)cd_hideBackViewForView:(UIView *)view
                  animation:(void(^)(void))animation
               timeInterval:(NSTimeInterval)interval
                  fininshed:(void(^)(BOOL complation))fininshed;
/**
 *  隐藏带黑色半透明背景的视图
 */
- (void)cd_hideBackViewForView:(UIView *)view;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIView (CDWatermark)

/**
 *  显示视图背景水印（通常用于无数据时的页面展示）
 *
 *  @param imageName 水印图片名称
 *  @param animated  动画效果
 *  @param target    点击水印响应接受者
 *  @param action    点击水印后操作
 */
- (void)cd_showWatermark:(NSString *)imageName animated:(BOOL)animated Target:(id)target Action:(SEL)action;

/**
 *  隐藏视图背景水印
 *
 *  @param animated 动画
 */
- (void)cd_hideWatermark:(BOOL)animated;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIView (CDHierarchy)

/**
 *  视图是否包含某一子视图
 *
 *  @param view 视图
 *
 *  @return (BOOL)
 */
- (BOOL)cd_includeSubviewInHierarchy:(UIView *)view;

/**
 *  视图是否是某一视图的子视图
 *
 *  @param view 视图
 *
 *  @return (BOOL)
 */
- (BOOL)cd_isIncludedInSuperviewHierarchy:(UIView *)view;

/**
 *  返回视图的第一响应UITextField
 *
 *  @return (UITextField *)
 */
- (UITextField *)cd_getFirstResponderTextField;

@end
