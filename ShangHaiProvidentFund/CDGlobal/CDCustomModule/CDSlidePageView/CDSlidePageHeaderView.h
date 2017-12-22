//
//  CDSlidePageHeaderView.h
//  CDAppDemo
//
//  Created by cdd on 16/4/28.
//  Copyright © 2016年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDSlidePageHeaderViewDelegate;

@interface CDSlidePageHeaderView : UIView

/**
 *  itemTitles
 */
@property (nonatomic, copy) NSArray<NSString *> *itemTitles;

/**
 每个item的宽度
 */
@property (nonatomic, assign) CGFloat itemWidth;

/**
 *  badgeNumbers 未读消息数组
 */
@property (nonatomic, copy) NSArray<NSString *> *badgeNumbers;

/**
 *  普通状态颜色,default：lightGrayColor
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 *  选中状态颜色,default：redColor
 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 *  选中状态下是否显示粗体
 */
@property (nonatomic, assign) BOOL isBoldFont;

/**
 *  标题字体，default：15
 */
@property (nonatomic, assign) NSInteger fontSize;

/**
 *  选中索引，default:0
 */
@property (nonatomic) NSUInteger selectedIndex;

/**
 *  小滑动条
 */
@property (nonatomic, strong, readonly) UIView *sliderView;

/**
 *  小滑动条size，CGSizeZero ： CGSizeMake(width, 2.0)
 */
@property (nonatomic) CGSize sliderSize;

/**
 所有item所占的大小
 */
@property (nonatomic, readonly) CGSize contentSize;

@property (nonatomic, weak) id<CDSlidePageHeaderViewDelegate> delegate;

- (void)reload;

@end

@protocol CDSlidePageHeaderViewDelegate <NSObject>

@optional
- (void)slidePageHeaderView:(CDSlidePageHeaderView *)headerView willSelectButtonAtIndex:(NSUInteger)index;

- (void)slidePageHeaderView:(CDSlidePageHeaderView *)headerView didSelectButtonAtIndex:(NSUInteger)index;

@end

