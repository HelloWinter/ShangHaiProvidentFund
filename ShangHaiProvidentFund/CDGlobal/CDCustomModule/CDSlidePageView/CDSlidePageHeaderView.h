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
 *  滑动条size，default：CGSizeZero
 */
@property (nonatomic) CGSize sliderSize;

/**
 *  itemTitles
 */
@property (nonatomic, copy) NSArray<NSString *> *itemTitles;

/**
 *  普通状态颜色,default：lightGrayColor
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 *  选中状态颜色,default：redColor
 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 *  选中索引，default:0
 */
@property (nonatomic) NSUInteger selectedIndex;

/**
 *  滑动条
 */
@property (nonatomic, strong, readonly) UIView *sliderView;

@property (nonatomic, weak) id<CDSlidePageHeaderViewDelegate> delegate;

- (void)reload;

@end

@protocol CDSlidePageHeaderViewDelegate <NSObject>

@optional
- (void)slidePageHeaderView:(CDSlidePageHeaderView *)headerView willSelectButtonAtIndex:(NSUInteger)index;

- (void)slidePageHeaderView:(CDSlidePageHeaderView *)headerView didSelectButtonAtIndex:(NSUInteger)index;

@end
