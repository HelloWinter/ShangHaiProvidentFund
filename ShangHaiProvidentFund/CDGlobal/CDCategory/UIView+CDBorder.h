//
//  UIView+CDBorder.h
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/28.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//  边框线类型
typedef NS_OPTIONS(NSUInteger, CDBorderStyle) {
    CDBorderStyleNone = 0,//没有边框线
    CDBorderStyleTop = 1 << 0,//顶部边框线
    CDBorderStyleLeft = 1 << 1,//左边边框线
    CDBorderStyleBottom = 1 << 2,//底部边框线
    CDBorderStyleRight = 1 << 3//右边边框线
};

@interface UIView (CDBorder)

/**
 设置边框类型，默认CDBorderStyleNone
 */
- (void)cd_setBorderStyle:(CDBorderStyle)style;

/**
 设置边框颜色，默认blackColor
 */
- (void)cd_setBorderColor:(UIColor *)color;

/**
 设置边框线宽，默认0.5
 */
- (void)cd_setBorderWidth:(CGFloat)width;

/**
 设置边框内边距，默认UIEdgeInsetsZero
 */
- (void)cd_setBorderInsets:(UIEdgeInsets)insets;

@end

NS_ASSUME_NONNULL_END
